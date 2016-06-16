package demos {
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	import harayoki.colors.ColorPaletteUtil;
	import harayoki.colors.ColorRGBHSV;
	import harayoki.colors.Msx1ColorPalette;
	import harayoki.colors.NesColorPalette;
	import harayoki.starling.utils.AssetManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class ColorPaletteTestDemo extends DemoBase {

		private var _harfMatrix:Matrix;
		private var _doubleMatrix:Matrix;
		private var _nesPalette:NesColorPalette;
		private var _msx1Palette1:Msx1ColorPalette;
		private var _msx1Palette2:Msx1ColorPalette;

		public function ColorPaletteTestDemo(assetManager:AssetManager, starling:Starling = null) {
			super(assetManager, starling);
			_harfMatrix = new Matrix();
			_harfMatrix.scale(0.5, 0.5);
			_doubleMatrix = new Matrix();
			_doubleMatrix.scale(2.0, 2.0);
			_msx1Palette1 = new Msx1ColorPalette();
			_msx1Palette2 = new Msx1ColorPalette(true);
			_nesPalette = new NesColorPalette();
			_nesPalette.hueDistanceCalculationRatio = 1.00;
			_nesPalette.saturationDistanceCalculationRatio = 0.50;
			_nesPalette.brightnessDistanceCalculationRatio = 1.50;
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			return out;
		}

		public override function addAssets(assets:Array):void {
			assets.push({ kota0: 'assets/kota.png'});
			assets.push({ kota1: 'assets/kota.png'});
			assets.push({ kota2: 'assets/kota.png'});
			assets.push({ kota3: 'assets/kota.png'});
		}

		public override function beforeTextureCreationCallback(name:String, bmd1:BitmapData):BitmapData {
			var bmd2:BitmapData;
			bmd2 = new BitmapData(bmd1.width/2, bmd1.height/2, bmd1.transparent);
			bmd2.draw(bmd1, _harfMatrix, null, null, null, false);
			if(name == "kota0") {
			}else if(name == "kota1") {
				ColorPaletteUtil.applyPaletteRGB(_nesPalette, false, bmd2, bmd2);
			}
			else if(name == "kota2") {
				ColorPaletteUtil.applyPaletteRGB(_msx1Palette1, true, bmd2, bmd2);
			}
			else if(name == "kota3") {
				ColorPaletteUtil.applyPaletteRGB(_msx1Palette2, true, bmd2, bmd2);
			}
			return bmd2;
		}

		public override function start():void {

			var quad0:Quad = Quad.fromTexture(_assetManager.getTexture("kota0"));
			quad0.x = 1; quad0.y = 2;
			quad0.scale = 1.0;
			quad0.textureSmoothing = TextureSmoothing.NONE;
			addChild(quad0);

			var quad1:Quad = Quad.fromTexture(_assetManager.getTexture("kota1"));
			quad1.x = 162; quad1.y = 2;
			quad1.scale = 1.0;
			quad1.textureSmoothing = TextureSmoothing.NONE;
			addChild(quad1);

			var quad2:Quad = Quad.fromTexture(_assetManager.getTexture("kota2"));
			quad2.x = 1; quad2.y = 125;
			quad2.scale = 1.0;
			quad2.textureSmoothing = TextureSmoothing.NONE;
			addChild(quad2);

			var quad3:Quad = Quad.fromTexture(_assetManager.getTexture("kota3"));
			quad3.x = 162; quad3.y = 125;
			quad3.scale = 1.0;
			quad3.textureSmoothing = TextureSmoothing.NONE;
			addChild(quad3);

			var texture:Texture;
			var palettes:Vector.<ColorRGBHSV>;
			var i:int;
			var c:ColorRGBHSV;
			var quad:Quad;

			texture = _assetManager.getTexture("white");
			palettes = _nesPalette.getColorsAll();
			for (i=0;i<palettes.length;i++) {
				c = palettes[i];
				trace("NesPalette#"+i, c);
				texture = _assetManager.getTexture("white");
				quad = Quad.fromTexture(texture);
				quad.textureSmoothing = TextureSmoothing.NONE;
				quad.width = 16;
				quad.height = 16;
				quad.alpha = c.a;
				quad.color = c.toRGBNumber();
				quad.x = 32 + 16 * (i % 16);
				quad.y = 280 + 16 * ~~(i / 16);
				addChild(quad);
			}
			
			var distanceRGB:uint =
				ColorRGBHSV.getDistanceByRGBSquared(_nesPalette.getColorByIndex(10), _nesPalette.getColorByIndex(11));
			trace("distanceRGB", distanceRGB);
			
			var distanceHSV:Number =
				ColorRGBHSV.getDistanceByHSVSquared(_nesPalette.getColorByIndex(10), _nesPalette.getColorByIndex(11));
			trace("distanceHSV", distanceHSV);

			palettes = _msx1Palette1.getColorsAll();
			for (i=0;i<palettes.length;i++) {
				c = palettes[i];
				trace("Msx1Palette1#"+i, c);
				quad = Quad.fromTexture(texture);
				quad.textureSmoothing = TextureSmoothing.NONE;
				quad.width = 16;
				quad.height = 16;
				quad.color = c.toRGBNumber();
				quad.alpha = c.a;
				quad.x = 32 + 16 * (i % 16);
				quad.y = 360 + 16 * ~~(i / 16);
				addChild(quad);
			}

			palettes = _msx1Palette2.getColorsAll();
			for (i=0;i<palettes.length;i++) {
				c = palettes[i];
				trace("Msx1Palette2#"+i, c);
				quad = Quad.fromTexture(texture);
				quad.textureSmoothing = TextureSmoothing.NONE;
				quad.width = 16;
				quad.height = 16;
				quad.color = c.toRGBNumber();
				quad.alpha = c.a;
				quad.x = 32 + 16 * (i % 16);
				quad.y = 376 + 8 + 16 * ~~(i / 16);
				addChild(quad);
			}

			//c = ColorRGBHSV.fromRGBColor(0xff0000);
			//trace(c);


		}

	}
}
