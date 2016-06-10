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
			col._updateHSVfromRGB();
			return col;
		}
		
		public static function fromRGBColor(color:Number):ColorRGBHSV {
			return fromRGBString(color.toString(16));
		}

		public static function fromRGB(r:uint,g:uint,b:uint):ColorRGBHSV {
			var col:ColorRGBHSV = new ColorRGBHSV();
			col._r = r;
			col._g = g;
			col._b = b;
			col._updateHSVfromRGB();
			return col;
		}

		public static function fromHSV(h:Number,s:Number,v:Number):ColorRGBHSV {
			var col:ColorRGBHSV = new ColorRGBHSV();
			col._h = h;
			col._s = s;
			col._v = v;
			col._updateRGBfromHSV();
			return col;
		}

		private var _a:uint = 255;
		private var _r:uint = 255;
		private var _g:uint = 255;
		private var _b:uint = 255;
		private var _h:Number = 0;
		private var _s:Number = 0;
		private var _v:Number = 0;

		public function ColorRGBHSV() {
		}

		public function toString():String {
			return "[Color RGBA:" +[_r,_g,_b,_a].join(",") + " HSB:" +[_h,_s,_v].join(",")+ "]";
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

		private function _updateRGBfromHSV():void {
			ColorUtil.Hsv2RgbObject(_h, _s, _v, _workObj);
			_r = _workObj.r;
			_g = _workObj.g;
			_b = _workObj.b;
		}

		private function _updateHSVfromRGB():void {
			ColorUtil.Rgb2HsvObj(_r, _g, _b, _workObj);
			_h = _workObj.h;
			_s = _workObj.s;
			_v = _workObj.v;
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
