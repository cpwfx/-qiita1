package harayoki.colors {
	import starling.utils.Color;

	public class Msx2Screen5ColorPalette implements IColorPalette{

		private static var _colors:Vector.<ColorRGBHSV> = _init();
		private static var _intermediates:Vector.<ColorRGBHSV> = _init();

		private static var _nearestRGBCache: Object = {};
		private static var _nearestHSVCache: Object = {};

		public static function clearNearestCache():void {
			_nearestRGBCache = {};
			_nearestHSVCache = {};
		}

		private static function _init():Vector.<ColorRGBHSV> {
			var v:Vector.<ColorRGBHSV> = new <ColorRGBHSV>[];
			v.length = 16;

			function createColor(name:String, r:int, b:int, g:int, transparent:Boolean=false):ColorRGBHSV {
				var col:ColorRGBHSV = ColorRGBHSV.fromRGB(255 * (r/7),255 * (g/7),255 * (b/7), transparent ? 0x00: 0xFF );
				col.name = name;
				return col;
			}

			// MSX2以降のデフォルトパレット (MSX1とはちょと色が違う)
			// @see http://ngs.no.coocan.jp/doc/wiki.cgi/TechHan?page=2%BE%CF+MSX+BASIC+ver2.0+%A4%CE%CA%D1%B9%B9%C5%C0
			v[0x00] = createColor("透明", 0, 0, 0, true);
			v[0x01] = createColor("黒", 0, 0, 0);
			v[0x02] = createColor("緑", 1, 1, 6);
			v[0x03] = createColor("明るい緑", 3, 3, 7);
			v[0x04] = createColor("暗い青", 1, 7, 1);
			v[0x05] = createColor("明るい青", 2, 7, 3);
			v[0x06] = createColor("暗い赤", 5, 1, 1);
			v[0x07] = createColor("シアン", 2, 7, 6);
			v[0x08] = createColor("赤", 7, 1, 1);
			v[0x09] = createColor("明るい赤", 5, 1, 1);
			v[0x0A] = createColor("暗い黄", 6, 1, 6);
			v[0x0B] = createColor("明るい黄", 6, 3, 6);
			v[0x0C] = createColor("暗い緑", 1, 1, 4);
			v[0x0D] = createColor("マゼンタ", 6, 5, 2);
			v[0x0E] = createColor("灰", 5, 5, 5);
			v[0x0F] = createColor("白", 7, 7, 7);

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

		private var _name:String;

		public function Msx2Screen5ColorPalette(name:String="msx2 screen5 palette") {
			_name = name;
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


/*

@see http://www.wizforest.com/OldGood/ntsc/famicom.html#color


 **/
