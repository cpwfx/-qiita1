package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_COLORCHIP1:String = "colorchip1";
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
			_assetManager.enqueueWithName('app:/assets/colorbars.png');
			_assetManager.enqueueWithName('app:/assets/colorbars.xml');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			/**
			 * 色つきの四角いテクスチャをフォント１文字として登録
			 * @param font フォント
			 * @param colorName 文字名＝カラー名
			 */
			function setColorTexture(font:BitmapFont, colorName:String):void {
				var texture:Texture = _assetManager.getTexture("mx/"+colorName);
				BitmapFontUtil.addBitmapCharToFont(
					font, BitmapFontUtil.createBitmapCharByTexture(colorName, texture, 0, 0, 2));
			}

			// カラーチップフォントの作成
			var colorTipFont1:BitmapFont = BitmapFontUtil.createEmptyFont(FONT_NAME_COLORCHIP1 ,2, 2);
			colorTipFont1.smoothing = TextureSmoothing.NONE;
			var cf:BitmapFont = colorTipFont1;
			setColorTexture(cf, "0");
			setColorTexture(cf, "1");
			setColorTexture(cf, "2");
			setColorTexture(cf, "3");
			setColorTexture(cf, "4");
			setColorTexture(cf, "5");
			setColorTexture(cf, "6");
			setColorTexture(cf, "7");
			setColorTexture(cf, "8");
			setColorTexture(cf, "9");
			setColorTexture(cf, "A");
			setColorTexture(cf, "B");
			setColorTexture(cf, "C");
			setColorTexture(cf, "D");
			setColorTexture(cf, "E");
			setColorTexture(cf, "F");

			// 上のフォントをコピーして、隙間を広げてみる
			var colorTipFont2:BitmapFont =
				BitmapFontUtil.cloneBitmapFont(FONT_NAME_COLORCHIP2, colorTipFont1);
			BitmapFontUtil.setFixedWidth(colorTipFont2, 2.25);
			colorTipFont2.lineHeight = 2.25;

			// 詳細trace
			BitmapFontUtil.traceBitmapCharInfo(colorTipFont1);
			BitmapFontUtil.traceBitmapCharInfo(colorTipFont2);

			// キャラパターン
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

			// Starling入れ込みフォントで表示
			var defaultFont:BitmapFont = new BitmapFont();
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					chara,
					defaultFont.name,
					240,
					240,
					8,
					0x66ffff
				), 180, 60);

			// フォント1で表示
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					chara,
					colorTipFont1.name,
					80,
					80,
					4
				), 40, 80);

			// フォント2で表示
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					chara,
					colorTipFont2.name,
					80,
					120,
					4
				), 110, 80 + 8);

			// カラーバーの参考表示
			var texture:Texture = _assetManager.getTexture("mx/1"); // mx/1がアトラスのパーツ名
			var image:Image = new Image(texture.root); // アトラスパーツの元テクスチャを使う
			image.textureSmoothing = TextureSmoothing.NONE;
			_doHelper.locateDobj(image, 260, 60, 4.0);

		}

	}
}