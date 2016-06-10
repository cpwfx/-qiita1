package harayoki.colors {
	import starling.utils.Color;

	public class NesPalette {
		//public static const A:ColorRGBHSV = ColorRGBHSV.fromHSV(0,0,0);

		private static var _colors:Vector.<ColorRGBHSV> = _init();

		private static function _init():Vector.<ColorRGBHSV> {
			var v:Vector.<ColorRGBHSV> = new <ColorRGBHSV>[];
			v.length = 64;


			//モノクロ行1
			v[0x00] = ColorRGBHSV.fromRGBColor(0x757575); //00 #757575 117 117 117
			v[0x10] = ColorRGBHSV.fromRGBColor(0xBCBCBC); //10 #BCBCBC 188 188 188
			v[0x20] = ColorRGBHSV.fromRGBColor(0xFFFFFF); //20 #FFFFFF 255 255 255
			v[0x30] = v[0x20]; //30 #FFFFFF 255 255 255
			//モノクロ行2
			v[0x0D] = ColorRGBHSV.fromRGBColor(0x000000); //0D #000000 000 000 000
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
			v[0x01] = ColorRGBHSV.fromRGBColor(0x271B8F); //01 #271B8F 039 027 143
			v[0x11] = ColorRGBHSV.fromRGBColor(0x0073EF); //11 #0073EF 000 115 239
			v[0x21] = ColorRGBHSV.fromRGBColor(0x3FBFFF); //21 #3FBFFF 063 191 255
			v[0x31] = ColorRGBHSV.fromRGBColor(0xABE7FF); //31 #ABE7FF 171 231 255

			//青の行
			v[0x02] = ColorRGBHSV.fromRGBColor(0x0000AB); //02 #0000AB 000 000 171
			v[0x12] = ColorRGBHSV.fromRGBColor(0x233BEF); //12 #233BEF 035 059 239
			v[0x22] = ColorRGBHSV.fromRGBColor(0x5F73FF); //22 #5F73FF 095 115 255
			v[0x32] = ColorRGBHSV.fromRGBColor(0xC7D7FF); //32 #C7D7FF 199 215 255

			//青紫の行

			//紫の行

			//赤紫の行

			//赤の行

			//オレンジの行

			//茶色の行

			//緑の行

			//緑の行

			//緑の行

			//緑の行

			//v[0x] = ColorRGBHSV.fromRGBColor(0x); //

			return v;
		}

		public static function getByIndex(index:int):ColorRGBHSV {
			var col:ColorRGBHSV = _colors[index];
			return col;
		}

		public static function getAll():Vector.<ColorRGBHSV> {
			return _colors.slice();
		}
	}
}


/*

@see http://www.wizforest.com/OldGood/ntsc/famicom.html#color


03 #47009F 071 000 159

04 #8F0077 143 000 119

05 #AB0013 171 000 019

06 #A70000 167 000 000

07 #7F0B00 127 011 000

08 #432F00 067 047 000

09 #004700 000 071 000

0A #005100 000 081 000

0B #003F17 000 063 023

0C #1B3F5F 027 063 095


13 #8300F3 131 000 243

14 #BF00BF 191 000 191

15 #E7005B 231 000 091

16 #DB2B00 219 043 000

17 #CB4F0F 203 079 015

18 #8B7300 139 115 000

19 #009700 000 151 000

1A #00AB00 000 171 000

1B #00933B 000 147 059

1C #00838B 000 131 139

23 #A78BFD 167 139 253

24 #F77BFF 247 123 255

25 #FF77B7 255 119 183

26 #FF7763 255 119 099

27 #FF9B3B 255 155 059

28 #F3BF3F 243 191 063

29 #83D313 131 211 019

2A #4FDF4B 079 223 075

2B #58F898 088 248 152

2C #00EBDB 000 235 219

33 #D7CBFF 215 203 255

34 #FFC7FF 255 199 255

35 #FFC7DB 255 199 219

36 #FFBFB3 255 191 179

37 #FFDBAB 255 219 171

38 #FFE7A3 255 231 163

39 #E3FFA3 227 255 163

3A #ABF3BF 171 243 191

3B #B3FFCF 179 255 207

3C #9FFFF3 159 255 243

 **/
