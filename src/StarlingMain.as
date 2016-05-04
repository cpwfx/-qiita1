package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;
	import harayoki.util.CharCodeUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME_MONO:String = "mono_space";
		private static const FONT_NAME_PADDING:String = "mono_padding";
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
			
			// カナフォントに英字フォントを
			BitmapFontUtil.overWriteCopyBitmapChars(baseFont, subFont, true, baseFont.lineHeight - subFont.lineHeight + 1);
			// 一部文字を伏字に
			BitmapFontUtil.fillBitmapChars(
				BitmapFontUtil.getBitmapCharByLetter(baseFont, "*"),
				baseFont,
				CharCodeUtil.getIdListByCodeRange(100,128));

			// 固定幅フォントを作る
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, baseFont, 16);
			monoSpaceFont.lineHeight = 16;
			// 半角設定
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListForAscii());
			// 句読点も
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListByLetters("、。"));

			var paddingAlphabetFont:BitmapFont = BitmapFontUtil.cloneBitmapFont(FONT_NAME_PADDING, subFont);
			BitmapFontUtil.updatePadding(paddingAlphabetFont, 10, 0, 20, CharCodeUtil.getIdListByCharRange("B","D"));

			BitmapFontUtil.traceBitmapCharInfo(paddingAlphabetFont);

			_doHelper.locateDobj(
				_doHelper.createText("ここは、カナフォント！\n" +
					"Koko ha eiji font.\n" +
					"ま　ぜ　て　も HEIKI です!", baseFont.name),
				10, 40);
			_doHelper.locateDobj(_doHelper.createText("ABC DEFG", subFont.name), 10, 100);
			_doHelper.locateDobj(_doHelper.createSpriteText("ABCあいうABC\nかきくDEFかきく", baseFont.name, 300, 50, null, 0, 0xff00ff), 10, 130, 1.0);

			_doHelper.locateDobj(_doHelper.createText("あいうえおDEFGさし\n12345かき6くけこたち", monoSpaceFont.name), 10, 170);

			_doHelper.locateDobj(_doHelper.createText("ABCDEFG", paddingAlphabetFont.name), 10, 200);
		}


	}
}