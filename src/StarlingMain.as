package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;

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
		private static const FONT_NAME_MONO:String = "momnospace";
		private static const FONT_NAME_COLORCHIP:String = "colorchip";
		private static const FONT_NAME_MAPCHIP:String = "mapchip";
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
			_assetManager.enqueueWithName('app:/assets/colorbars.xml');
			_assetManager.enqueueWithName('app:/assets/maptip.xml');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			var font:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);

			// 固定幅フォントを作る
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, font, 16);
			monoSpaceFont.lineHeight = 16;

			// カラーチップフォント
			var colorTipFont1:BitmapFont =
				BitmapFontUtil.createBitmapFontFromTextureAtlas(FONT_NAME_COLORCHIP, _assetManager, "mx/", 2);

			// マップチップフォント
			var mapchip:BitmapFont =
				BitmapFontUtil.createBitmapFontFromTextureAtlasAsMonoSpaceFont(
					FONT_NAME_MAPCHIP, _assetManager, "map1/" , 16, 16, 16 );
			// スペースの設定
			BitmapFontUtil.setSpaceWidth(mapchip, 16);

			// ナカグロの点（余白テスト用）の追加
			var dot:BitmapChar = BitmapFontUtil.createBitmapCharByTexture("・",_assetManager.getTexture("dot16x16"), 0, 0, 16);
			BitmapFontUtil.addBitmapCharToFont(mapchip, dot, dot.charID, false);

			// マップチップ画像の下に表示する英字の幅をそろえる
			var tempFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont("tempFont", monoSpaceFont, 16);
			BitmapFontUtil.setSpaceWidth(tempFont, 16);
			BitmapFontUtil.addBitmapCharToFont(tempFont, dot, dot.charID, false);

			BitmapFontUtil.traceBitmapCharInfo(mapchip);

			// A〜Pのサンプル表示データ
			var mapall:String = [
				"ABCDEFGHIJKLMNOP",
				"",
				"01・",
			].join("\n");

			// マップデータ
			var map:String = [
				"CCCCIIIIIIIIAAAA",
				"CCCIIIIIIAAAAMAA",
				"CCCCIIIAAAAAAAAA",
				"CCIIIAAAAOAAAAOA",
				"CCIIIIAAAAAAAAAA",
				"CCCIIIIAAAAAAAAA",
				"CCCCCIIAAAAOAAAA",
				"CCCCCCCIIAAAAAOA",
				"CCCCCCCCCIIAAAAA",
				"CCCCCCCCCCCEGGGG",
				"CCCCCCCCCCCCLLHL",
				"CCCCCCCCCCCCLPDP",
				"JJJCCCCCCCCCLDDD",
				"BBJJCCCCCCCCLDKD",
				"BNBJJCCCCCCCLDDF",
				"BBBJJCCCCCCCPPPP",
				"",
				"A・A・", // 余白文字のテスト
				"1B0B" // 絵文字まじった際のテスト
			].join("\n");

			// キャラデータ
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

			//// キャラ表示
			//_doHelper.locateDobj(
			//	_doHelper.createSpriteText(
			//		chara,
			//		colorTipFont1.name,
			//		80,
			//		80
			//	), 100, 5, 1);

			// マップチップ表示
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					mapall,
					mapchip.name,
					300,
					100
				), 10, 40, 1);

			// マップチップに対応する英字を表示
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					mapall,
					tempFont.name,
					300,
					100,
					14
				), 10, 40 + 16, 1);

			// マップ表示
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					map,
					mapchip.name,
					300,
					600
				), 10, 110, 1);

		}


	}
}