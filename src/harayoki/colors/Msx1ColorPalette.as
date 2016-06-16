package harayoki.colors {
	public class Msx1ColorPalette extends ColorPaletteBase{

		private static function _createMsx1Color(
			name:String, rgbString:String, transparent:Boolean=false):ColorRGBHSV {
			var col:ColorRGBHSV = ColorRGBHSV.fromRGBString(rgbString);
			if(transparent) {
				col.a = 0;
			}
			col.name = name;
			return col;
		}

		private static function _createMsx2Color(
			name:String, r:int, b:int, g:int, transparent:Boolean=false):ColorRGBHSV {
			var col:ColorRGBHSV = ColorRGBHSV.fromRGB(255 * (r/7),255 * (g/7),255 * (b/7), transparent ? 0x00: 0xFF );
			col.name = name;
			return col;
		}

		private function _createIntermediateColors():void {
			var v:Vector.<ColorRGBHSV> = _colors;
			var distance:Number;
			// 中間色を作る
			for (var i:int = 1 ;i < v.length -1; i++) { //col0は透明なので省く -1は重複省き
				for (var j:int = 1 + 1 ;j< v.length; j++) { //col0は透明なので省く +1は重複省き
					if(j <= i) continue; //同じ色は省く
					var col1:ColorRGBHSV = v[i];
					var col2:ColorRGBHSV = v[j];
					if(j == 15) continue;// 白とのディザは作らない
					if(col1.s !=0 && col2.s != 0) { // 無彩色のディザは通す
						if(i == 2) continue;// test
						if(i == 12) continue;// test
					}
					var intermediateFrom:Vector.<uint> = new <uint>[i, j];
					distance = Math.sqrt(ColorRGBHSV.getDistanceByRGBSquared(col1, col2));
					trace(i,j,distance);
					if((distance < 300 && distance > 100)) { //TODO 調整
						var colRGB:ColorRGBHSV = ColorRGBHSV.getIntermediateColorByRGB(col1, col2);
						colRGB.optionData.intermediateFrom = intermediateFrom;
						_registerIntermediateColor(i, j, colRGB, _intermediateMapRGB, _intermediateColorsRGB);
					}
					var colHSV:ColorRGBHSV = ColorRGBHSV.getIntermediateColorByHSV(col1, col2);
					colHSV.optionData.intermediateFrom = intermediateFrom;
					_registerIntermediateColor(i, j, colHSV, _intermediateMapHSV, _intermediateColorsHSV);
				}
			}
		}

		private function _initMsx1():void {

			var v:Vector.<ColorRGBHSV>;
			v = new <ColorRGBHSV>[];
			v.length = 16;

			//MSX1のパレット
			// @see http://www.wizforest.com/OldGood/ntsc/msx.html

			v[0x00] = _createMsx1Color("透明", "#000000", true);
			v[0x01] = _createMsx1Color("黒", "#000000");
			v[0x02] = _createMsx1Color("緑", "#3EB849");
			v[0x03] = _createMsx1Color("明るい緑", "#74D07D");
			v[0x04] = _createMsx1Color("暗い青", "#5955E0");
			v[0x05] = _createMsx1Color("明るい青", "#8076F1");
			v[0x06] = _createMsx1Color("暗い赤", "#B95E51");
			v[0x07] = _createMsx1Color("シアン", "#65DBEF");
			v[0x08] = _createMsx1Color("赤", "DB6559");
			v[0x09] = _createMsx1Color("明るい赤", "#FF897D");
			v[0x0A] = _createMsx1Color("暗い黄", "#CCC35E");
			v[0x0B] = _createMsx1Color("明るい黄", "#DED087");
			v[0x0C] = _createMsx1Color("暗い緑", "#3AA241");
			v[0x0D] = _createMsx1Color("マゼンタ", "#B766B5");
			v[0x0E] = _createMsx1Color("灰", "#CCCCCC");
			v[0x0F] = _createMsx1Color("白", "#FFFFFF");
			_colors = v;
		}

		private function _initMsx2():void {

			var v:Vector.<ColorRGBHSV>;
			v = new <ColorRGBHSV>[];
			v.length = 16;

			// MSX2以降のデフォルトパレット (MSX1とはちょと色が違う)
			// @see http://ngs.no.coocan.jp/doc/wiki.cgi/TechHan?page=2%BE%CF+MSX+BASIC+ver2.0+%A4%CE%CA%D1%B9%B9%C5%C0
			v[0x00] = _createMsx2Color("透明", 0, 0, 0, true);
			v[0x01] = _createMsx2Color("黒", 0, 0, 0);
			v[0x02] = _createMsx2Color("緑", 1, 1, 6);
			v[0x03] = _createMsx2Color("明るい緑", 3, 3, 7);
			v[0x04] = _createMsx2Color("暗い青", 1, 7, 1);
			v[0x05] = _createMsx2Color("明るい青", 2, 7, 3);
			v[0x06] = _createMsx2Color("暗い赤", 5, 1, 1);
			v[0x07] = _createMsx2Color("シアン", 2, 7, 6);
			v[0x08] = _createMsx2Color("赤", 7, 1, 1);
			v[0x09] = _createMsx2Color("明るい赤", 5, 1, 1);
			v[0x0A] = _createMsx2Color("暗い黄", 6, 1, 6);
			v[0x0B] = _createMsx2Color("明るい黄", 6, 3, 6);
			v[0x0C] = _createMsx2Color("暗い緑", 1, 1, 4);
			v[0x0D] = _createMsx2Color("マゼンタ", 6, 5, 2);
			v[0x0E] = _createMsx2Color("灰", 5, 5, 5);
			v[0x0F] = _createMsx2Color("白", 7, 7, 7);
			_colors = v;
		}

		public function Msx1ColorPalette(useMsx2Mode:Boolean=false,name:String="msx1 palette") {
			super(name);
			_name = name;
			if(useMsx2Mode) {
				_initMsx2();
			} else {
				_initMsx1();
			}
			_createIntermediateColors();
		}
	}
}

