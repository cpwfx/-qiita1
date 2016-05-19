package harayoki.util {
	public class ColorUtil {

		/** RGB -> HSB(Object)
		 * @param r 0～255
		 * @param g 0～255
		 * @param b 0～255
		 * @return {h:hue, s:saturation b:brightness}
		 */
		public static function Rgb2HsbObj(r:int, g:int, b:int):Object {
			var cmax:Number = Math.max(r, g, b);
			var cmin:Number = Math.min(r, g, b);
			var brightness:Number = cmax / 255;
			var hue:Number = 0;
			var saturation:Number = (cmax != 0) ? (cmax - cmin) / cmax : 0;
			if (saturation != 0) {
				var redc:Number = (cmax - r) / (cmax - cmin);
				var greenc:Number = (cmax - g) / (cmax - cmin);
				var bluec:Number = (cmax - b) / (cmax - cmin);
				if (r == cmax) {
					hue = bluec - greenc;
				} else if (g == cmax) {
					hue = 2.0 + redc - bluec;
				} else {
					hue = 4.0 + greenc - redc;
				}
				hue = hue / 6.0;
				if (hue < 0) {
					hue = hue + 1.0;
				}
			}
			return {h:hue, s:saturation, b:brightness};
		}

		/** HSB -> RGB(Object)
		 * @param hue 0.0 ~ 1.0
		 * @param saturation 0.0 ~ 1.0
		 * @param brightness 0.0 ~ 1.0
		 */
		public static function Hsb2RgbObject(hue:Number, saturation:Number, brightness:Number):Object {
			var r:int = 0;
			var g:int = 0;
			var b:int = 0;
			if (saturation == 0) {
				r = g = b = brightness * 255 + 0.5;
			} else {
				var h:Number = (hue - Math.floor(hue)) * 6.0;
				var f:Number = h - Math.floor(h);
				var p:Number = brightness * (1.0 - saturation);
				var q:Number = brightness * (1.0 - saturation * f);
				var t:Number = brightness * (1.0 - (saturation * (1.0 - f)));
				switch (int(h)) {
					case 0:
						r = brightness * 255 + 0.5;
						g = t * 255 + 0.5;
						b = p * 255 + 0.5;
						break;
					case 1:
						r = q * 255 + 0.5;
						g = brightness * 255 + 0.5;
						b = p * 255 + 0.5;
						break;
					case 2:
						r = p * 255 + 0.5;
						g = brightness * 255 + 0.5;
						b = t * 255 + 0.5;
						break;
					case 3:
						r = p * 255 + 0.5;
						g = q * 255 + 0.5;
						b = brightness * 255 + 0.5;
						break;
					case 4:
						r = t * 255 + 0.5;
						g = p * 255 + 0.5;
						b = brightness * 255 + 0.5;
						break;
					case 5:
						r = brightness * 255 + 0.5;
						g = p * 255 + 0.5;
						b = q * 255 + 0.5;
						break;
				}
			}
			return {r:r, g:g, b:b};
		}


			/** HSB -> RGB(unit)
		 * @param hue 0.0 ~ 1.0
		 * @param saturation 0.0 ~ 1.0
		 * @param brightness 0.0 ~ 1.0
		 */
		public static function Hsb2RgbUint(hue:Number, saturation:Number, brightness:Number):uint {
			var color:Object = Hsb2RgbObject(hue, saturation, brightness);
			return (color.r << 16) | (color.g << 8) | (color.b << 0);
		}
	}
}
