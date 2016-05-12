package harayoki.starling {

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.Align;

	public class BitmapFontTextFieldFixedLocation extends Sprite{

		/**
		 * インスタンスを生成する
		 * ※ テストに使うためのメソッドで、特にこのメソッドを経由してインスタンス化する必要は無い
		 * @param forTest パフォーマンス比較テスト用に通常のテキストフィールドを使うインスタンスを返すか
		 *         他パラメータは通常のコンストラクタ利用時と同じ
		 */
		public static function createInstance(
			forTest:Boolean, fontName:String, formatString:String, color:Number=0xffffff,
			size:Number=0, width:int=0, height:int=0
		):BitmapFontTextFieldFixedLocation {
			if(forTest) {
				return new TestClass(fontName, formatString, color, size, width, height);
			}
			return new BitmapFontTextFieldFixedLocation(fontName, formatString, color, size, width, height);
		}

		private static const TEXT_BOX_WIDTH:int = 99999; // 十分に大きく
		private static const TEXT_BOX_HEIGHT:int = 99999; // 十分に大きく

		private var _font:BitmapFont;
		private var _formatString:String;
		private var _paddingStr:String;
		private var _text:String = "";
		private var _images:Vector.<Image>;

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
		public function BitmapFontTextFieldFixedLocation(
			fontName:String, formatString:String, color:Number=0xffffff, size:Number = 0, width:int=0, height:int=0) {
			_font = TextField.getBitmapFont(fontName);
			if(!_font) {
				throw(new Error("invalid font name : " + fontName));
			}
			_formatString = formatString;
			var textFormat:TextFormat =
				new TextFormat(_font.name, size <= 0 ? _font.size : size, color, Align.TOP, Align.LEFT);
			_images = new <Image>[];
			_setPaddingStr(" ");
			_setup(
				width <= 0 ? TEXT_BOX_WIDTH : width,
				height <=0 ? TEXT_BOX_HEIGHT : height,
				_formatString,
				textFormat);

			setText("");
		}

		// 初期テキストレイアウト
		protected function _setup(w:int, h:int, text:String, format:TextFormat):void {
			var sp:Sprite = _font.createSprite(w, h, text, format);
			_locateImages(sp, _images); // ここで中身だけ取り出して
			sp.dispose(); //すぐ廃棄...無駄があるが、BitmapFontTextFieldForScore自体がDisplayObjectである方が使いやすい
		}

		// 文字スプライトを自身の中に配置し直す
		private function _locateImages(sp:Sprite, images:Vector.<Image>):void {
			while(sp.numChildren) {
				var dobj:DisplayObject = sp.getChildAt(0);
				var image:Image = dobj as Image;
				// trace(image.width);
				if(image) {
					image.textureSmoothing = _font.smoothing;
					images.push(image);
					addChild(image);
				} else {
					// imageしかないはず
					trace("Unexpected display object found.")
					sp.removeChild(dobj);
				}
			}
			// images.sort(_sortFunc); //offsetYがある場合におかしくなるので利用しない事にする
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
		public override function dispose():void {
			_font = null;
			_removeImages();
			_images = null;
			super.dispose();
		}

		// 作成した文字を全て削除する
		private function _removeImages():void {
			if(_images) {
				_images.length = 0;
			}
			while (numChildren) {
				removeChildAt(0, true);
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
		public function setText(text:String) {
			if (_text == text) {
				return;
			}
			// trace(text);
			_text = text;
			_updateText(_text);
		}

		// 表示文字のアップデート
		protected function _updateText(text:String):void {
			for(var i:int=0; i<_images.length; i++) {
				// trace(_text.charAt(i));
				var id:int = _text.charCodeAt(i);
				var image:Image = _images[i];
				var char:BitmapChar = _font.getChar(id);
				if(!char) {
					// missing chara
					image.visible = false;
					return;
				}
				image.visible = true;
				var texture:Texture = char.texture;
				if(image.texture != texture) {
					image.texture = texture;
					image.width = char.texture.frameWidth;
					image.height = char.texture.frameHeight;
					// char.xOffset char.yOffset はずれていても無視 (imageサイズが違う文字は文字が左上による事がある)
					// kerningは考慮しない
					// char.xAdvance は最初のレイアウトの時点で揃っているものとする
				}
			}
		}


	}
}

import harayoki.starling.BitmapFontTextFieldFixedLocation;

import starling.text.TextField;
import starling.text.TextFormat;

/**
 * パフォーマンス比較テスト用に通常のTextFieldをあつかうclass
 */
internal class TestClass extends BitmapFontTextFieldFixedLocation {

	private var _tfForTest:TextField;

	public function TestClass(
		fontName:String, formatString:String, color:Number=0xffffff,
		size:Number = 0, width:int=0, height:int=0
	) {
		super(fontName, formatString, color, size, width, height);
	}

	protected override function _setup(w:int, h:int, text:String, format:TextFormat):void {
		_tfForTest = new TextField(w, h, text, format);
		addChild(_tfForTest);
	}

	protected override function _updateText(text:String):void {
		_tfForTest.text = text;
	}
}
