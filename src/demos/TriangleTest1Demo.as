package demos {
	import feathers.controls.Check;

	import flash.geom.Rectangle;

	import harayoki.starling.display.Triangle;

	import misc.*;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Mesh;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class TriangleTest1Demo extends DemoBase {

		private var _infoVisible:Boolean = true;
		public function TriangleTest1Demo(assetManager:AssetManager, starling:Starling = null) {
			// frontDisplay = true;
			super(assetManager, starling);
		}

		public override function getBackgroundDisplay():DisplayObject {
			var bg:Image = new Image(_assetManager.getTexture("white"));
			bg.textureSmoothing = TextureSmoothing.NONE;
			bg.color = 0x111111;
			return bg;
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var chk:Check = createDemoCheckBox(function():void{
				_infoVisible = chk.isSelected;
			});
			chk.isSelected = _infoVisible;
			out.push(createDemoWrapSprite(new <DisplayObject>[chk,createDemoText("INFO")]));

			return out;
		}

		public override function start():void {

			var pict:Texture = _assetManager.getTexture("pict1");
			// 余白テスト
			var pictWithFrame:Texture = new SubTexture(pict, null, false, new Rectangle(-5, -5, pict.width + 10, pict.height + 10));

			var bigScale:Number = 4.0;

			var pressingTr1:Boolean = false;
			var pressingTr2:Boolean = false;
			var pressingTr3:Boolean = false;

			var title:DisplayObject = createDemoText("TOUCH TRIANGLES", Align.CENTER);
			title.x -= 160;
			title.y = 10;
			title.scale = 2;
			addChild(title);

			var tr1:Mesh = new Triangle(30, 30);
			tr1.x = 160;
			tr1.y = 100;
			_demoHelper.setTouchHandler(tr1, function ():void {
				pressingTr1 = false;
			}, function ():void {
				tr1.scale *= 0.3;
				pressingTr1 = true;
			});

			var tr2:Mesh = new Triangle(10, 10, 0xffff00);
			tr2.x = 160;
			tr2.y = 200 - 20;
			tr2.scale = bigScale;
			tr2.skewX = -30 * Math.PI / 180;
			tr2.pivotX = 3;
			tr2.pivotY = 3;
			_demoHelper.setTouchHandler(tr2, function ():void {
				pressingTr2 = false;
			}, function ():void {
				pressingTr2 = true;
			});

			var tr3:Mesh = Triangle.fromTexture(pictWithFrame);
			tr3.x = 160;
			tr3.y = 300 + 10;
			tr3.pivotX = 48;
			tr3.pivotY = 48;
			_demoHelper.setTouchHandler(tr3, function ():void {
				pressingTr3 = false;
			}, function ():void {
				pressingTr3 = true;
			});

			// テクスチャの余白(frame)分を可視化
			var tr4:Mesh = new Triangle(128 + 10, 128 + 10);
			tr4.x = tr3.x;
			tr4.y = tr3.y;
			tr4.pivotX = tr3.pivotX;
			tr4.pivotY = tr3.pivotY;
			tr4.alpha = 0.1;
			tr4.touchable = false;

			tr1.textureSmoothing =
				tr2.textureSmoothing =
					tr3.textureSmoothing =
						tr4.textureSmoothing = TextureSmoothing.NONE;

			addChild(tr3); // texture
			addChild(tr4); // color
			addChild(tr2); // color
			addChild(tr1); // color

			var title1:DisplayObject = createDemoText("Normal", Align.CENTER, tr1);
			var title2:DisplayObject = createDemoText("Skew & Color & Scale & Pivot", Align.CENTER, tr2);
			var title3:DisplayObject = createDemoText("FromTexture & Frame & Pivot", Align.CENTER, tr3);

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
			addEventListener(Event.ENTER_FRAME, function ():void {
				theta += 0.05;
				_update(tr1, border1, pressingTr1 ? 0.5 : 1.25,
					pressingTr1 ? 0.5 : (1.0 + Math.sin(theta) * 0.2));
				_update(tr2, border2, pressingTr2 ? 0.5 : 1.25,
					pressingTr2 ? bigScale * 0.5 : bigScale * (1.0 + Math.sin(theta) * 0.2));
				_update(tr3, border3, pressingTr3 ? 0.5 : 1.25,
					pressingTr3 ? 0.5 : (1.0 + Math.sin(theta) * 0.2));
				_update(tr4, null, pressingTr3 ? 0.5 : 1.25,
					pressingTr3 ? 0.5 : (1.0 + Math.sin(theta) * 0.2));

				title1.visible = title2.visible = title3.visible = _infoVisible;
				cross1.visible = cross2.visible = cross3.visible = _infoVisible;

			});
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

		private function _update(tr:DisplayObject, border:DisplayObject, changeScaleRatio:Number = 0.2, baseScale:Number=1.0):void {
			tr.rotation += 0.02;
			tr.scale += (baseScale - tr.scale) * changeScaleRatio;
			if(border) {
				border.visible = _infoVisible;
				if(_infoVisible) {
					_demoHelper.fitToBound(tr, border);
				}
			}
		}
	}
}
