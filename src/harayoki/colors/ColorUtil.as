package harayoki.colors {
	public class ColorUtil {

		/** RGB -> HSV(Object)
		 * @param r 0～255
		 * @param g 0～255
		 * @param b 0～255
		 * @param out
		 * @return {h:hue, s:saturation v:brightness}
		 */
		public static function Rgb2HsvObj(r:int, g:int, b:int, out:Object=null):Object {
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
			out = out || {};
			out.h = hue;
			out.s = saturation;
			out.v = brightness;
			return out;
		}

		/** HSV -> RGB(Object)
		 * @param hue 0.0 ~ 1.0
		 * @param saturation 0.0 ~ 1.0
		 * @param brightness 0.0 ~ 1.0
		 * @param out
		 */
		public static function Hsv2RgbObject(hue:Number, saturation:Number, brightness:Number, out:Object=null):Object {
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
			out = out || {};
			out.r = r;
			out.g = g;
			out.b = b;
			return out;
		}


		/** HSB -> RGB(unit)
		 * @param hue 0.0 ~ 1.0
		 * @param saturation 0.0 ~ 1.0
		 * @param brightness 0.0 ~ 1.0
		 */
		public static function Hsv2RgbUint(hue:Number, saturation:Number, brightness:Number):uint {
			var color:Object = Hsv2RgbObject(hue, saturation, brightness);
			return (color.r << 16) | (color.g << 8) | (color.b << 0);
		}
	}
}
