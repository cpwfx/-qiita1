package harayoki.starling.styles {
	import starling.display.Mesh;
	import starling.rendering.MeshEffect;
	import starling.rendering.VertexDataFormat;
	import starling.styles.MeshStyle;

	public class PosterizationStyle extends MeshStyle {

		public static const VERTEX_FORMAT:VertexDataFormat =
			MeshStyle.VERTEX_FORMAT.extend("divs1:float4").extend("divs2:float4");

		private var _divs1:Vector.<Number>;
		private var _divs2:Vector.<Number>;

		public function PosterizationStyle(redDiv:uint=2, greenDiv:uint=4, blueDiv:uint=4, alphaDiv:uint=4):void {
			_divs1 = new Vector.<Number>(4, true);
			_divs2 = new Vector.<Number>(4, true);
			setTo(redDiv, greenDiv, blueDiv, alphaDiv);
		}

		public function setTo(redDiv:uint=2, greenDiv:uint=4, blueDiv:uint=4, alphaDiv:uint=4):void
		{
			_divs1[0] = Math.max(2.0, Math.abs(redDiv));
			_divs1[1] = Math.max(2.0, Math.abs(greenDiv));
			_divs1[2] = Math.max(2.0, Math.abs(blueDiv));
			_divs1[3] = Math.max(2.0, Math.abs(alphaDiv));

			_divs2[0] = _divs1[0] - 1.0;
			_divs2[1] = _divs1[1] - 1.0;
			_divs2[2] = _divs1[2] - 1.0;
			_divs2[3] = _divs1[3] - 1.0;

			updateVertices();
		}

		override public function copyFrom(meshStyle:MeshStyle):void {
			var posterizationStyle:PosterizationStyle = meshStyle as PosterizationStyle;
			if (posterizationStyle) {
				for (var i:int = 0; i < 4; ++i) {
					_divs1[i] = posterizationStyle._divs1[i];
					_divs2[i] = posterizationStyle._divs2[i];
				}
			}
			super.copyFrom(meshStyle);
		}

		override public function createEffect():MeshEffect
		{
			return new PosterizationEffect();
		}

		override protected function onTargetAssigned(target:Mesh):void
		{
			updateVertices();
		}

		override public function get vertexFormat():VertexDataFormat
		{
			return VERTEX_FORMAT;
		}

		private function updateVertices():void
		{
			if (target)
			{
				var numVertices:int = vertexData.numVertices;
				for (var i:int=0; i<numVertices; ++i) {
					vertexData.setPoint4D(i, "divs1",
						_divs1[0], _divs1[1], _divs1[2], _divs1[3]);
					vertexData.setPoint4D(i, "divs2",
						_divs2[0], _divs2[1], _divs2[2], _divs2[3]);
				}
				setRequiresRedraw();
			}
		}

		public function get redDiv():Number { return _divs1[0]; }
		public function set redDiv(value:Number):void
		{
			_divs1[0] = Math.max(2.0, Math.abs(value));
			_divs2[0] = _divs1[0] - 1.0;
			updateVertices();
		}

		public function get greenDiv():Number { return _divs1[1]; }
		public function set greenDiv(value:Number):void
		{
			_divs1[1] = Math.max(2.0, Math.abs(value));
			_divs2[1] = _divs1[1] - 1.0;
			updateVertices();
		}

		public function get blueDiv():Number { return _divs1[2]; }
		public function set blueDiv(value:Number):void
		{
			_divs1[2] = Math.max(2.0, Math.abs(value));
			_divs2[2] = _divs1[2] - 1.0;
			updateVertices();
		}

		public function get alphaDiv():Number { return _divs1[3]; }
		public function set alphaDiv(value:Number):void
		{
			_divs1[3] = Math.max(2.0, Math.abs(value));
			_divs2[3] = _divs1[3] - 1.0;
			updateVertices();
		}
	}
}

