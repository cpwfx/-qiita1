package harayoki.colors {
	import flash.display.BitmapData;

	import harayoki.colors.ColorRGBHSV;

	import harayoki.colors.IColorPalette;

	public class ColorPaletteUtil {

		private static var _workColor:ColorRGBHSV = new ColorRGBHSV();

		public static function applyPaletteRGB(
			palette:IColorPalette,
			useIntermediate:Boolean,
			bmd:BitmapData,
			out:BitmapData=null
		):BitmapData {
			if(!out) {
				out = new BitmapData(bmd.width, bmd.height, true, 0);
			}

			var colors:Vector.<uint> = bmd.getVector(bmd.rect);

			for (var yy:uint = 0; yy < bmd.height; yy++) {
				for (var xx:uint = 0; xx < bmd.width; xx++) {
					var index:int = xx + yy * bmd.width;
					_workColor.updateARGBNumber(colors[index]);
					var color:ColorRGBHSV = palette.getNearestByRGB(_workColor, useIntermediate);
					//中間色ならディザ処理
					var intermediateFrom:Vector.<uint> = palette.getIntermediateBaseColorIndexes(color);
					if(intermediateFrom) {
						color = palette.getColorByIndex(intermediateFrom[(xx % 2 * 0 + yy % 2) == 1 ? 0 : 1])
					}
					colors[index] = color.toARGBNumber();
				}
			}

			out.setVector(bmd.rect, colors);

			return out;
		}

		public static function applyPaletteHSV(
			palette:IColorPalette,
			useIntermediate:Boolean,
			bmd:BitmapData,
			out:BitmapData=null
		):BitmapData {
			if(!out) {
				out = new BitmapData(bmd.width, bmd.height, true, 0);
			}

			var colors:Vector.<uint> = bmd.getVector(bmd.rect);

			for (var yy:uint = 0; yy < bmd.height; yy++) {
				for (var xx:uint = 0; xx < bmd.width; xx++) {
					var index:int = xx + yy * bmd.width;
					_workColor.updateARGBNumber(colors[index]);
					var color:ColorRGBHSV = palette.getNearestByHSV(_workColor, useIntermediate);
					//中間色ならディザ処理
					var intermediateFrom:Vector.<uint> = palette.getIntermediateBaseColorIndexes(color);
					if(intermediateFrom) {
						//color = palette.getColorByIndex(intermediateFrom[(xx % 2 + yy % 2) == 1 ? 0 : 1])
					}
					colors[index] = color.toARGBNumber();
				}
			}

			out.setVector(bmd.rect, colors);

			return out;
		}

	}
}
