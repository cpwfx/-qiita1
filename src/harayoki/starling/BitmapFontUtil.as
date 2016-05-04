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
			size:Number=0,
			yOffset:int=0
			):BitmapFont
		{
			if(!orgFont) {
				return null;
			}

			_fontxml.info.@face = StringUtil.clean(newFontName);
			_fontxml.info.@size = isNaN(size) || size <=0 ? orgFont.size : size;
			var fnt:BitmapFont = new BitmapFont(orgFont.texture, _fontxml);
			fnt.lineHeight = orgFont.lineHeight;
			fnt.baseline = orgFont.baseline;
			fnt.smoothing = orgFont.smoothing;

			_idlist.length = 0;
			orgFont.getCharIDs(_idlist);
			for each(var id:int in _idlist) {
				var char:BitmapChar = _cloneBitmapChar(orgFont.getChar(id), yOffset, _idlist);
				fnt.addChar(id, char);
			}
			TextField.registerBitmapFont(fnt);

			return fnt;
		}

		private static function _cloneBitmapChar(org:BitmapChar, yOffset:int, idlist:Vector.<int>):BitmapChar {
			var char:BitmapChar = new BitmapChar(
				org.charID,
				org.texture,
				org.xOffset,
				org.yOffset + yOffset,
				org.xAdvance
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
				var newChar:BitmapChar = _cloneBitmapChar(copyFrom.getChar(id), yOffset, charIdlist);
				var currentChar:BitmapChar = target.getChar(id);
				if(!currentChar || overWritten) {
					target.addChar(id, newChar);
				}
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
						[char.width+'x'+char.height,'[' + [char.xOffset,char.yOffset] + ']',char.xAdvance]);
				}
			}
		}
	}
}
