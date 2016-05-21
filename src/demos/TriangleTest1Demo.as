package demos {
	import flash.geom.Rectangle;

	import harayoki.starling.display.Triangle;

	import misc.*;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class TriangleTest1Demo extends DemoBase {

		private var _infoVisible:Boolean = true;
		public function TriangleTest1Demo(assetManager:AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function getBottomButtons(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var btn:DisplayObject;
			var bgTexture:Texture = _assetManager.getTexture("border1");

			btn = _demoHelper.createButton(_createText("INFO"), function():void {
				_infoVisible = !_infoVisible;
			}, bgTexture);
			out.push(btn);

			return out;
		}

		public override function start():void {

			var whiteTexture:Texture = _assetManager.getTexture("mx/F"); // colorchip white
			var pict1:Texture = _assetManager.getTexture("pict1");

			// 余白テスト用
			// var yohaku:Texture = new SubTexture(texture, null,false, new flash.geom.Rectangle(-2,-2,16,16));

			var pressingTr1:Boolean = false;
			var pressingTr2:Boolean = false;
			var pressingTr3:Boolean = false;

			var scale1:Number = 1.0;
			var scale2:Number = 3.0;
			var scale3:Number = 1.0;

			var title:DisplayObject = _createText("TOUCH TRIANGLES", Align.CENTER);
			title.x -= 160;
			title.y = 20;
			title.scale = 2;
			addChild(title);

			var tr1:Triangle = new Triangle(30, 30);
			tr1.x = 160;
			tr1.y = 130;
			//tr1.texture = whiteTexture;
			tr1.scale = scale1;
			_demoHelper.setTouchHandler(tr1, function():void{
				pressingTr1 = false;
			},function():void{
				tr1.scale *= 0.3;
				pressingTr1 = true;
			});

			var tr2:Triangle = new Triangle(10, 10, 0xffff00);
			tr2.x = 160;
			tr2.y = 230 - 10;
			// tr2.texture = whiteTexture;
			tr2.scale = scale2;
			tr2.skewX = -30 * Math.PI / 180;
			_demoHelper.setTouchHandler(tr2, function():void{
				pressingTr2 = false;
			},function():void{
				pressingTr2 = true;
			});

			var tr3:Triangle = Triangle.fromTexture(pict1);
			tr3.x = 160;
			tr3.y = 330;
			tr3.color = 0xffffff;
			tr3.pivotX = 48;
			tr3.pivotY = 48;
			tr3.scale = scale3;
			_demoHelper.setTouchHandler(tr3, function():void{
				pressingTr3 = false;
			},function():void{
				pressingTr3 = true;
			});

			tr1.textureSmoothing =
			tr2.textureSmoothing =
			tr3.textureSmoothing = TextureSmoothing.NONE;

			addChild(tr1);
			addChild(tr2);
			addChild(tr3);

			var title1:DisplayObject = _createText("Normal", Align.CENTER, tr1);
			var title2:DisplayObject = _createText("Skew & Color", Align.CENTER, tr2);
			var title3:DisplayObject = _createText("FromTexture & Pivot", Align.CENTER, tr3);

			title1.x -= 160;
			title2.x -= 160;
			title3.x -= 160;

			title1.y -= 40;
			title2.y -= 40;
			title3.y -= 40;

			addChild(title1);
			addChild(title2);
			addChild(title3);

			var border1:DisplayObject = _createBorder();
			var border2:DisplayObject = _createBorder();
			var border3:DisplayObject = _createBorder();

			addChildAt(border1, 0);
			addChildAt(border2, 0);
			addChildAt(border3, 0);

			var cross1:DisplayObject = _createCross(tr1);
			var cross2:DisplayObject = _createCross(tr2);
			var cross3:DisplayObject = _createCross(tr3);

			addChildAt(cross1, 0);
			addChildAt(cross2, 0);
			addChildAt(cross3, 0);

			var theta:Number = 0;
			addEventListener(Event.ENTER_FRAME, function():void{
				theta += 0.05;
				_update(tr1, border1, pressingTr1 ? 0.5 : 1.25,
					pressingTr1 ? scale1 * 0.5 : scale1 * (1.0 + Math.sin(theta) * 0.2));
				_update(tr2, border2, pressingTr2 ? 0.5 : 1.25,
					pressingTr2 ? scale2 * 0.5 : scale2 * (1.0 + Math.sin(theta) * 0.2));
				_update(tr3, border3, pressingTr3 ? 0.5 : 1.25,
					pressingTr3 ? scale3 * 0.5 : scale3 * (1.0 + Math.sin(theta) * 0.2));

				title1.visible = title2.visible = title3.visible = _infoVisible;
				cross1.visible = cross2.visible = cross3.visible = _infoVisible;

			});

		}

		private function _createText(str:String, halign:String="left", target:DisplayObject=null):DisplayObject {
			var fmt:TextFormat = new TextFormat(
				MyFontManager.baseFont.name, MyFontManager.baseFont.size, 0xffffff, halign, Align.TOP);
			var sp:Sprite = _demoHelper.createSpriteTextWithTextFormat(
				fmt, str, 320, 20);
			if(target) {
				sp.x = target.x;
				sp.y = target.y;
			}
			sp.touchGroup = true;
			sp.touchable = false;
			return sp;
		}

		private function _createCross(target:DisplayObject):DisplayObject {
			var sp:Sprite = new Sprite();
			sp.x = target.x;
			sp.y = target.y;
			var border1:DisplayObject = _createBorder(0x000000, 1.0);
			border1.scale = 1000;
			var border2:DisplayObject = _createBorder(0x000000, 1.0);
			border2.pivotX = 8;
			border2.pivotY = 8;
			border2.x = 1;
			border2.y = 1;
			border2.scale = 1000;
			sp.addChild(border1);
			sp.addChild(border2);
			return sp;
		}

		private function _createBorder(color:int=0x00ffff,alpha:Number=0.2):DisplayObject {
			var borderTexture:Texture = _assetManager.getTexture("box1line");
			var border:Image = new Image(borderTexture);
			border.textureSmoothing = TextureSmoothing.NONE;
			border.alpha = alpha;
			border.color = color;
			border.scale9Grid = new flash.geom.Rectangle(
				borderTexture.width >> 1, borderTexture.height >> 1, 1, 1);
			return border;
		}

		private function _update(tr:Triangle, border:DisplayObject, changeScaleRatio:Number = 0.2, baseScale:Number=1.0):void {
			tr.rotation += 0.02;
			tr.scale += (baseScale - tr.scale) * changeScaleRatio;
			border.visible = _infoVisible;
			_demoHelper.fitToBound(tr, border);
		}
	}
}
