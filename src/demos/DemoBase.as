package demos {
	import feathers.controls.Check;

	import flash.geom.Rectangle;

	import misc.DemoHelper;
	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextFormat;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class DemoBase extends Sprite{

		internal var _starling:Starling;
		internal var _assetManager:AssetManager;
		internal var _demoHelper:DemoHelper;
		internal var _assets:Array;

		private var _workRect:flash.geom.Rectangle = new flash.geom.Rectangle();

		public var frontDisplay:Boolean = false;
		
		public function DemoBase(assetManager:AssetManager, starling:Starling=null) {
			_assets = [];
			_starling = starling ? starling : Starling.current;
			_assetManager = assetManager;
			_demoHelper = new DemoHelper(_starling, this, true);
		}

		public function addAssets(assets:Array):void {
			return;
		}
		public function getBackgroundDisplay():DisplayObject {
			return null;
		}

		public function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			return out;
		}

		public function start():void{

		}


		public function createDemoText(str:String, halign:String="left", target:DisplayObject=null):Sprite {
			var fmt:TextFormat = new TextFormat(
				MyFontManager.baseFont.name, MyFontManager.baseFont.size, 0xffffff, halign, Align.TOP);
			var sp:Sprite= _demoHelper.createSpriteTextWithTextFormat(
				fmt, str, 320, 20);
			if(target) {
				sp.x = target.x;
				sp.y = target.y;
			}
			sp.touchGroup = true;
			sp.touchable = false;
			return sp;
		}

		// isSelectedを外でつけるとハンドラが動くので注意
		public function createDemoCheckBox(callback:Function=null, isSelected:Boolean=false, target:DisplayObject=null):Check {
			var chk:Check = new Check();
			chk.scale = 0.5;
			if(target) {
				chk.x = target.x;
				chk.y = target.y;
			}
			chk.isSelected = isSelected;
			chk.addEventListener(Event.CHANGE, function(ev:Event):void {
				callback && callback();
			})
			return chk;
		}


		public function createDemoWrapSprite(displayObjects:Vector.<DisplayObject> , padding:int= 0, target:DisplayObject=null):Sprite {
			var xx:int = 0;
			var sp:Sprite = new Sprite();
			var hasCheckBox:Boolean = false;
			var i:int=0;
			for(i=0;i<displayObjects.length;i++) {
				if(displayObjects[i] is Check) {
					hasCheckBox = true;
				}
			}
			for(i=0;i<displayObjects.length;i++) {
				var dobj:DisplayObject = displayObjects[i];
				dobj.x = xx;
				sp.addChild(dobj);
				dobj.getBounds(sp, _workRect);
				if(dobj is Check) {
					// 大きさがうまく取れない
					var dummy:Quad = new Quad(1,1);
					dummy.alpha = 0;
					dummy.x = xx;
					dummy.y = dobj.y;
					sp.addChild(dummy);
					xx = dobj.x + 20 + padding;
				} else {
					if(hasCheckBox) dobj.y += 3;
					xx = _workRect.right + padding;
				}
			}
			if(target) {
				sp.x = target.x;
				sp.y = target.y;
			}
			return sp;
		}
	}
}