import flash.display3D.Context3D;

import harayoki.stage3d.agal.AGAL1CodePrinterForBaselineExtendedProfile;
import harayoki.starling.styles.PosterizationStyle;

import starling.rendering.MeshEffect;
import starling.rendering.Program;
import starling.rendering.VertexDataFormat;

class PosterizationEffect extends MeshEffect
{
	public  static const VERTEX_FORMAT:VertexDataFormat = PosterizationStyle.VERTEX_FORMAT;

	public function ColorOffsetEffect()
	{ }

	override protected function createProgram():Program
	{

		var useTexture:Boolean = !!texture;

		var vertexShaderPrinter:VertexShaderPrinter = new VertexShaderPrinter();
		vertexShaderPrinter.useTexture = useTexture;

		var fragmentShaderPrinter:FragmentShaderPrinter = new FragmentShaderPrinter();
		fragmentShaderPrinter.useTexture = useTexture;

		if(useTexture) {
			// ft0(テンポラリ)にテクスチャカラーを取得するお決まりコード
			fragmentShaderPrinter.prependCodeDirectly(tex("ft0", "v0", 0, texture));
		}

		return Program.fromSource(vertexShaderPrinter.print(), fragmentShaderPrinter.print());
	}

	override public function get vertexFormat():VertexDataFormat
	{
		return VERTEX_FORMAT;
	}

	override protected function beforeDraw(context:Context3D):void
	{
		super.beforeDraw(context);
		vertexFormat.setVertexBufferAt(3, vertexBuffer, "divs1");
		vertexFormat.setVertexBufferAt(4, vertexBuffer, "divs2");
	}

	override protected function afterDraw(context:Context3D):void
	{
		context.setVertexBufferAt(3, null);
		context.setVertexBufferAt(4, null);
		super.afterDraw(context);
	}
}

internal class VertexShaderPrinter extends AGAL1CodePrinterForBaselineExtendedProfile {

	public var useTexture:Boolean;

	public override function print():String {

		multiplyMatrix4x4(op, va0, vc0); // 4x4 matrix transform to output clip-space

		if(useTexture) {
			move(v0, va1); // pass texture coordinates to fragment program
			multiply(v1, va2, vc4); // multiply alpha (vc4) with color (va2), pass to fp
		} else {
			multiply(v0, va2, vc4); // multiply alpha (vc4) with color (va2)
		}

		move(v2, va3); // pass posterization1 to fp
		move(v3, va4); // pass posterization2 to fp

		return super.print();
	}
}

internal class FragmentShaderPrinter extends AGAL1CodePrinterForBaselineExtendedProfile {

	public var useTexture:Boolean;

	public override function print():String {

		if(useTexture) {
			multiply(ft0, ft0, v1); // multiply color with texel color
		} else {
			move(ft0, v0);
		}

		// _divs1の内容がv2に入っているのでft1に取り出す
		move(ft1, v2);

		// _divs2の内容がv3に入っているのでft2に取り出す
		move(ft2, v3);

		// PMA(premultiplied alpha)演算されているのを元の値に戻す  rgb /= a
		divide(ft0.xyz, ft0.xyz, ft0.www);

		// 各チャンネルにRGBA定数値(ft1)を掛け合わせる ft1はもういらないので次の命令で上書き
		multiply(ft0, ft0, ft1);

		// ft0の小数点以下を破棄 ft1 = ft0 - float(ft0)、ft0 -= ft1
		fractional(ft1, ft0);
		subtract(ft0, ft0, ft1);

		// ft0を掛けた際より1小さい値(ft2)で割る
		divide(ft0, ft0, ft2);

		// 1.0を超える部分ができるので正規化
		saturate(ft0, ft0);

		// PMAをやり直す rgb *= a
		multiply(ft0.xyz, ft0.xyz, ft0.www);

		// ocに出力
		move(oc, ft0);

		return super.print();
	}
}