package misc {
	import harayoki.starling.BitmapFontUtil;
	import harayoki.util.CharCodeUtil;

	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class MyFontManager {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME_MONO:String = "mono_space";
		private static const FONT_NAME_PADDING:String = "mono_padding";
		private static const FONT_NAME_COLORCHIP:String = "colorchip";
		private static const FONT_NAME_COLORCHIP2:String = "colorchip2";

		private static var _assetManager:AssetManager;

		private static var _baseFont:BitmapFont;
		private static var _subFont:BitmapFont;
		private static var _monoSpaceFont:BitmapFont;
		private static var _mapchip:BitmapFont;

		public static function setupAsset(assetManager:AssetManager):void {
			_assetManager = assetManager;
			assetManager.enqueueWithName('assets/px12fontshadow/alphabet.fnt');
			assetManager.enqueueWithName('assets/px12fontshadow/kana_only.fnt');
		}

		public static function setup():void {

			_baseFont = TextField.getBitmapFont(FONT_NAME_KANA);
			_subFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);

			// カナフォントに英字フォントを合成
			BitmapFontUtil.overWriteCopyBitmapChars(baseFont, _subFont, true, _baseFont.lineHeight - _subFont.lineHeight + 1);

			// 半角設定
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListForAscii());
			// 句読点も
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListByLetters("、。"));

			//// マップチップフォント
			//var mapchip:BitmapFont =
			//	BitmapFontUtil.createBitmapFontFromTextureAtlasAsMonoSpaceFont(
			//		"mapchip", _assetManager, "map1/" , 16, 16, 16 );
			//BitmapFontUtil.setSpaceWidth(mapchip, 16);
			//
			//var mapall:String = [
			//	"ABCDEFGHIJKLMNOP",
			//	"",
			//	"01",
			//].join("\n");

			// BitmapFontUtil.traceBitmapCharInfo(mapchip);

		}

		public static function get baseFont():BitmapFont {
			return _baseFont;
		}
		public static function get subFont():BitmapFont {
			return _subFont;
		}

		public static function get monoSpaceFont():BitmapFont {
			if(!_monoSpaceFont) {
				// 固定幅フォントにする
				_monoSpaceFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, baseFont, 16);
				_monoSpaceFont.lineHeight = 16;
			}
			return _monoSpaceFont;
		}

		// マップチップフォント
		public static function get mapchipFont():BitmapFont {

			if(!_mapchip) {
				_mapchip = BitmapFontUtil.createBitmapFontFromTextureAtlasAsMonoSpaceFont(
						"mapchip", _assetManager, "map1/" , 16, 16, 16 );
				BitmapFontUtil.setSpaceWidth(_mapchip, 16);
			}

			return _mapchip;

		}



	}
}
