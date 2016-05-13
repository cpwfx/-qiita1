package harayoki.starling {
	import flash.geom.Rectangle;

	import harayoki.util.CharCodeUtil;

	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	import starling.utils.StringUtil;

	public class BitmapFontUtil {

		private static var _idlist:Vector.<int> = new <int>[];
		private static var _fontxml:XML = <font>
			<info face="dummy" size="1" smooth="1"/>
			<common lineHeight="1" scaleW="1" scaleH="1" pages="1" base="1"/>
			<pages>
				<page id="0" file="dummy.png"/>
			</pages>
			<chars count="0">
			</chars>
			<kernings count="0">
			</kernings>
		</font>;
		private static var _dummyTexture:Texture;
		private static const NULL_REGION:Rectangle = new Rectangle(0,0,0,0);

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
			_fontxml.info.@base = _fontxml.info.@size;
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
			smoothing:Boolean=false
		):BitmapFont {
			_fontxml.info.@face = StringUtil.clean(fontName);
			_fontxml.info.@size = size + "";
			_fontxml.info.@base = _fontxml.info.@size;
			if(!_dummyTexture) {
				_dummyTexture = Texture.empty(1,1,true,false,false,1.0);
			}
			var font:BitmapFont = new BitmapFont(_dummyTexture, _fontxml);
			font.lineHeight = isNaN(lineHeight) || lineHeight <= 0 ? size : lineHeight;
			font.smoothing = smoothing ? TextureSmoothing.BILINEAR : TextureSmoothing.NONE;
			TextField.registerBitmapFont(font);
			return font;
		}

		/**
		 * テクスチャから直接BitmapCharを作る
		 * @param charCodeOrCharStr 文字コードもしくは1文字
		 * @param texture テクスチャ（サブテクスチャ推奨)
		 * @param xOffset 任意
		 * @param yOffset 任意
		 * @param width 任意、デフォルトでテクスチャの横幅
		 * @param centerizeX 任意 真ん中よせX
		 * @param centerizeHeight 任意 真ん中よせYに使う縦幅
		 */
		public static function createBitmapCharByTexture(
			charCodeOrCharStr:Object, texture:Texture, xOffset:Number=0, yOffset:Number=0,
			width:Number = -1, centerizeX:Boolean=false, centerizeHeight:int=0
		):BitmapChar {
			var id:int;
			if(charCodeOrCharStr is int) {
				id = charCodeOrCharStr as int;
			} else {
				id = (charCodeOrCharStr+"").charCodeAt(0);
			}
			width = width < 0 ? texture.frameWidth : width;
			if(centerizeX) {
				xOffset += _calcCenterrizeOffsetX(texture, width);
			}
			if(centerizeHeight > 0) {
				yOffset += _calcCenterrizeOffsetY(texture, centerizeHeight);
			}
			var char:BitmapChar = new BitmapChar(id, texture, xOffset, yOffset, width);
			return char;
		}

		/**
		 * BitmapCharをフォントに登録する
		 * @param font 対象フォント
		 * @param char BitmapChar
		 * @param id idを変える場合指定
		 * @param noCharClone idを変える場合にcharをcloneしない
		 *        (大量に同じCharを登録する場合のメモリ節約用：登録IDとのずれが起きるので誤動作の可能性あり)
		 */
		public static function addBitmapCharToFont(
			font:BitmapFont, char:BitmapChar, id:int=-1, noCharClone:Boolean= true):void {
			if(!font) {
				return;
			}
			if(id != -1 && id != char.charID && !noCharClone) {
				char = _cloneBitmapChar(char, id);
			}
			font.addChar(char.charID, char);
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
			centerizeXOffset:Boolean = false,
			centerizeYOffsetHeight:int = 0
		):BitmapChar {

			if(newId < 0) {
				newId = org.charID;
			}
			var xAdvance:Number = org.xAdvance + xAdvanceOffset;
			if (fixedXAdvance) {
				xAdvance = xAdvanceOffset;
			}
			if (centerizeXOffset) {
				xOffset = _calcCenterrizeOffsetX(org.texture, xAdvance);
			} else {
				xOffset = org.xOffset + xOffset;
			}
			if (centerizeYOffsetHeight > 0) {
				yOffset = _calcCenterrizeOffsetY(org.texture, centerizeYOffsetHeight);
			} else {
				yOffset = org.yOffset + yOffset;
			}

			var char:BitmapChar = new BitmapChar(
				newId,
				org.texture,
				xOffset,
				yOffset,
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
		 * BitmaCharの余白を更新する
		 */
		public static function centerize(
			font:BitmapFont,
			applyToWidth:Boolean = true,
			applyToHeight:Boolean = false,
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
				var org:BitmapChar = font.getChar(id);
				var char:BitmapChar = _cloneBitmapChar(
					org, -1, 0, 0, 0, charIdlist, false, applyToWidth, applyToHeight ? font.size : 0);
				font.addChar(id, char);
			}
		}

		private static function _calcCenterrizeOffsetX(texture:Texture, width:int):int {
			//texture.width は 余白なしのtextureの幅を返す
			// texture.frameWidthはframe(余白設定)があるばあい余白つきの幅を、余白が無い場合textureの幅を返す
			var w:int = texture.frameWidth;
			return Math.floor((width - w)*0.5); // Bitmapなので整数値に吸着 負の値は許す
		}

		private static function _calcCenterrizeOffsetY(texture:Texture, height:int):int {
			// texture.frameWidthはframe(余白設定)があるばあい余白つきの幅を、余白が無い場合textureの幅を返す
			var h:int = texture.frameHeight;
			return Math.floor((height - h)*0.5); // Bitmapなので整数値に吸着 負の値は許す
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
		 * @param sorceBitmapChar コピー元BitmapChar
		 * @param targetFont 対象フォント
		 * @param targetCharIdlist 置き換えターゲットとなるID一覧
		 * @param emptyTargetOnly すでに登録済みのCharは上書きしない
		 * @param noCharClone idを変える場合にcharをcloneしない
		 *        (大量に同じCharを登録する場合のメモリ節約用：登録IDとのずれが起きるので誤動作の可能性あり)
		 */
		public static function fillBitmapChars(
			sorceBitmapChar:BitmapChar,
			targetFont:BitmapFont,
			targetCharIdlist:Vector.<int>,
			emptyTargetOnly:Boolean = false,
			noCharClone:Boolean = true
		):void {
			if(!targetFont || !sorceBitmapChar) {
				return;
			}
			for each(var id:int in targetCharIdlist) {
				if(emptyTargetOnly && targetFont.getChar(id)) {
					// 埋める先がからでないのでskip
					continue;
				}
				var char:BitmapChar = noCharClone ? sorceBitmapChar :
					_cloneBitmapChar(sorceBitmapChar, id, 0, 0, 0, null, false, false);
				targetFont.addChar(id, char);
			}
		}

		/**
		 * アトラス画像から一括でフォントを作る(真ん中よせ)
		 * @param fontName 作成するフォント名
		 * @param assetManager アセットマネージャ参照
		 * @param textureNamePrefix フォントのテクスチャ名のprefix
		 * @param size 作成するフォントサイズ
		 * @param width 1文字の横幅(真ん中よせ計算に使われる)
		 * @param lineHeight ラインハイト
		 * @param paddingX 文字間隔
		 * @param smoothing スムージング設定
		 */
		public static function createBitmapFontFromTextureAtlasAsMonoSpaceFont(
			fontName:String,
			assetManager:AssetManager,
			textureNamePrefix:String,
			size:Number,
			width:Number,
			lineHeight:Number=0,
			paddingX:Number=0,
			smoothing:Boolean=false
		):BitmapFont{
			return createBitmapFontFromTextureAtlasDetailed(
				fontName,
				assetManager,
				textureNamePrefix,
				size,
				lineHeight,
				paddingX,
				smoothing,
				width,
				size
			);
		}

		/**
		 * アトラス画像から一括でフォントを作る
		 * @param fontName 作成するフォント名
		 * @param assetManager アセットマネージャ参照
		 * @param textureNamePrefix フォントのテクスチャ名のprefix
		 * @param size 作成するフォントサイズ
		 * @param lineHeight ラインハイト
		 * @param paddingX 文字間隔
		 * @param smoothing スムージング設定
		 */
		public static function createBitmapFontFromTextureAtlas(
			fontName:String,
			assetManager:AssetManager,
			textureNamePrefix:String,
			size:Number,
			lineHeight:Number=0,
			paddingX:Number=0,
			smoothing:Boolean=false
		):BitmapFont{
			return createBitmapFontFromTextureAtlasDetailed(
				fontName,
				assetManager,
				textureNamePrefix,
				size,
				lineHeight,
				paddingX,
				smoothing
			);
		}

		/**
		 * アトラス画像から一括でフォントを作る(詳細指定)
		 * @param fontName 作成するフォント名
		 * @param assetManager アセットマネージャ参照
		 * @param textureNamePrefix フォントのテクスチャ名のprefix
		 * @param size 作成するフォントサイズ
		 * @param lineHeight ラインハイト
		 * @param paddingX 文字間隔
		 * @param smoothing スムージング設定
		 * @param width 横サイズ 真ん中よせ計算に使われる
		 * @param height 縦サイズ 真ん中よせ計算に使われる
		 */
		public static function createBitmapFontFromTextureAtlasDetailed(
			fontName:String,
			assetManager:AssetManager,
			textureNamePrefix:String,
			size:Number,
			lineHeight:Number=0,
			paddingX:Number=0,
			smoothing:Boolean=false,
			width:Number=0,
			height:Number=0
		):BitmapFont {
			var font:BitmapFont = createEmptyFont(fontName, size, lineHeight, smoothing);
			var textureNames:Vector.<String> = assetManager.getTextureNames(textureNamePrefix);
			trace("textureNames", textureNames);
			var char:BitmapChar;
			var charNames:Vector.<String> = new <String>[];
			for each(var textureName:String in textureNames) {
				var texture:Texture = assetManager.getTexture(textureName);
				var charName:String = textureName.slice(textureNamePrefix.length);
				var offsetX:Number = 0;
				if(width > 0) {
					offsetX = _calcCenterrizeOffsetX(texture, width);
				}
				var offsetY:Number = 0;
				if(height > 0) {
					offsetY = _calcCenterrizeOffsetY(texture, height);
				}
				var advanceX = width <=0 ? texture.frameWidth + paddingX : width + paddingX;
				if(charName.length == 1) {
					// １文字の場合はその文字として登録
					char = createBitmapCharByTexture(charName, texture, offsetX, offsetY, advanceX);
				} else if (charName.indexOf("0x") == 0){
					// 0xから始まる場合は
					char = createBitmapCharByTexture(parseInt(charName, 16), texture, offsetX, offsetY, advanceX);
				} else {
					// そうでない場合は直接コード番号として扱う
					char = createBitmapCharByTexture(Number(charName), texture, offsetX, offsetY, advanceX);
				}
				if(font.getChar(char.charID)) {
					trace("Error : font for "+char.charID+ " is already exist.");
				} else {
					charNames.push(charName);
					addBitmapCharToFont(font, char);
				}
			}
			trace("created bitmap chars :", charNames);
			return font;
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
			var texture:Texture = target.texture;
			function getTextureInfo(texture:Texture):String {
				if(texture) {
					return "(" + texture + " " + [
						"size:"+texture.width+"*"+texture.height,
						"frame:"+texture.frame, // frameWidth, frameHeight
						"scale:"+texture.scale
					].join(" ") + ")";
				} else {
					return "(N/A)";
				}
			}
			trace("<Font:" + target.name,
				[
					"size:"+target.size,
					"lineheight:"+target.lineHeight,
					"baseline:"+target.baseline,
					"smoothing:"+target.smoothing,
					"offsetX:"+target.offsetX,
					"offsetY:"+target.offsetY,
					"numChar:" + numChar,
					"\n\ttexture:"+getTextureInfo(texture),
				].join(" ") + ">");
			var len:int = charIdlist.length;
			for (var i:int=0; i<len; i++) {
				var id:int = charIdlist[i];
				var char:BitmapChar = target.getChar(id);
				if (char) {
					trace("'" + String.fromCharCode(id) + "'(" + id + ") texture:" +
						getTextureInfo(char.texture) + " offset:" + [char.xOffset, char.yOffset] + " xAdv:"+ char.xAdvance);
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
