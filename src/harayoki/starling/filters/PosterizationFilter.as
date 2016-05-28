package harayoki.starling.filters {

	import starling.filters.FragmentFilter;
	import starling.rendering.FilterEffect;

	public class PosterizationFilter extends FragmentFilter
	{
		public function PosterizationFilter(
			redDiv:uint=2, greenDiv:uint=4, blueDiv:uint=4, alphaDiv:uint=4):void
		{
			colorOffsetEffect.redDiv = redDiv;
			colorOffsetEffect.greenDiv = greenDiv;
			colorOffsetEffect.blueDiv = blueDiv;
			colorOffsetEffect.alphaDiv = alphaDiv;
		}

		override protected function createEffect():FilterEffect
		{
			return new PosterizationEffect();
		}

		private function get colorOffsetEffect():PosterizationEffect
		{
			return effect as PosterizationEffect;
		}

		public function get redDiv():uint { return colorOffsetEffect.redDiv; }
		public function set redDiv(value:uint):void
		{
			colorOffsetEffect.redDiv = value < 2 ? 2.0 : value;
			setRequiresRedraw();
		}

		public function get greenDiv():uint { return colorOffsetEffect.greenDiv; }
		public function set greenDiv(value:uint):void
		{
			colorOffsetEffect.greenDiv = value < 2 ? 2.0 : value;
			setRequiresRedraw();
		}

		public function get blueDiv():uint { return colorOffsetEffect.blueDiv; }
		public function set blueDiv(value:uint):void
		{
			colorOffsetEffect.blueDiv = value < 2 ? 2.0 : value;
			setRequiresRedraw();
		}

		public function get alphaDiv():uint { return colorOffsetEffect.alphaDiv; }
		public function set alphaDiv(value:uint):void
		{
			colorOffsetEffect.alphaDiv = value < 2 ? 2.0 : value;
			setRequiresRedraw();
		}

	}
}

import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;

import starling.rendering.FilterEffect;
import starling.rendering.Program;

class PosterizationEffect extends FilterEffect
{
	private var _divs0:Vector.<Number>;
	private var _divs1:Vector.<Number>;

	public function PosterizationEffect()
	{
		_divs0 = new Vector.<Number>(4, true);
		_divs1 = new Vector.<Number>(4, true);
	}

	override protected function createProgram():Program
	{
		var vertexShader:String = STD_VERTEX_SHADER;

			//回転行列を座標に掛け合わせる
			//"m44 op, va0, vc0 \n" +

			//カラーはそのまま受けわたす
			//"mov v0, va1";

		var fragmentShader:String = [

			// ft0(テンポラリ)にテクスチャカラーを取得するお決まりコード v0:texture coordinates fs0:texture参照
			tex("ft0", "v0", 0, texture), // tex == ft0, v0, fs0 <2d, linear>

			// PMA(premultiplied alpha)演算されているのを元の値に戻す  rgb /= a
			"div ft0.xyz, ft0.xyz, ft0.www",

			// 各チャンネルにRGBA定数値(fc0)を掛け合わせる
			"mul ft0, ft0, fc0",

			// ft0の小数点以下を破棄 ft1 = ft0 - float(ft0)、ft0 -= ft1
			"frc ft1, ft0",
			"sub ft0, ft0, ft1",

			// ft0を掛けた際より1小さい値(fc1)で割る 吸着処理
			"div ft0, ft0, fc1",

			// PMAをやり直す rgb *= a
			"mul ft0.xyz, ft0.xyz, ft0.www",

			// ft0(テンポラリ)の値を0~1の範囲におさめたものを出力(oc)
			"sat oc, ft0"].join("\n");

		return Program.fromSource(vertexShader, fragmentShader);
	}

	override protected function beforeDraw(context:Context3D):void
	{
		context.setProgramConstantsFromVector(
			Context3DProgramType.FRAGMENT,
			0,
			_divs0
		);
		context.setProgramConstantsFromVector(
			Context3DProgramType.FRAGMENT,
			1,
			_divs1
		);
		super.beforeDraw(context);
	}

	public function get redDiv():Number { return _divs0[0]; }
	public function set redDiv(value:Number):void { _divs0[0] = value; _divs1[0] = value - 1.0; }

	public function get greenDiv():Number { return _divs0[1]; }
	public function set greenDiv(value:Number):void { _divs0[1] = value; _divs1[1] = value - 1.0; }

	public function get blueDiv():Number { return _divs0[2]; }
	public function set blueDiv(value:Number):void { _divs0[2] = value; _divs1[2] = value - 1.0; }

	public function get alphaDiv():Number { return _divs0[3] + 1.0; }
	public function set alphaDiv(value:Number):void { _divs0[3] = value -1.0 ; _divs1[3] = value -1.0; }

}