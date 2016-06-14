package harayoki.colors {
	public interface IColorPalette {

		/**
		 * パレット名を得る
		 */
		function get name():String;

		/**
		 * パレット番号でカラーを得る
		 */
		function getByIndex(index:int):ColorRGBHSV;

		/**
		 * すべてのカラーを得る
		 */
		function getAll():Vector.<ColorRGBHSV>;

		/**
		 * HSB空間で最も近いカラーを得る
		 */
		function getNearestByHSB(color:ColorRGBHSV):ColorRGBHSV;

		/**
		 * RGB空間で最も近いカラーを得る
		 */
		function getNearestByRGB(color:ColorRGBHSV):ColorRGBHSV;

	}
}
