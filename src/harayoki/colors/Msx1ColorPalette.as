package harayoki.colors {
	public class Msx1ColorPalette implements IColorPalette{

		private static var _colorsMSX1:Vector.<ColorRGBHSV>;
		private static var _colorsMSX2:Vector.<ColorRGBHSV>;
		private static var _intermediateColoesMSX1:Vector.<ColorRGBHSV>;
		private static var _intermediateColoesMSX2:Vector.<ColorRGBHSV>;

		private static var _nearestRGBCache: Object = {};
		private static var _nearestHSVCache: Object = {};

		public static function clearNearestCache():void {
			_nearestRGBCache = {};
			_nearestHSVCache = {};
		}

		private static function _createMsx1Color(
			name:String, rgbString:String, transparent:Boolean=false):ColorRGBHSV {
			var col:ColorRGBHSV = ColorRGBHSV.fromRGBString(rgbString);
			if(transparent) {
				col.a = 0;
			}
			col.name = name;
			return col;
		}

		private static function _createMsx2Color(
			name:String, r:int, b:int, g:int, transparent:Boolean=false):ColorRGBHSV {
			var col:ColorRGBHSV = ColorRGBHSV.fromRGB(255 * (r/7),255 * (g/7),255 * (b/7), transparent ? 0x00: 0xFF );
			col.name = name;
			return col;
		}

		private static function _createIntermediateColors(colors:Vector.<ColorRGBHSV>):Vector.<ColorRGBHSV> {
			var v:Vector.<ColorRGBHSV> = new <ColorRGBHSV>[];

			// 中間色を作る
			for (var i:int = 0 ;i < v.length; i++) {
				for (var j:int = 0 ;j< v.length; j++) {
					if(j == i) continue;
					var col1:ColorRGBHSV = v[i];
					var col2:ColorRGBHSV = v[j];
					if(ColorRGBHSV.equals(col1, col2)) continue;
				}
			}

			return v;
		}

		private static function _initMsx1():void {

			if(_colorsMSX1) return;

			var v:Vector.<ColorRGBHSV>;
			v = new <ColorRGBHSV>[];
			v.length = 16;

			//MSX1のパレット
			// @see http://www.wizforest.com/OldGood/ntsc/msx.html

			v[0x00] = _createMsx1Color("透明", "#000000", true);
			v[0x01] = _createMsx1Color("黒", "#000000");
			v[0x02] = _createMsx1Color("緑", "#3EB849");
			v[0x03] = _createMsx1Color("明るい緑", "#74D07D");
			v[0x04] = _createMsx1Color("暗い青", "#5955E0");
			v[0x05] = _createMsx1Color("明るい青", "#8076F1");
			v[0x06] = _createMsx1Color("暗い赤", "#B95E51");
			v[0x07] = _createMsx1Color("シアン", "#65DBEF");
			v[0x08] = _createMsx1Color("赤", "DB6559");
			v[0x09] = _createMsx1Color("明るい赤", "#FF897D");
			v[0x0A] = _createMsx1Color("暗い黄", "#CCC35E");
			v[0x0B] = _createMsx1Color("明るい黄", "#DED087");
			v[0x0C] = _createMsx1Color("暗い緑", "#3AA241");
			v[0x0D] = _createMsx1Color("マゼンタ", "#B766B5");
			v[0x0E] = _createMsx1Color("灰", "#CCCCCC");
			v[0x0F] = _createMsx1Color("白", "#FFFFFF");
			_colorsMSX1 = v;
			_intermediateColoesMSX1 = _createIntermediateColors(v);
		}

		private static function _initMsx2():void {

			if(_colorsMSX2) return;

			var v:Vector.<ColorRGBHSV>;
			v = new <ColorRGBHSV>[];
			v.length = 16;

			// MSX2以降のデフォルトパレット (MSX1とはちょと色が違う)
			// @see http://ngs.no.coocan.jp/doc/wiki.cgi/TechHan?page=2%BE%CF+MSX+BASIC+ver2.0+%A4%CE%CA%D1%B9%B9%C5%C0
			v[0x00] = _createMsx2Color("透明", 0, 0, 0, true);
			v[0x01] = _createMsx2Color("黒", 0, 0, 0);
			v[0x02] = _createMsx2Color("緑", 1, 1, 6);
			v[0x03] = _createMsx2Color("明るい緑", 3, 3, 7);
			v[0x04] = _createMsx2Color("暗い青", 1, 7, 1);
			v[0x05] = _createMsx2Color("明るい青", 2, 7, 3);
			v[0x06] = _createMsx2Color("暗い赤", 5, 1, 1);
			v[0x07] = _createMsx2Color("シアン", 2, 7, 6);
			v[0x08] = _createMsx2Color("赤", 7, 1, 1);
			v[0x09] = _createMsx2Color("明るい赤", 5, 1, 1);
			v[0x0A] = _createMsx2Color("暗い黄", 6, 1, 6);
			v[0x0B] = _createMsx2Color("明るい黄", 6, 3, 6);
			v[0x0C] = _createMsx2Color("暗い緑", 1, 1, 4);
			v[0x0D] = _createMsx2Color("マゼンタ", 6, 5, 2);
			v[0x0E] = _createMsx2Color("灰", 5, 5, 5);
			v[0x0F] = _createMsx2Color("白", 7, 7, 7);
			_colorsMSX2 = v;
			_intermediateColoesMSX2 = _createIntermediateColors(v);
		}

		private var _name:String;
		private var _colors:Vector.<ColorRGBHSV>;
		private var _intermediateColoes:Vector.<ColorRGBHSV>;

		public function Msx1ColorPalette(name:String="msx1 palette", useMsx2Mode:Boolean=false) {
			_name = name;
			if(useMsx2Mode) {
				_initMsx2();
				_colors = _colorsMSX2;
				_intermediateColoes = _intermediateColoesMSX2;
			} else {
				_initMsx1();
				_colors = _colorsMSX1;
				_intermediateColoes = _intermediateColoesMSX1;
			}
		}

		public function get name():String {
			return _name;
		}

		public function getByIndex(index:int):ColorRGBHSV {
			var col:ColorRGBHSV = _colors[index];
			return col;
		}

		public function getAll():Vector.<ColorRGBHSV> {
			return _colors.slice();
		}

		public function getNearestByHSB(color:ColorRGBHSV, brightnessRatio:Number=1.0):ColorRGBHSV {

			if(!color) return null;

			var key:String = color.toRGBHexString();
			var found:ColorRGBHSV = _nearestHSVCache[key] as ColorRGBHSV;
			if(found) return found;

			var distance:Number = Number.POSITIVE_INFINITY;
			for each( var c:ColorRGBHSV in _colors) {
				var d:Number = ColorRGBHSV.getDistanceByHSVSquared(color, c, brightnessRatio);
				if(d == 0) {
					found = c;
					break;
				}
				if(distance > d) {
					distance = d;
					found = c;
				}
			}

			_nearestHSVCache[key] = found;

			return found;
		}

		public function getNearestByRGB(color:ColorRGBHSV):ColorRGBHSV {

			if(!color) return null;

			var key:String = color.toRGBHexString();
			var found:ColorRGBHSV = _nearestRGBCache[key] as ColorRGBHSV;
			if(found) return found;

			var distance:Number = Number.POSITIVE_INFINITY;
			for each( var c:ColorRGBHSV in _colors) {
				var d:Number = ColorRGBHSV.getDistanceByRGBSquared(color, c);
				if(d == 0) {
					found = c;
					break;
				}
				if(distance > d) {
					distance = d;
					found = c;
				}
			}

			_nearestRGBCache[key] = found;

			return found;
		}
	}
}

