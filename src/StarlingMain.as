package {
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import misc.DisplayObjectHelper;
	
	import misc.ViewportUtil;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const DEFAULT_FONT_NAME:String = "pxfont12shadow";
		private static const CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320*2, 224*2);

		public static function start(nativeStage:Stage):void {
			trace("Staaling version", Starling.VERSION);

			var starling:Starling = new Starling(
				StarlingMain,
				nativeStage,
				CONTENTS_SIZE
			);
			starling.skipUnchangedFrames = true;
			starling.start();
			starling.stage.color = 0x666666;
		}

		private var _doHelper:DisplayObjectHelper;
		private var _assetManager:AssetManager;
		public function StarlingMain() {

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE);

			_doHelper = new DisplayObjectHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_assetManager.enqueueWithName('app:/assets/pxfont12shadow.png');
			_assetManager.enqueueWithName('app:/assets/pxfont12shadow.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {
			_doHelper.locateDobj(_doHelper.createText("ABCDEFG abcdefg",DEFAULT_FONT_NAME , 24), 10, 40);
			_doHelper.locateDobj(_doHelper.createSpriteText("HIJKLMN hijklmn",DEFAULT_FONT_NAME , 24, 100, 24), 10, 60);
		}


	}
}