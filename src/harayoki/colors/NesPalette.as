package harayoki.colors {
	import starling.utils.Color;

	public class NesPalette {
		//public static const A:ColorRGBHSV = ColorRGBHSV.fromHSV(0,0,0);

		private static var _colors:Vector.<ColorRGBHSV> = _init();

		private static function _init():Vector.<ColorRGBHSV> {
			var v:Vector.<ColorRGBHSV> = new <ColorRGBHSV>[];
			v.length = 64;


			//モノクロ行1
			v[0x00] = ColorRGBHSV.fromRGBColor(0x757575); // 117 117 117
			v[0x10] = ColorRGBHSV.fromRGBColor(0xBCBCBC); // 188 188 188
			v[0x20] = ColorRGBHSV.fromRGBColor(0xFFFFFF); // 255 255 255
			v[0x30] = v[0x20]; //30 #FFFFFF 255 255 255

			//モノクロ行2
			v[0x0D] = ColorRGBHSV.fromRGBColor(0x000000); // 000 000 000
			v[0x1D] = v[0x0D]; //0D #000000 000 000 000
			v[0x2D] = v[0x00]; //2D #757575 117 117 117
			v[0x3D] = v[0x10]; //3D #BCBCBC 188 188 188

			//モノクロ行3
			v[0x0E] = v[0x0D]; //0E #000000 000 000 000
			v[0x1E] = v[0x0D]; //1E #000000 000 000 000
			v[0x2E] = v[0x0D]; //2E #000000 000 000 000
			v[0x3E] = v[0x0D]; //3E #000000 000 000 000

			//モノクロ行4
			v[0x0F] = v[0x0D]; //0F #000000 000 000 000
			v[0x1F] = v[0x0D]; //1F #000000 000 000 000
			v[0x2F] = v[0x0D]; //2F #000000 000 000 000
			v[0x3F] = v[0x0D]; //3F #000000 000 000 000

			//青の多少緑よりっぽい行
			v[0x01] = ColorRGBHSV.fromRGBColor(0x271B8F); // 039 027 143
			v[0x11] = ColorRGBHSV.fromRGBColor(0x0073EF); // 000 115 239
			v[0x21] = ColorRGBHSV.fromRGBColor(0x3FBFFF); // 063 191 255
			v[0x31] = ColorRGBHSV.fromRGBColor(0xABE7FF); // 171 231 255

			//青の行
			v[0x02] = ColorRGBHSV.fromRGBColor(0x0000AB); // 000 000 171
			v[0x12] = ColorRGBHSV.fromRGBColor(0x233BEF); // 035 059 239
			v[0x22] = ColorRGBHSV.fromRGBColor(0x5F73FF); // 095 115 255
			v[0x32] = ColorRGBHSV.fromRGBColor(0xC7D7FF); // 199 215 255

			//青紫の行
			v[0x03] = ColorRGBHSV.fromRGBColor(0x47009F); // 071 000 159
			v[0x13] = ColorRGBHSV.fromRGBColor(0x8300F3); // 131 000 243
			v[0x23] = ColorRGBHSV.fromRGBColor(0xA78BFD); // 167 139 253
			v[0x33] = ColorRGBHSV.fromRGBColor(0xD7CBFF); // 215 203 255

			//紫の行
			v[0x04] = ColorRGBHSV.fromRGBColor(0x8F0077) ; // 143 000 119
			v[0x14] = ColorRGBHSV.fromRGBColor(0xBF00BF) ; // 191 000 191
			v[0x24] = ColorRGBHSV.fromRGBColor(0xF77BFF) ; // 247 123 255
			v[0x34] = ColorRGBHSV.fromRGBColor(0xFFC7FF) ; // 255 199 255

			//赤紫の行
			v[0x05] = ColorRGBHSV.fromRGBColor(0xAB0013) ; // 171 000 019
			v[0x15] = ColorRGBHSV.fromRGBColor(0xE7005B) ; // 231 000 091
			v[0x25] = ColorRGBHSV.fromRGBColor(0xFF77B7) ; // 255 119 183
			v[0x35] = ColorRGBHSV.fromRGBColor(0xFFC7DB) ; // 255 199 219

			//赤の行
			v[0x06] = ColorRGBHSV.fromRGBColor(0xA70000) ; // 167 000 000
			v[0x16] = ColorRGBHSV.fromRGBColor(0xDB2B00) ; // 219 043 000
			v[0x26] = ColorRGBHSV.fromRGBColor(0xFF7763) ; // 255 119 099
			v[0x36] = ColorRGBHSV.fromRGBColor(0xFFBFB3) ; // 255 191 179

			//オレンジの行
			v[0x07] = ColorRGBHSV.fromRGBColor(0x7F0B00) ; // 127 011 000
			v[0x17] = ColorRGBHSV.fromRGBColor(0xCB4F0F) ; // 203 079 015
			v[0x27] = ColorRGBHSV.fromRGBColor(0xFF9B3B) ; // 255 155 059
			v[0x37] = ColorRGBHSV.fromRGBColor(0xFFDBAB) ; // 255 219 171

			//茶色の行
			v[0x08] = ColorRGBHSV.fromRGBColor(0x432F00) ; // 067 047 000
			v[0x18] = ColorRGBHSV.fromRGBColor(0x8B7300) ; // 139 115 000
			v[0x28] = ColorRGBHSV.fromRGBColor(0xF3BF3F) ; // 243 191 063
			v[0x38] = ColorRGBHSV.fromRGBColor(0xFFE7A3) ; // 255 231 163

			//緑の行
			v[0x09] = ColorRGBHSV.fromRGBColor(0x004700) ; // 000 071 000
			v[0x19] = ColorRGBHSV.fromRGBColor(0x009700) ; // 000 151 000
			v[0x29] = ColorRGBHSV.fromRGBColor(0x83D313) ; // 131 211 019
			v[0x39] = ColorRGBHSV.fromRGBColor(0xE3FFA3) ; // 227 255 163

			//緑の行
			v[0x0A] = ColorRGBHSV.fromRGBColor(0x005100) ; // 000 081 000
			v[0x1A] = ColorRGBHSV.fromRGBColor(0x00AB00) ; // 000 171 000
			v[0x2A] = ColorRGBHSV.fromRGBColor(0x4FDF4B) ; // 079 223 075
			v[0x3A] = ColorRGBHSV.fromRGBColor(0xABF3BF) ; // 171 243 191

			//緑の行
			v[0x0B] = ColorRGBHSV.fromRGBColor(0x003F17) ; // 000 063 023
			v[0x1B] = ColorRGBHSV.fromRGBColor(0x00933B) ; // 000 147 059
			v[0x2B] = ColorRGBHSV.fromRGBColor(0x58F898) ; // 088 248 152
			v[0x3B] = ColorRGBHSV.fromRGBColor(0xB3FFCF) ; // 179 255 207

			//緑の行
			v[0x0C] = ColorRGBHSV.fromRGBColor(0x1B3F5F) ; // 027 063 095
			v[0x1C] = ColorRGBHSV.fromRGBColor(0x00838B) ; // 000 131 139
			v[0x2C] = ColorRGBHSV.fromRGBColor(0x00EBDB) ; // 000 235 219
			v[0x3C] = ColorRGBHSV.fromRGBColor(0x9FFFF3) ; // 159 255 243

			return v;
		}

		public static function getByIndex(index:int):ColorRGBHSV {
			var col:ColorRGBHSV = _colors[index];
			return col;
		}

		public static function getAll():Vector.<ColorRGBHSV> {
			return _colors.slice();
		}

		public static function getNearestByHSB(color:ColorRGBHSV):ColorRGBHSV {
			var distance:Number = Number.POSITIVE_INFINITY;
			var found:ColorRGBHSV;
			for each( var c:ColorRGBHSV in _colors) {
				var d:Number = ColorRGBHSV.getDistanceByHSVSquared(color, c);
				if(d == 0) {
					return c;
				}
				if(distance > d) {
					distance = d;
					found = c;
				}
			}
			return found;
		}

		public static function getNearestByRGB(color:ColorRGBHSV):ColorRGBHSV {
			var distance:Number = Number.POSITIVE_INFINITY;
			var found:ColorRGBHSV;
			for each( var c:ColorRGBHSV in _colors) {
				var d:Number = ColorRGBHSV.getDistanceByRGBSquared(color, c);
				if(d == 0) {
					return c;
				}
				if(distance > d) {
					distance = d;
					found = c;
				}
			}
			return found;
		}
	}
}


/*

@see http://www.wizforest.com/OldGood/ntsc/famicom.html#color


 **/
