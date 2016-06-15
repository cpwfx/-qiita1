package harayoki.colors {
	public class ColorPaletteBase implements IColorPalette {

		internal var _name:String;
		internal var _colors:Vector.<ColorRGBHSV>;
		internal var _intermediateColoes:Vector.<ColorRGBHSV>;

		internal var _nearestRGBCache: Object = {};
		internal var _nearestHSVCache: Object = {};
		
		public function clearNearestCache():void {
			_nearestRGBCache = {};
			_nearestHSVCache = {};
		}

		public function ColorPaletteBase(name:String) {
			_name = name;
		}

		public function get name():String {
			return _name;
		}

		public function getByIndex(index:int):ColorRGBHSV {
			if(!_colors || _colors.length <= index) {
				return null;
			}
			return _colors[index];
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
