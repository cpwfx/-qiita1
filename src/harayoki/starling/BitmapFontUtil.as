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

		public static function cloneBitmapFont(originFontName:String, newFontName:String, size:int=-1):BitmapFont {
			var org:BitmapFont = TextField.getBitmapFont(originFontName);
			if(!org) {
				return null;
			}

			_fontxml.info.@face = StringUtil.clean(newFontName);
			_fontxml.info.@size = isNaN(size) || size <=0 ? org.size : size;
			var fnt:BitmapFont = new BitmapFont(org.texture, _fontxml);
			fnt.lineHeight = org.lineHeight;
			fnt.smoothing = org.smoothing;
			fnt.baseline = org.baseline;

			_idlist.length = 0;
			org.getCharIDs(_idlist);
			for each(var id:int in _idlist) {
				var char:BitmapChar = _cloneBitmapChar(org.getChar(id), _idlist);
				fnt.addChar(id, char);
			}
			TextField.registerBitmapFont(fnt);

			return fnt;
		}

		private static function _cloneBitmapChar(org:BitmapChar, idlist:Vector.<int>):BitmapChar {
			var char:BitmapChar = new BitmapChar(
				org.charID,
				org.texture,
				org.xOffset,
				org.yOffset,
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

	}
}
