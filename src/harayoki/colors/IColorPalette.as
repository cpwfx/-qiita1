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
		 * HSV空間で最も近いカラーを得る
		 */
		function getNearestByHSV(color:ColorRGBHSV):ColorRGBHSV;

		/**
		 * RGB空間で最も近いカラーを得る
		 */
		function getNearestByRGB(color:ColorRGBHSV):ColorRGBHSV;

		/**
		 * HSV空間の距離を計算する際のhue要素の重み付けを調整する
		 */
		function set hueDistanceCalculationRatio(value:Number):void;

		/**
		 * HSV空間の距離を計算する際のhue要素の重み付けを調整する
		 */
		function get hueDistanceCalculationRatio():Number;

		/**
		 * HSV空間の距離を計算する際のsaturation要素の重み付けを調整する
		 */
		function set saturationDistanceCalculationRatio(value:Number):void;

		/**
		 * HSV空間の距離を計算する際のsaturation要素の重み付けを調整する
		 */
		function get saturationDistanceCalculationRatio():Number;

		/**
		 * HSV空間の距離を計算する際のbrightness要素の重み付けを調整する
		 */
		function set brightnessDistanceCalculationRatio(value:Number):void;

		/**
		 * HSV空間の距離を計算する際のbrightness要素の重み付けを調整する
		 */
		function get brightnessDistanceCalculationRatio():Number;

	}
}
