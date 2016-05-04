package harayoki.starling {
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.StringUtil;

	public class BitmapFontUtil {

		private static var _idlist:Vector.<int> = new <int>[];
		private static var _fontxml:XML = <font>
			<info face="dummy" size="1" smooth="1"/>
			<common lineHeight="1" scaleW="1" scaleH="1" pages="1"/>
			<pages>
				<page id="0" file="dummy.png"/>
			</pages>
			<chars count="0">
			</chars>
			<kernings count="0">
			</kernings>
		</font>;

		public static function cloneBitmapFont(newFontName:String,
											   orgFont:BitmapFont,
											   charIdlist:Vector.<int> = null):BitmapFont {
			return cloneBitmapFontWithDetail(newFontName, orgFont, 0, 0, 0, 0, false, false, charIdlist);
		}

		public static function cloneBitmapFontAsMonoSpaceFont(newFontName:String,
															  orgFont:BitmapFont,
															  xAdvance:Number,
															  charIdlist:Vector.<int> = null):BitmapFont {
			return cloneBitmapFontWithDetail(newFontName, orgFont, 0, 0, 0, xAdvance, true, true, charIdlist);
		}

		public static function cloneBitmapFontWithDetail(newFontName:String,
														 orgFont:BitmapFont,
														 size:Number = 0,
														 xOffset:Number = 0,
														 yOffset:Number = 0,
														 xAdvanceOffset:Number = 0,
														 fixedXAdvance:Boolean = false,
														 fixedXAdvanceCenterize:Boolean = false,
														 charIdlist:Vector.<int> = null):BitmapFont {
			if (!orgFont) {
				return null;
			}

			_fontxml.info.@face = StringUtil.clean(newFontName);
			_fontxml.info.@size = isNaN(size) || size <= 0 ? orgFont.size : size;
			var fnt:BitmapFont = new BitmapFont(orgFont.texture, _fontxml);
			fnt.lineHeight = orgFont.lineHeight;
			fnt.baseline = orgFont.baseline;
			fnt.smoothing = orgFont.smoothing;

			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = orgFont.getCharIDs(_idlist);
			}

			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					orgFont.getChar(id), xOffset, yOffset, xAdvanceOffset, charIdlist, fixedXAdvance, fixedXAdvanceCenterize);
				fnt.addChar(id, char);
			}
			TextField.registerBitmapFont(fnt);

			return fnt;
		}

		private static function _cloneBitmapChar(org:BitmapChar,
												 xOffset:Number,
												 yOffset:Number,
												 xAdvanceOffset:Number,
												 idlist:Vector.<int>,
												 fixedXAdvance:Boolean = false,
												 centerizeXOffset:Boolean = false):BitmapChar {

			var xAdvance:Number = org.xAdvance + xAdvanceOffset;
			if (fixedXAdvance) {
				xAdvance = xAdvanceOffset;
			}
			if (centerizeXOffset) {
				xOffset = Math.max(0, (xAdvance - org.width) * 0.5);
			} else {
				xOffset = org.xOffset + xOffset;
			}

			var char:BitmapChar = new BitmapChar(
				org.charID,
				org.texture,
				xOffset,
				org.yOffset + yOffset,
				xAdvance
			);
			for each(var id:int in idlist) {
				var kerning:Number = org.getKerning(id); // if no kerning, returns 0
				if (kerning != 0) {
					char.addKerning(id, kerning);
				}
			}
			return char;
		}

		public static function copyBitmapChars(target:BitmapFont,
											   copyFrom:BitmapFont,
											   overWritten:Boolean = true,
											   yOffset:Number = 0,
											   charIdlist:Vector.<int> = null):void {
			if (!copyFrom || !target) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = copyFrom.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var newChar:BitmapChar = _cloneBitmapChar(copyFrom.getChar(id), 0, yOffset, 0, charIdlist);
				var currentChar:BitmapChar = target.getChar(id);
				if (!currentChar || overWritten) {
					target.addChar(id, newChar);
				}
			}
		}

		public static function updatePadding(font:BitmapFont,
											 xOffset:Number = 0,
											 yOffset:Number = 0,
											 xAdvanceOffset:Number = 0,
											 charIdlist:Vector.<int> = null):void {
			if (!font) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = font.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					font.getChar(id), xOffset, yOffset, xAdvanceOffset, charIdlist);
				font.addChar(id, char);
			}
		}

		/**
		 * フォントの指定範囲を固定幅に変更する
		 * @param font フォント
		 * @param fixedWidth 固定幅値
		 * @param centerize 文字を真ん中よせにするか
		 * @param charIdlist 対象文字番号の一覧
		 */
		public static function setFixedWidth(font:BitmapFont,
											 fixedWidth:Number,
											 centerize:Boolean = true,
											 charIdlist:Vector.<int> = null):void {
			if (!font) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = font.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					font.getChar(id), 0, 0, fixedWidth, charIdlist, true, centerize);
				font.addChar(id, char);
			}
		}

		/**
		 * ビットマップフォントの各文字情報をtraceする
		 * @param target フォント
		 * @param charIdlist 対象文字番号の一覧
		 */
		public static function traceBitmapCharInfo(target:BitmapFont, charIdlist:Vector.<int> = null) {
			if (!target) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = target.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = target.getChar(id);
				if (char) {
					trace(target.name, 'char(' + id + '):' + String.fromCharCode(id),
						[char.width + 'x' + char.height, '[' + [char.xOffset, char.yOffset] + ']', char.xAdvance]);
				}
			}
		}

	}
}
