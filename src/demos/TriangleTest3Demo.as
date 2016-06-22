package demos {
	import flash.geom.Rectangle;

	import harayoki.starling2.FixedLayoutBitmapTextController;

	import harayoki.starling2.display.Triangle;
	import harayoki.starling2.utils.AssetManager;
	
	import misc.*;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class TriangleTest3Demo extends DemoBase {

		private var _stars:Vector.<DisplayObject>;
		private var _useStarTexture:Boolean = true;
		private var _moving:Boolean = true;
		private var _numQuad:int = 0;
		private var _numTriangle:int = 0;
		private var _texForQuad:Texture;
		private var _texForTriangle:Texture;
		private var _texWhite:Texture;
		private var _infoTextControl1:FixedLayoutBitmapTextController;
		private var _infoTextControl2:FixedLayoutBitmapTextController;
		private var _title:DisplayObject;

		public function TriangleTest3Demo(assetManager:harayoki.starling2.utils.AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function getBackgroundDisplay():DisplayObject {
			var bg:Image = new Image(_assetManager.getTexture("gradation_mono"));
			bg.textureSmoothing = TextureSmoothing.NONE;
			bg.alpha = 0.25;
			return bg;
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var btn:DisplayObject;
			var bgTexture:Texture = _assetManager.getTexture("border1");

			var infoTextControl1:FixedLayoutBitmapTextController;
			infoTextControl1 = new FixedLayoutBitmapTextController(MyFontManager.baseFont.name, "XXXXXXX");
			infoTextControl1.setText("tex  ON");
			btn = _demoHelper.createButton(infoTextControl1.displayObject, function():void {
				_useStarTexture = !_useStarTexture;
				if(_useStarTexture) {
					infoTextControl1.setText("tex  ON");
				} else {
					infoTextControl1.setText("tex OFF");
				}
			}, bgTexture);
			out.push(btn);

			var infoTextControl2:FixedLayoutBitmapTextController;
			infoTextControl2 = new FixedLayoutBitmapTextController(MyFontManager.baseFont.name, "XXXXXX");
			infoTextControl2.setText("moving");
			btn = _demoHelper.createButton(infoTextControl2.displayObject, function():void {
				_moving = !_moving;
				if(_moving) {
					infoTextControl2.setText("moving");
				} else {
					infoTextControl2.setText("stop");
				}
			}, bgTexture);
			out.push(btn);

			btn = _demoHelper.createButton(createDemoText("Clear"), function():void {
				_clearStars();
			}, bgTexture);
			out.push(btn);

			out.push(null);

			btn = _demoHelper.createButton(createDemoText("Make 25 Quads"), function():void {
				_makeQuad(25);
			}, bgTexture);
			out.push(btn);

			btn = _demoHelper.createButton(createDemoText("Make many Quads"), function():void {
				_makeQuad(500);
			}, bgTexture);
			out.push(btn);

			btn = _demoHelper.createButton(createDemoText("Make 25 Triangles"), function():void {
				_makeTriangle(25);
			}, bgTexture);
			out.push(btn);

			btn = _demoHelper.createButton(createDemoText("Make many Triangles"), function():void {
				_makeTriangle(500);
			}, bgTexture);
			out.push(btn);

			return out;
		}


		public override function start():void {

			_stars = new <DisplayObject>[];

			_texForQuad = _assetManager.getTexture("quad_star");
			_texForTriangle = _assetManager.getTexture("topleft_star");
			_texWhite = _assetManager.getTexture("white");

			_title = createDemoText("QUAD and TRIANGLE", Align.CENTER);
			_title.x -= 160;
			_title.y = 15;
			_title.scale = 2;

			_updateInfo();

			addEventListener(Event.ENTER_FRAME, function():void{
				if(!_moving) {
					return;
				}
				for each(var disp:DisplayObject in _stars) {
					_update(disp);
				}
			});

		}

		private function _makeQuad(num:int=1):void {
			_numQuad +=num;
			while(num--) {
				var quad:Quad;
				if(_useStarTexture) {
					quad = Quad.fromTexture(_texForQuad); // 16px * 16px
				} else {
					quad = new Quad(_texForQuad.width, _texForQuad.height);
					 quad.texture = _texWhite; // drawコールをまとめるためにテクスチャを設定
					quad.color = 0x00ffff;
				}
				quad.textureSmoothing = TextureSmoothing.NONE;
				_stars.push(quad);
				quad.pivotX = quad.width >> 1;
				quad.pivotY = quad.height >> 1;
				_randomLocate(quad);
			}
			_updateInfo();
		}
		private function _makeTriangle(num:int=1):void {
			_numTriangle += num;
			while(num--) {
				var tri:Triangle;
				if(_useStarTexture) {
					 tri = Triangle.fromTexture(_texForTriangle); // 32px * 32px
				} else {
					tri = new Triangle(_texForTriangle.width, _texForTriangle.height);
					 tri.texture = _texWhite; // drawコールをまとめるためにテクスチャを設定
					tri.color = 0xffff00;
				}
				tri.textureSmoothing = TextureSmoothing.NONE;
				tri.pivotX = tri.width >> 2;
				tri.pivotY = tri.height >> 2;
				_stars.push(tri);
				_randomLocate(tri);
			}
			_updateInfo();
		}

		private function _randomLocate(disp:DisplayObject):DisplayObject {
			disp.touchable = false;
			disp.x = ~~(Math.random() * 320);
			disp.y = 20 +  ~~(Math.random() * (480 -40));
			// disp.scale = 1.0 + Math.random();
			disp.alpha = 1.0;
			addChildAt(disp, ~~(Math.random()* numChildren));
			return disp;
		}

		private function _updateInfo():void {

			var disp:DisplayObject;
			if(!_infoTextControl1) {
				_infoTextControl1 = new FixedLayoutBitmapTextController(MyFontManager.baseFont.name, "000000 quads");
				disp = _infoTextControl1.displayObject;
				disp.x = 70;
				disp.y = 50;
			}
			if(!_infoTextControl2) {
				_infoTextControl2 = new FixedLayoutBitmapTextController(MyFontManager.baseFont.name, "000000 triangles");
				disp = _infoTextControl2.displayObject;
				disp.x = 160;
				disp.y = 50;
			}
			_infoTextControl1.setTextWithPadding(_numQuad+" quads");
			_infoTextControl2.setTextWithPadding(_numTriangle+" triangles");
			addChild(_infoTextControl1.displayObject);
			addChild(_infoTextControl2.displayObject);
			addChild(_title);
		}

		private function _clearStars():void {
			var i:int = _stars.length;
			while(i--) {
				_stars[i].removeFromParent(true);
			}
			_stars.length = 0;
			_numQuad = 0;
			_numTriangle = 0;
			_updateInfo();
		}

		private function _update(disp:DisplayObject):void {
			disp.rotation += 0.04 * disp.scale;
		}
	}
}
