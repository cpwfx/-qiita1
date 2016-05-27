package demos {
	import misc.DemoHelper;
	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.text.TextFormat;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class DemoBase extends Sprite{

		internal var _starling:Starling;
		internal var _assetManager:AssetManager;
		internal var _demoHelper:DemoHelper;
		internal var _assets:Array;

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

		public function getBottomButtons(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			return out;
		}

		public function start():void{

		}


		protected function _createText(str:String, halign:String="left", target:DisplayObject=null):DisplayObject {
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
	}
}
