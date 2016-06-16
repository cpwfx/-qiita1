package harayoki.colors {
	public class ColorPaletteBase implements IColorPalette {

		private static var sWorkColors:Vector.<ColorRGBHSV>;
		private static var _tempUint:uint;

		internal var _name:String;
		internal var _colors:Vector.<ColorRGBHSV>;

		internal var _intermediateColorsRGB:Vector.<ColorRGBHSV>;
		internal var _intermediateColorsHSV:Vector.<ColorRGBHSV>;
		internal var _intermediateMapRGB:Object;
		internal var _intermediateMapHSV:Object;

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
			_intermediateColorsRGB = new <ColorRGBHSV>[];
			_intermediateColorsHSV = new <ColorRGBHSV>[];
			_intermediateMapRGB = {};
			_intermediateMapHSV = {};
		}

		public function get name():String {
			return _name;
		}

		public function getColorByIndex(index:uint):ColorRGBHSV {
			if(!_colors || _colors.length <= index) {
				return null;
			}
			return _colors[index];
		}

		internal function _registerIntermediateColor(index1:uint, index2:uint, color:ColorRGBHSV, map:Object, colors:Vector.<ColorRGBHSV>):void {
			if(!color) return;
			if(index1 == index2) return;
			if(index1 > index2) {
				_tempUint = index1;
				index1 = index2;
				index2 = _tempUint;
			}
			var colorSaved:ColorRGBHSV = map[index1+"_"+index2] as ColorRGBHSV;
			if(colorSaved != color) {
				map[ index1+"_"+index2 ] = color;
			}
			var currentIndex:int = colors.indexOf(color);
			if(currentIndex == -1) {
				colors.push(color);
			}
		}

		public function getIntermediateColorRGBByIndex(index1:uint, index2:uint):ColorRGBHSV {
			if(index1 > index2) {
				_tempUint = index1;
				index1 = index2;
				index2 = _tempUint;
			}
			return _intermediateMapRGB[ index1+"_"+index2 ] as ColorRGBHSV;
		}

		public function getIntermediateColorHSVByIndex(index1:uint, index2:uint):ColorRGBHSV {
			if(index1 > index2) {
				_tempUint = index1;
				index1 = index2;
				index2 = _tempUint;
			}
			return _intermediateMapHSV[ index1+"_"+index2 ] as ColorRGBHSV;
		}

		public function getColorsAll():Vector.<ColorRGBHSV> {
			return _colors.slice();
		}

		public function getIntermediateColorsRGBAll():Vector.<ColorRGBHSV> {
			return _intermediateColorsRGB.slice();
		}

		public function getIntermediateColorsHSVAll():Vector.<ColorRGBHSV> {
			return _intermediateColorsHSV.slice();
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

		public function isIntermediateColor(color:ColorRGBHSV):Boolean {
			return color.hasOptionData() && color.optionData.intermediateFrom;
		}

		public function getIntermediateBaseColorIndexes(color:ColorRGBHSV):Vector.<uint> {
			if(color.hasOptionData() && color.optionData.intermediateFrom) {
				return color.optionData.intermediateFrom;
			} else {
				return null;
			}
		}

		public function getNearestByHSV(color:ColorRGBHSV, useIntermediate:Boolean):ColorRGBHSV {

			if(!color) return null;

			var key:String = color.toRGBHexString();
			var found:ColorRGBHSV = _nearestHSVCache[key] as ColorRGBHSV;
			if(found) return found;

			sWorkColors = _colors.slice();
			if(useIntermediate) {
				sWorkColors = sWorkColors.concat(_intermediateColorsHSV);
			}

			var distance:Number = Number.POSITIVE_INFINITY;
			for each( var c:ColorRGBHSV in sWorkColors) {
				var d:Number = ColorRGBHSV.getDistanceByHSVSquared(
					color, c, _hueDistanceCalculationRatio, _saturationDistanceCalculationRatio, _brightnessDistanceCalculationRatio);
				if(isIntermediateColor(c)) {
					//d *= 5.0; //temp baseクラス判定ではない
				}
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

		public function getNearestByRGB(color:ColorRGBHSV, useIntermediate:Boolean):ColorRGBHSV {

			if(!color) return null;

			var key:String = color.toRGBHexString();
			var found:ColorRGBHSV = _nearestRGBCache[key] as ColorRGBHSV;
			if(found) return found;

			sWorkColors = _colors.slice();
			if(useIntermediate) {
				sWorkColors = sWorkColors.concat(_intermediateColorsRGB);
			}

			var distance:Number = Number.POSITIVE_INFINITY;
			for each( var c:ColorRGBHSV in sWorkColors) {
				var d:Number = ColorRGBHSV.getDistanceByRGBSquared(color, c);
				if(isIntermediateColor(c)) {
					d *= 3.0; //temp baseクラス判定ではない
				}
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
