package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;
	
	import misc.DisplayObjectHelper;
	
	import misc.ViewportUtil;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME:String = "default_font";
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

//			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.png');
//			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.png');
			_assetManager.enqueueWithName('app:/assets/atlas.png');
			_assetManager.enqueueWithName('app:/assets/atlas.xml');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.fnt');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			var baseFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_KANA);
			var subFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);
			var newFont:BitmapFont = baseFont;//BitmapFontUtil.cloneBitmapFont(FONT_NAME, baseFont);
			BitmapFontUtil.copyBitmapChars(newFont, subFont, true, newFont.lineHeight - subFont.lineHeight + 1);

			_doHelper.locateDobj(
				_doHelper.createText("ここは、カナフォント！\n" +
					"Koko ha eiji font.\n" +
					"ま　ぜ　て　も HEIKI です!", newFont.name),
				10, 40);
			_doHelper.locateDobj(_doHelper.createText("ABC DEFG", subFont.name), 10, 100);
			_doHelper.locateDobj(_doHelper.createSpriteText("ABCあいうABC\nかきくDEFかきく", newFont.name, 300, 50, null, 0, 0xff00ff), 10, 130, 1.0);

		}


	}
}