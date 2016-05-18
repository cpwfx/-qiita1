package demos {
	import harayoki.starling.BitmapFontUtil;

	import starling.text.BitmapFont;
	import starling.text.TextField;

	public class MyFontManager {

		public static const FONT_NAME_ALPHABET:String = "alphabet";
		public static const FONT_NAME_KANA:String = "kana_only";
		public static const FONT_NAME_MONO:String = "mono_space";
		public static const FONT_NAME_PADDING:String = "mono_padding";
		public static const FONT_NAME_COLORCHIP:String = "colorchip";
		public static const FONT_NAME_COLORCHIP2:String = "colorchip2";

		public function MyFontManager() {
		}

		public function setup():void {

			var baseFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_KANA);
			var subFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);

			// カナフォントに英字フォントを合成
			BitmapFontUtil.overWriteCopyBitmapChars(baseFont, subFont, true, baseFont.lineHeight - subFont.lineHeight + 1);
			// 固定幅フォントにする
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(MyFontManager.FONT_NAME_MONO, baseFont, 16);
			monoSpaceFont.lineHeight = 16;

		}

	}
}
