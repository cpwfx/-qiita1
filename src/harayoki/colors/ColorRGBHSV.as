package harayoki.colors {
	public class ColorRGBHSV {

		public static function test(c:ColorRGBHSV):void {
			trace(c.toString());
			trace(c.toRGBHexString());
			trace(c.toRGBAHexString());
			trace(c.toARGBHexString());
			c._updateRGBfromHSV();
			trace(c.toString());
			trace(c.toRGBHexString());
			trace(c.toRGBAHexString());
			trace(c.toARGBHexString());
			c._updateHSVfromRGB();
			trace(c.toString());
			trace(c.toRGBHexString());
			trace(c.toRGBAHexString());
			trace(c.toARGBHexString());
		}

		private static var _workObj:Object = {};

		/**
		 * Saturation値を正規化して、0.0〜1.0の範囲にする 範囲外のものは切り捨て
		 */
		private static function _validateSaturation(num:Number):Number {
			return Math.max(Math.min(1.0, num), 0.0);
		}

		/**
		 * Brightness値を正規化して、0.0〜1.0の範囲にする 範囲外のものは切り捨て
		 */
		private static function _validateBrightness(num:Number):Number {
			return Math.max(Math.min(1.0, num), 0.0);
		}

		/**
		 * Hue値を正規化して、0.0〜1.0の範囲にする 範囲外のものは１周して収まる
		 */
		private static function _validateHue(num:Number):Number {
			while(num>1.0) {
				num-=1.0;
			}
			while(num<0.0) {
				num+=1.0;
			}
			return num;
		}

		/**
		 * RGBAとしての値を正規化して、0〜255の範囲にする
		 */
		private static function _validateRGBValue(num:uint):uint {
			return Math.min(255, num);
		}

		/**
		 *  RGB指定(文字)でカラーを作成 a値は255固定
		 *  ex) "#FF0000" または "FF0000"
		 */
		public static function fromRGBString(rgbString:String):ColorRGBHSV {
			// FFFFFF -> 255,255,255
			if(rgbString.indexOf("#")==0) {
				rgbString = rgbString.slice(1);
			}
			rgbString = ("000000" + rgbString).slice(-6);
			var col:ColorRGBHSV = new ColorRGBHSV();
			col._r = parseInt("0x"+rgbString.slice(0,2), 16);
			col._g = parseInt("0x"+rgbString.slice(2,4), 16);
			col._b = parseInt("0x"+rgbString.slice(4,6), 16);
			col._a = 255;
			col._updateHSVfromRGB();
			return col;
		}

		/**
		 *  RGB指定(数値)でカラーを作成 a値は255固定
		 *  ex) 0xff0000
		 */
		public static function fromRGBColor(color:Number):ColorRGBHSV {
			return fromRGBString(color.toString(16));
		}

		/**
		 *  RGB(A)指定(それぞれ 0~255)でカラーを作成
		 */
		public static function fromRGB(r:uint, g:uint, b:uint, a:uint=255):ColorRGBHSV {
			var col:ColorRGBHSV = new ColorRGBHSV();
			col._r = _validateRGBValue(r);
			col._g = _validateRGBValue(g);
			col._b = _validateRGBValue(b);
			col._a = _validateRGBValue(a);
			col._updateHSVfromRGB();
			return col;
		}

		/**
		 * HSV(A)指定でカラーを作成
		 */
		public static function fromHSV(h:Number, s:Number, v:Number, a:uint=255):ColorRGBHSV {
			var col:ColorRGBHSV = new ColorRGBHSV();
			col._h = _validateHue(h);
			col._s = _validateSaturation(s);
			col._v = _validateBrightness(v);
			col._a = _validateRGBValue(a);
			col._updateRGBfromHSV();
			return col;
		}

		/**
		 * HSV空間でのカラー中間値を得る
		 */
		public static function getIntermediateColorByHSV(color1:ColorRGBHSV, color2:ColorRGBHSV):ColorRGBHSV {
			var h:Number = (color1._h + color2._h) * 0.5;
			var s:Number = (color1._s + color2._s) * 0.5;
			var v:Number = (color1._v + color2._v) * 0.5;
			var a:uint = Math.floor((color1._a + color2._a) * 0.5 + 0.5);
			return ColorRGBHSV.fromHSV(h, s, v, a);
		}

		/**
		 * RGB空間でのカラー中間値を得る
		 */
		public static function getIntermediateColorByRGB(color1:ColorRGBHSV, color2:ColorRGBHSV):ColorRGBHSV {
			var r:uint = Math.floor((color1._r + color2._r) * 0.5 + 0.5);
			var g:uint = Math.floor((color1._g + color2._g) * 0.5 + 0.5);
			var b:uint = Math.floor((color1._b + color2._b) * 0.5 + 0.5);
			var a:uint = Math.floor((color1._a + color2._a) * 0.5 + 0.5);
			return ColorRGBHSV.fromRGB(r, g, b, a);
		}

		private var _a:uint = 255;
		private var _r:uint = 255;
		private var _g:uint = 255;
		private var _b:uint = 255;
		private var _h:Number = 0;
		private var _s:Number = 0;
		private var _v:Number = 0;

		public var name:String = "";

		public function ColorRGBHSV() {
		}

		public function toString():String {
			return "[Color RGBA"+ (name ? "(" + name + ")" : "") +":" +[_r,_g,_b,_a].join(",") + " HSB:" +[_h,_s,_v].join(",")+ "]";
		}

		public function toRGBHexString():String {
			return toRGBNumber().toString(16).toUpperCase();
		}

		public function toRGBAHexString():String {
			return toRGBANumber().toString(16).toUpperCase();
		}

		public function toARGBHexString():String {
			return toARGBNumber().toString(16).toUpperCase();
		}

		public function toRGBNumber():uint {
			return (_r << 16) + (_g << 8) + _b;
		}

		public function toRGBANumber():uint {
			return (_r << 24) + (_g << 16) + (_b << 8) + _a;
		}

		public function toARGBNumber():uint {
			return (_a << 24) + (_r << 16) + (_g << 8) + _b;
		}

		public function clone():ColorRGBHSV {
			var c:ColorRGBHSV = new ColorRGBHSV();
			c._r = _r;
			c._g = _g;
			c._b = _b;
			c._a = _a;
			c._h = _h;
			c._s = _s;
			c._v = _v;
			return c;
		}

		/**
		 * RGB空間での距離の二乗を返す
		 */
		public static function getDistanceByRGBSquared(color1:ColorRGBHSV, color2:ColorRGBHSV):Number {
			var dr:int = (color1._r - color2._r);
			var dg:int = (color1._g - color2._g);
			var db:int = (color1._b - color2._b);
			dr *= dr;
			dg *= dg;
			db *= db;
			return dr + dg + db;
		}

		/**
		 * HSV空間での距離の二乗を返す
		 * @param brightnessRatio 輝度の重み
		 */
		public static function getDistanceByHSVSquared(color1:ColorRGBHSV, color2:ColorRGBHSV, brightnessRatio:Number=1.0):Number {
			var dh:Number = (color1._h - color2._h);
			var ds:Number = (color1._s - color2._s);
			var dv:Number = (color1._v - color2._v) / brightnessRatio;
			dh *= dh;
			ds *= ds;
			dv *= dv;
			return dh + ds+ dv;
		}

		private function _updateRGBfromHSV():void {
			ColorUtil.Hsv2RgbObject(_h, _s, _v, _workObj);
			_r = _validateRGBValue(_workObj.r);
			_g = _validateRGBValue(_workObj.g);
			_b = _validateRGBValue(_workObj.b);
			_a = _validateRGBValue(_a);
		}

		private function _updateHSVfromRGB():void {
			ColorUtil.Rgb2HsvObj(_r, _g, _b, _workObj);
			_h = _validateHue(_workObj.h);
			_s = _validateSaturation(_workObj.s);
			_v = _validateBrightness(_workObj.v);
			_a = _validateRGBValue(_a);
		}

		public function updateRGBANumber(color:Number):void {
			color &= 0xffffffff;
			_r = (color & 0xff000000) >> 24;
			_g = (color & 0x00ff0000) >> 16;
			_b = (color & 0x0000ff00) >> 8;
			_a = (color & 0x000000ff);
			_updateHSVfromRGB();
		}

		public function updateARGBNumber(color:Number):void {
			color &= 0xffffffff;
			_a = (color & 0xff000000) >> 24;
			_r = (color & 0x00ff0000) >> 16;
			_g = (color & 0x0000ff00) >> 8;
			_b = (color & 0x000000ff);
			_updateHSVfromRGB();
		}

		public function updateRGBA(r:uint, g:uint, b:uint, a:uint=255):void {
			_r = _validateRGBValue(r);
			_g = _validateRGBValue(g);
			_b = _validateRGBValue(b);
			_a = _validateRGBValue(a);
			_updateHSVfromRGB();
		}

		public function updateHSVA(h:Number, s:Number, v:Number, a:uint=255):void {
			_h = _validateHue(h);
			_s = _validateSaturation(s);
			_v = _validateBrightness(v);
			_a = _validateRGBValue(a);
			_updateRGBfromHSV();
		}

		public function get r():uint {
			return _r;
		}

		public function set r(value:uint):void {
			if(value > 255) value = 255;
			if(_r == value) return;
			_r = value;
			_updateHSVfromRGB();
		}

		public function get g():uint {
			return _g;
		}

		public function set g(value:uint):void {
			if(value > 255) value = 255;
			if(_g == value) return;
			_g = value;
			_updateHSVfromRGB();
		}

		public function get b():uint {
			return _b;
		}

		public function set b(value:uint):void {
			if(value > 255) value = 255;
			if(_b == value) return;
			_b = value;
			_updateHSVfromRGB();
		}

		public function get h():Number {
			return _h;
		}

		public function set h(value:Number):void {
			if(isNaN(value) || value < 0.0) {
				value = 0.0;
			}	else if(value > 1.0) {
				value = 1.0;
			}
			if(_h == value) return;
			_h = value;
			_updateRGBfromHSV();
		}

		public function get s():Number {
			return _s;
		}

		public function set s(value:Number):void {
			if(isNaN(value) || value < 0.0) {
				value = 0.0;
			}	else if(value > 1.0) {
				value = 1.0;
			}
			if(_s == value) return;
			_s = value;
			_updateRGBfromHSV();
		}

		public function get v():Number {
			return _v;
		}

		public function set v(value:Number):void {
			if(isNaN(value) || value < 0.0) {
				value = 0.0;
			}	else if(value > 1.0) {
				value = 1.0;
			}
			if(_v == value) return;
			_v = value;
			_updateRGBfromHSV();
		}

		public function get a():uint {
			return _a;
		}

		public function set a(value:uint):void {
			if(value > 255) value = 255;
			if(_a == value) return;
			_a = value;
		}

	}
}
