package demos {
	import flash.display.BitmapData;

	import harayoki.colors.ColorPaletteUtil;

	import harayoki.colors.ColorRGBHSV;
	import harayoki.colors.IColorPalette;
	import harayoki.colors.Msx2Screen5ColorPalette;
	import harayoki.colors.NesColorPalette;
	import harayoki.starling.utils.AssetManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class ColorPaletteTestDemo extends DemoBase {

		private var _nesPalette:NesColorPalette = new NesColorPalette();
		private var _msx1Palette:Msx2Screen5ColorPalette = new Msx2Screen5ColorPalette();

		public function ColorPaletteTestDemo(assetManager:AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			return out;
		}

		public override function addAssets(assets:Array):void {
			assets.push({ kota0: 'assets/kota.png'});
			assets.push({ kota1: 'assets/kota.png'});
			assets.push({ kota2: 'assets/kota.png'});
		}

		public override function beforeTextureCreationCallback(name:String, bmd:BitmapData):Boolean {
			if(name == "kota1") {
				ColorPaletteUtil.applyPaletteRGB(_nesPalette, bmd, bmd);
			}
			else if(name == "kota2") {
				ColorPaletteUtil.applyPaletteRGB(_msx1Palette, bmd, bmd);
			}
			return true;
		}

		public override function start():void {

			var quad0:Quad = Quad.fromTexture(_assetManager.getTexture("kota0"));
			quad0.x = 1; quad0.y = 2;
			quad0.scale = 0.5;
			addChild(quad0);

			var quad1:Quad = Quad.fromTexture(_assetManager.getTexture("kota1"));
			quad1.x = 1; quad1.y = 125;
			quad1.scale = 0.5;
			addChild(quad1);

			var quad2:Quad = Quad.fromTexture(_assetManager.getTexture("kota2"));
			quad2.x = 162; quad2.y = 125;
			quad2.scale = 0.5;
			addChild(quad2);

			var texture:Texture;
			var palettes:Vector.<ColorRGBHSV>;
			var i:int;
			var c:ColorRGBHSV;
			var quad:Quad;

			texture = _assetManager.getTexture("white");
			palettes = _nesPalette.getAll();
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

			var intermediateHSV:ColorRGBHSV =
				ColorRGBHSV.getIntermediateColorByHSV(_nesPalette.getByIndex(10), _nesPalette.getByIndex(11));
			trace("intermediateHSV", intermediateHSV);

			var intermediateRGB:ColorRGBHSV =
				ColorRGBHSV.getIntermediateColorByRGB(_nesPalette.getByIndex(10), _nesPalette.getByIndex(11));
			trace("intermediateRGB", intermediateRGB);
			
			var distanceRGB:uint =
				ColorRGBHSV.getDistanceByRGBSquared(_nesPalette.getByIndex(10), _nesPalette.getByIndex(11));
			trace("distanceRGB", distanceRGB);
			
			var distanceHSV:Number =
				ColorRGBHSV.getDistanceByHSVSquared(_nesPalette.getByIndex(10), _nesPalette.getByIndex(11));
			trace("distanceHSV", distanceHSV);

			trace("nearestHSV", _nesPalette.getNearestByHSB(ColorRGBHSV.fromRGB(255, 0, 0)));
			trace("nearestHSV", _nesPalette.getNearestByHSB(ColorRGBHSV.fromRGB(255, 0, 0)));

			trace("getNearestByRGB", _nesPalette.getNearestByRGB(ColorRGBHSV.fromRGB(255, 0, 0)));
			trace("getNearestByRGB", _nesPalette.getNearestByRGB(ColorRGBHSV.fromRGB(255, 0, 0)));

			palettes = _msx1Palette.getAll();
			for (i=0;i<palettes.length;i++) {
				c = palettes[i];
				trace("Msx1Palette#"+i, c.name + " : " + c.toRGBHexString());
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

		}

	}
}
