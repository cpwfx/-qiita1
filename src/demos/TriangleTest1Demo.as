package demos {
	import flash.geom.Rectangle;

	import harayoki.starling.display.Triangle;

	import misc.*;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class TriangleTest1Demo extends DemoBase {

		public function TriangleTest1Demo(assetManager:AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function getBottomButtons(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var txt:DisplayObject;
			var btn:DisplayObject;

			var bgTexture:Texture = _assetManager.getTexture("border1");

			txt = _demoHelper.createSpriteText("SHOW BORDER", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			btn = _demoHelper.createButton(txt, function ():void {
			}, bgTexture);
			out.push(btn);

			txt = _demoHelper.createSpriteText("HIDE BORDER", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			btn = _demoHelper.createButton(txt, function ():void {
			}, bgTexture);
			out.push(btn);

			return out;
		}

		public override function start():void {

			var whiteTexture:Texture = _assetManager.getTexture("mx/F"); // colorchip white
			var pict1:Texture = _assetManager.getTexture("pict1");

			// 余白テスト用
			// var yohaku:Texture = new SubTexture(texture, null,false, new flash.geom.Rectangle(-2,-2,16,16));

			var tr1:Triangle = new Triangle(30, 30);
			tr1.x = 60;
			tr1.y = 100;
			tr1.texture = whiteTexture;
			_demoHelper.createButton(tr1, function(){
				trace("touched! tr1");
			});

			var tr2:Triangle = new Triangle(10, 10, 0xffff00);
			tr2.x = 110;
			tr2.y = 100;
			tr2.rotation = -Math.PI * 0.2;
			tr2.scale = 3.0;
			tr2.texture = whiteTexture;
			_demoHelper.createButton(tr2, function(){
				trace("touched! tr2");
			});

			var tr3:Triangle = Triangle.fromTexture(pict1);
			tr3.x = 160;
			tr3.y = 220;
			tr3.color = 0xffffff;
			tr3.scale = 1.0;
			tr3.pivotX = 30;
			tr3.pivotY = 30;
			_demoHelper.createButton(tr3, function(){
				trace("touched! tr3");
			});

			tr1.textureSmoothing =
			tr2.textureSmoothing =
			tr3.textureSmoothing = TextureSmoothing.NONE;

			addChild(tr1);
			addChild(tr2);
			addChild(tr3);

			var border1:DisplayObject = _createBorder();
			var border2:DisplayObject = _createBorder();
			var border3:DisplayObject = _createBorder();

			addChild(border1);
			addChild(border2);
			addChild(border3);

			addEventListener(Event.ENTER_FRAME, function():void{
				_update(tr1, border1);
				_update(tr2, border2);
				_update(tr3, border3);
			});

		}

		private function _createBorder():DisplayObject {
			var borderTexture:Texture = _assetManager.getTexture("box1line");
			var border:Image = new Image(borderTexture);
			border.textureSmoothing = TextureSmoothing.NONE;
			border.alpha = 0.2;
			border.color = 0x00ffff;
			border.scale9Grid = new flash.geom.Rectangle(4, 4, 1, 1);
			return border;
		}

		private function _update(tr:Triangle, border:DisplayObject):void {
			tr.rotation += 0.1;
			_demoHelper.fitToBound(tr, border);
		}
	}
}
