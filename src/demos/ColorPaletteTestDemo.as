package demos {
	import harayoki.colors.ColorRGBHSV;
	import harayoki.colors.IColorPalette;
	import harayoki.colors.NesColorPalette;
	import harayoki.starling.utils.AssetManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class ColorPaletteTestDemo extends DemoBase {

		public function ColorPaletteTestDemo(assetManager:AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			return out;
		}

		public override function start():void {

			var palette:IColorPalette = new NesColorPalette();

			var texture:Texture;
			var palettes:Vector.<ColorRGBHSV> = palette.getAll();
			for (var i:int=0;i<palettes.length;i++) {
				var c:ColorRGBHSV = palettes[i];
				trace("NesPalette#"+i, c);
				texture = _assetManager.getTexture("white");
				var quad:Quad = Quad.fromTexture(texture);
				quad.textureSmoothing = TextureSmoothing.NONE;
				quad.width = 16;
				quad.height = 16;
				quad.color = c.toRGBNumber();
				quad.x = 32 + 16 * (i % 16);
				quad.y = 32 + 16 * ~~(i / 16);
				addChild(quad);
			}

			var intermediateHSV:ColorRGBHSV =
				ColorRGBHSV.getIntermediateColorByHSV(palette.getByIndex(10), palette.getByIndex(11));
			trace("intermediateHSV", intermediateHSV);

			var intermediateRGB:ColorRGBHSV =
				ColorRGBHSV.getIntermediateColorByRGB(palette.getByIndex(10), palette.getByIndex(11));
			trace("intermediateRGB", intermediateRGB);
			
			var distanceRGB:uint =
				ColorRGBHSV.getDistanceByRGBSquared(palette.getByIndex(10), palette.getByIndex(11));
			trace("distanceRGB", distanceRGB);
			
			var distanceHSV:Number =
				ColorRGBHSV.getDistanceByHSVSquared(palette.getByIndex(10), palette.getByIndex(11));
			trace("distanceHSV", distanceHSV);

			trace("nearestHSV", palette.getNearestByHSB(ColorRGBHSV.fromRGB(255, 0, 0)));

			trace("getNearestByRGB", palette.getNearestByRGB(ColorRGBHSV.fromRGB(255, 0, 0)));
		}

	}
}
