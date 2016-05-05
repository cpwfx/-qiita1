package harayoki.starling {
	import flash.geom.Rectangle;

	import harayoki.util.CharCodeUtil;

	import starling.text.BitmapChar;
	import starling.text.BitmapChar;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.BitmapFont;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
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
		private static var NULL_REGION:Rectangle = new Rectangle(0,0,0,0);

		/**
		 * BitmapFontをコピーする
		 */
		public static function cloneBitmapFont(
			newFontName:String,
			orgFont:BitmapFont,
			charIdlist:Vector.<int> = null
		):BitmapFont {
			return cloneBitmapFontWithDetail(newFontName, orgFont, 0, 0, 0, 0, false, false, charIdlist);
		}

		/**
		 * BitmapFontを固定幅フォントに変更してコピーする
		 */
		public static function cloneBitmapFontAsMonoSpaceFont(
			newFontName:String,
			orgFont:BitmapFont,
			xAdvance:Number,
			charIdlist:Vector.<int> = null
		):BitmapFont {
			return cloneBitmapFontWithDetail(newFontName, orgFont, 0, 0, 0, xAdvance, true, true, charIdlist);
		}

		/**
		 * BitmapFontを詳細指定でコピーする
		 */
		public static function cloneBitmapFontWithDetail(newFontName:String,
			orgFont:BitmapFont,
			size:Number = 0,
			xOffset:Number = 0,
			yOffset:Number = 0,
			xAdvanceOffset:Number = 0,
			fixedXAdvance:Boolean = false,
			fixedXAdvanceCenterize:Boolean = false, // fixedXAdvanceのみ有効
			charIdlist:Vector.<int> = null
		):BitmapFont {
			if (!orgFont) {
				return null;
			}

			_fontxml.info.@face = StringUtil.clean(newFontName);
			_fontxml.info.@size = (isNaN(size) || size <= 0) ? "" + orgFont.size : "" + size;
			var font:BitmapFont = new BitmapFont(orgFont.texture, _fontxml);
			font.lineHeight = orgFont.lineHeight;
			font.baseline = orgFont.baseline;
			font.smoothing = orgFont.smoothing;

			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = orgFont.getCharIDs(_idlist);
			}

			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					orgFont.getChar(id), -1, xOffset, yOffset, xAdvanceOffset, charIdlist,
					fixedXAdvance, fixedXAdvanceCenterize);
				font.addChar(id, char);
			}
			TextField.registerBitmapFont(font);

			return font;
		}

		/**
		 * 空のBitmapFontを直接作る
		 */
		public static function createEmptyFont(
			fontName:String,
			size:Number,
			lineHeight:Number=0,
			smoothing:Boolean=false,
			texture:Texture=null
		):BitmapFont {
			_fontxml.info.@face = StringUtil.clean(fontName);
			_fontxml.info.@size = size + "";
			if(!texture) {
				texture = Texture.empty(1,1);
			}
			var font:BitmapFont = new BitmapFont(texture, _fontxml);
			font.lineHeight = isNaN(lineHeight) || lineHeight <= 0 ? size : lineHeight;
			font.smoothing = smoothing ? TextureSmoothing.BILINEAR : TextureSmoothing.NONE;
			TextField.registerBitmapFont(font);
			return font;
		}

		/**
		 * (サブ)テクスチャから直接BitmapCharを作ってフォントに登録する
		 * @param font 対象フォント
		 * @param charCodeOrCharStr 文字コードもしくは1文字
		 * @param texture テクスチャ（サブテクスチャ推奨)
		 * @param xOffset 任意
		 * @param yOffset 任意
		 * @param width 任意、デフォルトでテクスチャの横幅
		 */
		public static function addBitmapCharByTexture(
			font:BitmapFont, charCodeOrCharStr:Object, texture:Texture, xOffset:Number=0, yOffset:Number=0, width:Number = -1
		):BitmapChar {
			var id:int;
			if(charCodeOrCharStr is int) {
				id = charCodeOrCharStr as int;
			} else {
				id = (charCodeOrCharStr+"").charCodeAt(0);
			}
			var char:BitmapChar = new BitmapChar(id, texture, xOffset, yOffset, width < 0 ? texture.width : width);
			font.addChar(id, char);
			return char;
		}

		/**
		 * １文字列の指定でBitmapCharを得る
		 */
		public static function getBitmapCharByLetter(
			font:BitmapFont,
			letter:String
		):BitmapChar {
			if(!font || !letter) {
				return null;
			}
			return font.getChar(letter.charCodeAt(0));
		}

		/**
		 * BitmapCharをコピーする
		 * @param char コピー元
		 * @param newId 新しいID(任意)
		 */
		public static function cloneBitmapChar(
			char:BitmapChar,
			newId:int=-1
		):BitmapChar {
			if(!char) {
				return null;
			}
			return _cloneBitmapChar(char, newId, 0, 0, 0, null, false, false)
		}

		/**
		 * 必要であれば一部値を書き換えつつBitmapCharをコピーする
		 */
		private static function _cloneBitmapChar(
			org:BitmapChar,
			newId:int=-1,
			xOffset:Number=0,
			yOffset:Number=0,
			xAdvanceOffset:Number=0,
			idlistForKerning:Vector.<int>=null,
			fixedXAdvance:Boolean = false,
			centerizeXOffset:Boolean = false
		):BitmapChar {

			if(newId < 0) {
				newId = org.charID;
			}
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
				newId,
				org.texture,
				xOffset,
				org.yOffset + yOffset,
				xAdvance
			);
			for each(var id:int in idlistForKerning) {
				var kerning:Number = org.getKerning(id); // if no kerning, returns 0
				if (kerning != 0) {
					char.addKerning(id, kerning);
				}
			}
			return char;
		}

		/**
		 * 他のフォントから一気にBitmapCharを取り込む
		 */
		public static function overWriteCopyBitmapChars(
			target:BitmapFont,
			copyFrom:BitmapFont,
			overWritten:Boolean = true,
			yOffset:Number = 0,
			charIdlist:Vector.<int> = null
		):void {
			if (!copyFrom || !target) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = copyFrom.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var newChar:BitmapChar = _cloneBitmapChar(copyFrom.getChar(id), -1, 0, yOffset, 0, charIdlist);
				var currentChar:BitmapChar = target.getChar(id);
				if (!currentChar || overWritten) {
					target.addChar(id, newChar);
				}
			}
		}

		/**
		 * BitmaCharの余白を更新する
		 */
		public static function updatePadding(
			font:BitmapFont,
			xOffset:Number = 0,
			yOffset:Number = 0,
			xAdvanceOffset:Number = 0,
			charIdlist:Vector.<int> = null
		):void {
			if (!font) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = font.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					font.getChar(id), -1, xOffset, yOffset, xAdvanceOffset, charIdlist);
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
		public static function setFixedWidth(
			font:BitmapFont,
			fixedWidth:Number,
			centerize:Boolean = true,
			charIdlist:Vector.<int> = null
		):void {
			if (!font) {
				return;
			}
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = font.getCharIDs(_idlist);
			}
			for each(var id:int in charIdlist) {
				var char:BitmapChar = _cloneBitmapChar(
					font.getChar(id), -1, 0, 0, fixedWidth, charIdlist, true, centerize);
				font.addChar(id, char);
			}
		}

		/**
		 * あるBitmapCharでフォント文字を埋める
		 * @param sorceBitmapChar
		 * @param targetFont
		 * @param targetCharIdlist
		 * @param emptyTargetOnly
		 */
		public static function fillBitmapChars(
			sorceBitmapChar:BitmapChar,
			targetFont:BitmapFont,
			targetCharIdlist:Vector.<int>,
			emptyTargetOnly:Boolean = false
		):void {
			if(!targetFont || !sorceBitmapChar) {
				return;
			}
			for each(var id:int in targetCharIdlist) {
				if(emptyTargetOnly && targetFont.getChar(id)) {
					// 埋める先がからでないのでskip
					continue;
				}
				var char:BitmapChar = _cloneBitmapChar(sorceBitmapChar, id, 0, 0, 0, null, false, false);
				targetFont.addChar(id, char);
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
			_idlist.length = 0;
			var numChar:int = target.getCharIDs(_idlist).length;
			if (!charIdlist) {
				_idlist.length = 0;
				charIdlist = target.getCharIDs(_idlist);
			}
			trace("<Font:" + target.name,
				[
					"size:"+target.size,
					"lineheight:"+target.lineHeight,
					"smoothing:"+target.smoothing
				] + ">");
			trace("(numChar:" + numChar + ")" );
			var len:int = charIdlist.length;
			for (var i:int=0; i<len; i++) {
				var id:int = charIdlist[i];
				var char:BitmapChar = target.getChar(id);
				if (char) {
					trace("'" + String.fromCharCode(id) + "'(" + id + ") txsize:" +
						(char.width + "*" + char.height) + " offset:" + [char.xOffset, char.yOffset] + " xAdv:"+ char.xAdvance);
				}
			}
		}

		/**
		 * スペース幅を設定する
		 */
		public static function setSpaceWidth(font:BitmapFont, width:Number=0):void {
			_updateSpaceWidth(font, CharCodeUtil.CODE_SPACE, width);
		}

		/**
		 * 全角スペース幅を設定する
		 */
		public static function setZenkakuSpaceWidth(font:BitmapFont, width:Number=0):void {
			_updateSpaceWidth(font, CharCodeUtil.CODE_ZENKAKU_SPACE, width);
		}

		/**
		 * タブ幅を設定する
		 */
		public static function setTabWidth(font:BitmapFont, width:Number=0):void {
			_updateSpaceWidth(font, CharCodeUtil.CODE_TAB, width);
		}

		private static function _updateSpaceWidth(font:BitmapFont, id:int, width:Number=0):void {
			if(!font) {
				return;
			}
			if(isNaN(width) || width <= 0 ) {
				width = font.size;
			}
			var texture:Texture = Texture.fromTexture(font.texture, NULL_REGION);
			var char:BitmapChar = new BitmapChar(id, texture, 0, 0, width);
			font.addChar(id, char);
		}

	}
}
