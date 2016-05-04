package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;
	import harayoki.util.CharCodeUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME_MONO:String = "mono_space";
		private static const FONT_NAME_PADDING:String = "mono_padding";
		private static const FONT_NAME_COLORCHIP:String = "colorchip";
		private static const FONT_NAME_COLORCHIP2:String = "colorchip2";
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
			_assetManager.enqueueWithName('app:/assets/colorbars.xml');
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
			var tofuChar:BitmapChar = new BitmapChar(1, _assetManager.getTexture("font_tofu"), 0, 0, 16);
			BitmapFontUtil.fillBitmapChars(
				tofuChar,
				baseFont,
				CharCodeUtil.getIdListByCodeRange(1,128));

			// 固定幅フォントを作る
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, baseFont, 16);
			monoSpaceFont.lineHeight = 16;
			// 半角設定
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListForAscii());
			// 句読点も
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListByLetters("、。"));

			var paddingAlphabetFont:BitmapFont = BitmapFontUtil.cloneBitmapFont(FONT_NAME_PADDING, subFont);
			BitmapFontUtil.updatePadding(paddingAlphabetFont, 10, 0, 20, CharCodeUtil.getIdListByCharRange("B","D"));

			// カラーチップフォント
			function setColorTexture(colorName:String):void {
				var texture:Texture = _assetManager.getTexture("mx/"+colorName);
				BitmapFontUtil.addBitmapCharByTexture(colorTipFont, colorName, texture, 0, 0, 2.25);
			}
			var colorTipFont:BitmapFont = BitmapFontUtil.createEmptyFont(FONT_NAME_COLORCHIP ,2, 2.25);
			colorTipFont.smoothing = TextureSmoothing.NONE;

			trace(colorTipFont.size);

			setColorTexture("0");
			setColorTexture("1");
			setColorTexture("2");
			setColorTexture("3");
			setColorTexture("4");
			setColorTexture("5");
			setColorTexture("6");
			setColorTexture("7");
			setColorTexture("8");
			setColorTexture("9");
			setColorTexture("A");
			setColorTexture("B");
			setColorTexture("C");
			setColorTexture("D");
			setColorTexture("E");
			setColorTexture("F");

			var colorTipFont2:BitmapFont =
				BitmapFontUtil.cloneBitmapFontWithDetail(FONT_NAME_COLORCHIP2, colorTipFont, 2);
			BitmapFontUtil.setFixedWidth(colorTipFont2, 2);
			colorTipFont2.lineHeight = 2;

			_doHelper.locateDobj(
				_doHelper.createText("ここは、カナフォント！\n" +
					"Koko ha eiji font.\n" +
					"ま　ぜ　て　も HEIKI です!", baseFont.name),
				10, 40);

//			_doHelper.locateDobj(_doHelper.createText("ABC DEFG", subFont.name), 10, 100);
//			_doHelper.locateDobj(_doHelper.createSpriteText("ABCあいうABC\nかきくDEFかきく", baseFont.name, 300, 50, null, 0, 0xffffff), 10, 130, 1.0);

//			_doHelper.locateDobj(_doHelper.createText("あいうえおDEFGさし\n12345かき6くけこたち", monoSpaceFont.name), 10, 170);
//
//			_doHelper.locateDobj(_doHelper.createText("ABCDEFG", paddingAlphabetFont.name), 10, 200);

			_doHelper.locateDobj(_doHelper.createSpriteText("STAGE 9-1", baseFont.name, 300, 50, null, 32, 0xffffff), 60, 20);

			var chara:String = [
				"000888888000",
				"008888888880",
				"00CCCAACA000",
				"0CACAAACAAA0",
				"0CACCAAACAAA",
				"0CCAAAACCCC0",
				"000AAAAAAA00",
				"00CC8CCC0000",
				"0CCC8CC8CCC0",
				"CCCC8888CCCC",
				"AAC8A88A8CAA",
				"AAA888888AAA",
				"AA88888888AA",
				"008880088800",
				"0CCC0000CCC0",
				"CCCC0000CCCC",
			].join("\n");

			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					chara,
					colorTipFont.name,
					80,
					80,
					null,
					2
				), 30, 80);

			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					chara,
					colorTipFont2.name,
					80,
					120,
					null,
					2
				), 90, 80);
		}


	}
}