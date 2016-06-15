package harayoki.colors {
	public class ColorPaletteBase implements IColorPalette {

		internal var _name:String;
		internal var _colors:Vector.<ColorRGBHSV>;
		internal var _intermediateColoes:Vector.<ColorRGBHSV>;

		internal var _hueDistanceCalculationRatio:Number = 1.0;
		internal var _saturationDistanceCalculationRatio:Number = 1.0;
		internal var _brightnessDistanceCalculationRatio:Number = 1.0;

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

		public function set hueDistanceCalculationRatio(value:Number):void {
			_hueDistanceCalculationRatio = value;
		}

		public function get hueDistanceCalculationRatio():Number {
			return _hueDistanceCalculationRatio;
		}

		public function set saturationDistanceCalculationRatio(value:Number):void {
			_saturationDistanceCalculationRatio = value;
		}

		public function get saturationDistanceCalculationRatio():Number {
			return _saturationDistanceCalculationRatio;
		}

		public function set brightnessDistanceCalculationRatio(value:Number):void{
			_brightnessDistanceCalculationRatio = value;
		};

		public function get brightnessDistanceCalculationRatio():Number{
			return _brightnessDistanceCalculationRatio;
		};

		public function getNearestByHSV(color:ColorRGBHSV):ColorRGBHSV {

			if(!color) return null;

			var key:String = color.toRGBHexString();
			var found:ColorRGBHSV = _nearestHSVCache[key] as ColorRGBHSV;
			if(found) return found;

			var distance:Number = Number.POSITIVE_INFINITY;
			for each( var c:ColorRGBHSV in _colors) {
				var d:Number = ColorRGBHSV.getDistanceByHSVSquared(
					color, c, _hueDistanceCalculationRatio, _saturationDistanceCalculationRatio, _brightnessDistanceCalculationRatio);
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
