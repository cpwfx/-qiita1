package harayoki.starling {
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.StringUtil;

	public class BitmapFontUtil {

		private static var _idlist:Vector.<int> = new <int>[];
		private static var _fontxml:XML = <font>
			<info face="dummy" size="1" smooth="1" />
			<common lineHeight="1" scaleW="1" scaleH="1" pages="1" />
			<pages>
				<page id="0" file="dummy.png" />
			</pages>
			<chars count="0">
			</chars>
			<kernings count="0">
			</kernings>
		</font>;

		public static function cloneBitmapFont(
			newFontName:String,
			orgFont:BitmapFont,
			charIdlist:Vector.<int>=null
		):BitmapFont {
			return cloneBitmapFontWithDetail(newFontName, orgFont, 0, 0, 0, 0, false, charIdlist);
		}

		public static function cloneBitmapFontAsMonoSpaceFont(
			newFontName:String,
			orgFont:BitmapFont,
			xAdvance: int,
			charIdlist:Vector.<int>=null
		):BitmapFont {
			return cloneBitmapFontWithDetail(newFontName, orgFont, 0, 0, 0, xAdvance, true, charIdlist);
		}

		public static function cloneBitmapFontWithDetail(
			newFontName:String,
			orgFont:BitmapFont,
			size:Number=0,
			xOffset:int=0,
			yOffset:int=0,
			xAdvanceOffset:int=0,
			fixedXAdvance:Boolean = false,
			charIdlist:Vector.<int>=null

		):BitmapFont {
			if(!orgFont) {
				return null;
			}

			_fontxml.info.@face = StringUtil.clean(newFontName);
			_fontxml.info.@size = isNaN(size) || size <=0 ? orgFont.size : size;
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
					orgFont.getChar(id), xOffset, yOffset, xAdvanceOffset, charIdlist, fixedXAdvance);
				fnt.addChar(id, char);
			}
			TextField.registerBitmapFont(fnt);

			return fnt;
		}

		private static function _cloneBitmapChar(
			org:BitmapChar,
			xOffset:int,
			yOffset:int,
			xAdvanceOffset:int,
			idlist:Vector.<int>,
			fixedXAdvance:Boolean=false
		):BitmapChar {
			var char:BitmapChar = new BitmapChar(
				org.charID,
				org.texture,
				org.xOffset + xOffset,
				org.yOffset + yOffset,
				fixedXAdvance ? xAdvanceOffset : org.xAdvance + xAdvanceOffset
			);
			for each(var id:int in idlist) {
				var kerning:Number = org.getKerning(id); // if no kerning, returns 0
				if(kerning != 0 ) {
					char.addKerning(id, kerning);
				}
			}
			return char;
		}

		public static function copyBitmapChars(
			target:BitmapFont,
			copyFrom:BitmapFont,
			overWritten:Boolean=true,
			yOffset:int=0,
			charIdlist:Vector.<int>=null):void {
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
				if(!currentChar || overWritten) {
					target.addChar(id, newChar);
				}
			}
		}

		public static function updatePadding(
			font:BitmapFont,
			xOffset: int = 0,
			yOffset: int = 0,
			xAdvanceOffset:int = 0,
			charIdlist:Vector.<int>=null
		):void {
			if(!font) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = font.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					font.getChar(id), xOffset, yOffset, xAdvanceOffset , charIdlist);
				font.addChar(id, char);
			}
		}

		public static function traceBitmapCharInfo(target:BitmapFont,charIdlist:Vector.<int>=null) {
			if (!target) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = target.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = target.getChar(id);
				if(char) {
					trace(target.name,'char(' + id + '):' + String.fromCharCode(id),
						[char.width + 'x' + char.height, '[' + [char.xOffset, char.yOffset] + ']', char.xAdvance]);
				}
			}
		}

		public static function getIdRange(charFrom:String, charTo:String=null, out:Vector.<int>=null):Vector.<int> {
			if(!out) {
				out = new <int>[];
			}
			if(charFrom == null || charFrom.length ==0) {
				return out;
			}
			if(charTo == null || charTo.length == 0) {
				charTo = charFrom;
			}
			for(var i:int=charFrom.charCodeAt(0);i<=charTo.charCodeAt(0);i++) {
				out.push(i);
			}
			return out;
		}
	}
}
