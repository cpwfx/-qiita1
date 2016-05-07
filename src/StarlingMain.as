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
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
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

			_assetManager.enqueueWithName('app:/assets/atlas.png');
			_assetManager.enqueueWithName('app:/assets/atlas.xml');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			var eijiFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);

			// 絵文字の上書き登録
			var emoji:BitmapChar = // "1"の文字に[王冠画像]を上書き登録
				BitmapFontUtil.createBitmapCharByTexture("1", _assetManager.getTexture("oukan"),0, 0, 16 + 2);
			BitmapFontUtil.addBitmapCharToFont(eijiFont, emoji);

			// 未定義文字をまとめてトウフに
			var tofuChar:BitmapChar =
				BitmapFontUtil.createBitmapCharByTexture(
					0 , _assetManager.getTexture("tofu"), 0, 4, 12); // charcodeはなんでもいい
			BitmapFontUtil.fillBitmapChars(
				tofuChar,
				eijiFont,
				CharCodeUtil.getIdListByCodeRange(0x3000, 0x30ff), //ひらがなとカタカナの範囲
				true, // 上書きしない設定
				true  // BitmapCharを使いまわす設定
			);

			// フォント情報trace
			BitmapFontUtil.traceBitmapCharInfo(eijiFont);

			_doHelper.locateDobj(_doHelper.createSpriteText("STAGE 1-A", eijiFont.name, 300, 50, 16, 0xffffff), 50, 20);
			_doHelper.locateDobj(_doHelper.createSpriteText("ABCあいうえあ〜ワヲンDEF", eijiFont.name, 200), 50, 40);

		}


	}
}