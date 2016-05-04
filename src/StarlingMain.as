package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;
	import harayoki.util.CharCodeUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME_MONO1:String = "mono_space1";
		private static const FONT_NAME_MONO2:String = "mono_space2";
		private static const FONT_NAME_YOHAKU:String = "yohaku";
		private static const FONT_NAME_SPACES:String = "spaces";
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
			starling.stage.color = 0x336666;
		}

		private var _doHelper:DisplayObjectHelper;
		private var _assetManager:AssetManager;
		public function StarlingMain() {

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_doHelper = new DisplayObjectHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.png');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			var baseFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_KANA);

			// 固定幅フォントを作る
			var monoSpaceFont1:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO1, baseFont, 16);
			monoSpaceFont1.lineHeight = 16;

			// 固定幅フォント(一部半角)を作る
			var monoSpaceFont2:BitmapFont = BitmapFontUtil.cloneBitmapFont(FONT_NAME_MONO2, monoSpaceFont1);
			BitmapFontUtil.setFixedWidth(monoSpaceFont2, 8, true, CharCodeUtil.getIdListByLetters("、。！？"));

			// 一部余白多めにしたフォントを作る
			var padding:int = 8;
			var yohakuFont:BitmapFont = BitmapFontUtil.cloneBitmapFont(FONT_NAME_YOHAKU, baseFont);
			BitmapFontUtil.updatePadding(yohakuFont, padding, 0, padding*2,
				CharCodeUtil.getIdListByLetters("ヨハクオオメ！"));
			BitmapFontUtil.traceBitmapCharInfo(yohakuFont);

			// スペース系の幅調整
			var spacesFont:BitmapFont = BitmapFontUtil.cloneBitmapFont(FONT_NAME_SPACES, baseFont);
			BitmapFontUtil.setSpaceWidth(spacesFont, 6);
			BitmapFontUtil.setZenkakuSpaceWidth(spacesFont, 14);
			BitmapFontUtil.setTabWidth(spacesFont, 48);

			_doHelper.locateDobj(
				_doHelper.createSpriteText("これは、プロポーショナル！なフォントです。", baseFont.name, 320),
				10, 40);

			_doHelper.locateDobj(
				_doHelper.createSpriteText("これは、おなじハバ！のフォントです。", monoSpaceFont1.name, 320),
				10, 60);

			_doHelper.locateDobj(
				_doHelper.createSpriteText("これは、いちぶハンカク！のフォントです。", monoSpaceFont2.name, 320),
				10, 80);

			_doHelper.locateDobj(
				_doHelper.createSpriteText("これは、イチブだけヨハクオオメ！\nの、フォントです。", yohakuFont.name, 320),
				10, 100);

			_doHelper.locateDobj(
				_doHelper.createSpriteText("は ん か く ス ペ ー ス 、\n" +
					"ぜ　ん　か　く　ス　ペ　ー　ス　、\n" +
					"タ	ブ	も	じ	。", spacesFont.name, 320, 100, null, 0, 0xffffcc),
				10, 140);

			// まだフォントに記号がなかった
			//_doHelper.locateDobj(
			//	_doHelper.createSpriteText([
			//			"　　 ∩＿＿＿∩",
			//			"　　 | ノ　　　　　 ヽ",
			//			"　　/　　●　　　● |",
			//			"　 |　　　　( _●_)　 ミ",
			//			"　彡､　　　|∪|　　､｀＼",
			//			"/　＿＿　 ヽノ　/´>　 )",
			//			"(＿＿＿）　　　/　(_／",
			//			"　|　　　　　　 /",
			//			"　|　　／＼　＼",
			//			"　|　/　　　 )　 )",
			//			"　∪　　　 （　 ＼",
			//			"　　　　　　 ＼＿) "
			//		].join("\n"),
			//		monoSpaceFont2.name, 320),
			//	10, 120);

		}


	}
}