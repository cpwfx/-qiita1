package harayoki.colors {
	public interface IColorPalette {

		/**
		 * パレット名を得る
		 */
		function get name():String;

		/**
		 * パレット番号でカラーを得る
		 */
		function getColorByIndex(index:uint):ColorRGBHSV;

		/**
		 * ２つのカラーの中間カラー(RGB)を得る
		 */
		function getIntermediateColorRGBByIndex(index1:uint, index2:uint):ColorRGBHSV;

		/**
		 * ２つのカラーの中間カラー(HSV)を得る
		 */
		function getIntermediateColorHSVByIndex(index1:uint, index2:uint):ColorRGBHSV;

		/**
		 * すべてのカラーを得る
		 */
		function getColorsAll():Vector.<ColorRGBHSV>;

		/**
		 * すべての中間カラー(RGB)を得る
		 */
		function getIntermediateColorsRGBAll():Vector.<ColorRGBHSV>;

		/**
		 * すべての中間カラー(HSV)を得る
		 */
		function getIntermediateColorsHSVAll():Vector.<ColorRGBHSV>;

		/**
		 * HSV空間で最も近いカラーを得る
		 */
		function getNearestByHSV(color:ColorRGBHSV, useIntermediate:Boolean):ColorRGBHSV;

		/**
		 * RGB空間で最も近いカラーを得る
		 */
		function getNearestByRGB(color:ColorRGBHSV, useIntermediate:Boolean):ColorRGBHSV;

		/**
		 * そのカラーは中間色か？
		 */
		function isIntermediateColor(color:ColorRGBHSV):Boolean;

		/**
		 * 中間色の場合、元となったカラー番号を返す
		 * ある場合fixedなVector(編集不可)、ない場合nullが帰る
		 */
		function getIntermediateBaseColorIndexes(color:ColorRGBHSV):Vector.<uint>;

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
