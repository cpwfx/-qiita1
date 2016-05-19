package demos {
	import harayoki.starling.display.Triangle;

	import misc.*;
	import demos.DemoBase;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	import starling.utils.AssetManager;

	public class TriangleTest1Demo extends DemoBase {
		public function TriangleTest1Demo(assetManager:AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function getBottomButtons(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var bgTexure:Texture = _assetManager.getTexture("border1");

			var txt:DisplayObject;
			var btn:DisplayObject;

			txt = _demoHelper.createSpriteText("SHOW BORDER", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			btn = _demoHelper.createButton(txt, function ():void {
			}, bgTexure);
			out.push(btn);

			txt = _demoHelper.createSpriteText("HIDE BORDER", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			btn = _demoHelper.createButton(txt, function ():void {
			}, bgTexure);
			out.push(btn);

			return out;
		}

		public override function start():void {

			var white:Texture = _assetManager.getTexture("mx/F"); // colorchip white
			var pict1:Texture = _assetManager.getTexture("pict1");
			// var yohakuTofu:Texture = new SubTexture(tofu, null,false, new flash.geom.Rectangle(-2,-2,16,16));

			var tr1:Triangle = new Triangle(30, 30);
			tr1.x = 60;
			tr1.y = 100;
			tr1.textureSmoothing = TextureSmoothing.NONE;
			tr1.texture = white;
			tr1.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent){
				if(ev.getTouch(tr1, TouchPhase.BEGAN)) {
					trace("touched! tr1");
				}
			});

			var tr2:Triangle = new Triangle(10, 10, 0xffff00);
			tr2.x = 110;
			tr2.y = 100;
			tr2.rotation = -Math.PI * 0.2;
			tr2.textureSmoothing = TextureSmoothing.NONE;
			tr2.texture = white;
			tr2.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent){
				if(ev.getTouch(tr2, TouchPhase.BEGAN)) {
					trace("touched! tr2");
				}
			});

			var tr3:Triangle = Triangle.fromTexture(pict1);
			tr3.x = 150;
			tr3.y = 100;
			tr3.color = 0xffffff;
			tr3.scale = 1.0;
			tr3.textureSmoothing = TextureSmoothing.NONE;
			tr3.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent){
				if(ev.getTouch(tr3, TouchPhase.BEGAN)) {
					trace("touched! tr3");
				}
			});

			addChild(tr1);
			addChild(tr2);
			addChild(tr3);

			return;

			var bound1:Quad = Quad.fromTexture(white);
			var bound2:Quad = Quad.fromTexture(white);
			var bound3:Quad = Quad.fromTexture(white);

			bound1.alpha = 0.1;
			bound2.alpha = 0.1;
			bound3.alpha = 0.1;

			bound1.textureSmoothing = TextureSmoothing.NONE;
			bound2.textureSmoothing = TextureSmoothing.NONE;
			bound3.textureSmoothing = TextureSmoothing.NONE;

			addChild(bound1);
			addChild(bound2);
			addChild(bound3);

			_demoHelper.fitToBound(tr1, bound1);
			_demoHelper.fitToBound(tr2, bound2);
			_demoHelper.fitToBound(tr3, bound3);

		}
	}
}
