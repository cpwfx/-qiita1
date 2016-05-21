package harayoki.starling {

	import flash.geom.Point;
	import flash.utils.Dictionary;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.Align;

	public class FixedLayoutBitmapTextController{

		/**
		 * 通常インスタンスを生成する
		 */
		public static function getInstance(
			fontName:String, formatString:String, color:Number=0xffffff,
			size:Number=0, width:int=0, height:int=0
		):FixedLayoutBitmapTextController {
			return new FixedLayoutBitmapTextController(
				fontName, formatString, color, size, width, height);
		}

		/**
		 * テキストフィールドを使うインスタンスを生成する
		 * (パフォーマンスがこちらが良い場合などはすぐ切り替えられるように)
		 */
		public static function getInstanceWithForGeneralTextField(
			fontName:String, formatString:String, color:Number=0xffffff,
			size:Number=0, width:int=0, height:int=0, batchable:Boolean=false
		):FixedLayoutBitmapTextController {
			return new BitmapFontTextFieldFixedLocationWithGeneralTextField(
				fontName, formatString, color, size, width, height, batchable);
		}

		private static const TEXT_BOX_WIDTH:int = 99999; // 十分に大きく
		private static const TEXT_BOX_HEIGHT:int = 99999; // 十分に大きく

		private var _font:BitmapFont;
		private var _formatString:String;
		private var _paddingStr:String;
		private var _text:String = "";
		private var _images:Vector.<Image>;
		private var _orgPositions:Dictionary;
		private var _sp:Sprite;

		// テキストのAlign設定 "right" or "left"
		public var align:String = "left";

		/**
		 * @param fontName フォント名
		 * @param formatString  "00000"などテキストのレイアウト決定に使う文字の並び 実際に表示はされない
		 * @param size フォントサイズ(デフォルトフォントのデフォルトサイズ)
		 * @param color フォントカラー
		 * @param width テキストBOXの横幅 指定し無いと十分な大きさが取られる（よって、自動改行されない）
		 * @param height テキストBOXの縦幅
		 */
		public function FixedLayoutBitmapTextController(
			fontName:String, formatString:String, color:Number=0xffffff, size:Number = 0, width:int=0, height:int=0) {
			_font = TextField.getBitmapFont(fontName);
			if(!_font) {
				throw(new Error("invalid font name : " + fontName));
			}
			_formatString = formatString;
			if(_formatString == null || _formatString.length == 0) {
				throw(new Error("Invalid format string.. empty format."))
			}
			if(!_checkFormatString()) {
				throw(new Error("Invalid format string.. missing bitmap char(s)."))
			}
			_setPaddingStr(" ");
			var textFormat:TextFormat = new TextFormat(
				_font.name, size <= 0 ? _font.size : size, color, Align.TOP, Align.LEFT);
			_initialize();
			setText("");
			_setup(
				width <= 0 ? TEXT_BOX_WIDTH : width,
				height <=0 ? TEXT_BOX_HEIGHT : height,
				_formatString,
				textFormat
			);
		}

		protected function _initialize():void {
			_images = new <Image>[];
			_orgPositions = new Dictionary();
		}

		public function get displayObject():DisplayObject {
			return _sp;
		}

		// フォーマットストリングが正しく使えるものが確認する
		private function _checkFormatString():Boolean {
			for(var i:int=0; i< _formatString.length; i++) {
				var code:int = _formatString.charCodeAt(i);
				if(!_font.getChar(code)) return false;
			}
			return true;
		}

		// 初期テキストレイアウト
		protected function _setup(w:int, h:int, text:String, format:TextFormat):void {
			_sp = _font.createSprite(w, h, text, format);
			_relocateImages(_sp);
			_orgPositions.fixed = true; // 高速化
			_images.fixed = true; // 高速化
		}

		// 文字スプライトを自身の中に配置し直す
		private function _relocateImages(sp:Sprite):void {
			// Imageは文字のままの重ね合わせ順で作られている想定
			var len:int = sp.numChildren;
			for(var i:int=0; i<len; i++) {
				var dobj:DisplayObject = sp.getChildAt(i);
				var image:Image = dobj as Image; // Imageしかないはず
				// trace(image.width);
				image.textureSmoothing = _font.smoothing;
				var id:int = _formatString.charCodeAt(_images.length);
				var char:BitmapChar = _font.getChar(id); // 必ずある
				_images.push(image);
				_orgPositions[image] = new Point(image.x - char.xOffset, image.y - char.yOffset);
			}
			if(_formatString.length != _images.length) {
				throw (new Error("something wrong with font images."));
			}
		}

		//// 上から、左からの優先順位でソートし直す
		//private function _sortFunc(a:DisplayObject, b:DisplayObject):int {
		//	if(a.y > b.y) return 1;
		//	if(a.y < b.y) return -1;
		//	return a.x - b.x;
		//}

		/**
		 * 廃棄処理
		 */
		public function dispose():void {
			_font = null;
			_removeImages();
			if(_sp) {
				_sp.removeFromParent(true);
				_sp = null;
			}
			_images = null;
			_orgPositions = null;
		}

		// 作成した文字を全て削除する
		private function _removeImages():void {
			for each(var image:Image in _images) {
				image.removeFromParent(true);
			}
			if(_images) {
				_images.length = 0;
			}
		}

		/**
		 * パディング文字を指定する
		 * @param paddingChr パディング１文字
		 */
		public function set paddingChr(value:String) :void {
			_setPaddingStr(value);
		}

		private function _setPaddingStr(value:String=" "):void {
			value += " "; // 0文字対策
			value = value.charAt(0); // 最初の文字だけ有効
			_paddingStr = "";
			var i:int = _formatString.length;
			while(i--) {
				// _paddingStrはpaddingChrが並んだもの なんども使うので先に作っておく
				_paddingStr += value;
			}
		}

		/**
		 * パディング文字を得る
		 */
		public function get paddingChr():String {
			if(!_paddingStr || _paddingStr.length == 0) {
				_setPaddingStr(" ");
			}
			return _paddingStr;
		}

		/**
		 * 現在の表示テキストを返す
		 */
		public function getText():String {
			return _text;
		}

		/**
		 * テキストを隙間を自動で埋める処理とともに設定する
		 */
		public function setTextWithPadding(text:String):void {
			var len:int = _formatString.length;
			if(align == Align.RIGHT) {
				// 右づめテキストで足りない部分をpadding文字で埋める
				text = (_paddingStr + text).slice(-len);
			} else {
				// 左づめテキストで足りない部分をpadding文字で埋める
				text = (text + _paddingStr).slice(0, len);
			}
			setText(text);
		}

		/**
		 * テキストを直接指定する
		 */
		public function setText(text:String):void {
			if (_text == text) {
				return;
			}
			// trace(text);
			_updateText(_text, text);
			_text = text;
		}

		// 表示文字のアップデート
		protected function _updateText(prevText:String, newText:String):void {
			var newId:int;
			var image:Image;
			var char:BitmapChar;
			var texture:Texture;
			var point:Point;
			for(var i:int=0; i<_images.length; i++) {
				// trace(_text.charAt(i));
				newId = newText.charCodeAt(i);
				if(prevText.charCodeAt(i) == newId) {
					continue;
				}
				image = _images[i];
				char = _font.getChar(newId); // ないかも？
				if(!char) {
					// missing chara
					image.visible = false;
					continue;
				}
				image.visible = true;
				texture = char.texture;
				image.texture = texture;
				image.width = texture.frameWidth; // 余白付きのテクスチャの大きさも保つためにframeWidthを使う
				image.height = texture.frameHeight; // 同様にframeHeightを使う
				point = _orgPositions[image];
				image.x = point.x + char.xOffset;
				image.y = point.y + char.yOffset;
				// kerningは考慮しない
				// char.xAdvance は最初のレイアウトの時点で揃っているものとする
			}
		}


	}
}

import harayoki.starling.FixedLayoutBitmapTextController;

import starling.display.DisplayObject;

import starling.text.TextField;
import starling.text.TextFormat;

/**
 * 同じインターフェースで通常のTextFieldをあつかうclass
 */
internal class BitmapFontTextFieldFixedLocationWithGeneralTextField extends FixedLayoutBitmapTextController {

	private var _batchable:Boolean;
	private var _textField:TextField;

	public function BitmapFontTextFieldFixedLocationWithGeneralTextField(
		fontName:String, formatString:String, color:Number=0xffffff,
		size:Number = 0, width:int=0, height:int=0, batchable:Boolean=false
	) {
		_batchable = batchable;
		super(fontName, formatString, color, size, width, height);
	}

	protected override function _initialize():void {
	}

	public override function get displayObject():DisplayObject {
		return _textField;
	}

	public override function dispose():void {
		_textField = null;
		super.dispose();
	}

	protected override function _setup(w:int, h:int, text:String, format:TextFormat):void {
		_textField = new TextField(w, h, text, format);
		_textField.batchable = _batchable;
	}

	protected override function _updateText(prevText:String, newText:String):void {
		_textField.text = newText;
	}
}
