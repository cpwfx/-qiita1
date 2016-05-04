package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;
	
	import misc.DisplayObjectHelper;
	
	import misc.ViewportUtil;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME_DEFAULT:String = "default_font";
		private static const CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320, 240 * 2);

		public static function start(nativeStage:Stage):void {
			trace("Starling version :", Starling.VERSION);

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

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_doHelper = new DisplayObjectHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.png');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.fnt');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.png');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			BitmapFontUtil.cloneBitmapFont(FONT_NAME_ALPHABET, FONT_NAME_DEFAULT, 4);

			_doHelper.locateDobj(_doHelper.createText("あい うえお　わをん、ワヲン！？", FONT_NAME_KANA), 10, 40);
			_doHelper.locateDobj(_doHelper.createText("ABC DEFG", FONT_NAME_ALPHABET), 10, 70);
			_doHelper.locateDobj(_doHelper.createSpriteText("HIJ KLMN", FONT_NAME_DEFAULT, 200, 200, null, 12, 0xff00ff), 100, 90, 1.0, 0.2);
		}


	}
}