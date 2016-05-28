package demos {
	import harayoki.starling.filters.PosterizationFilter;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class MyFirstFilterDemo extends DemoBase {

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _filter:PosterizationFilter;

		public function MyFirstFilterDemo(assetManager:AssetManager, starling:Starling = null) {
			 frontDisplay = true;
			super(assetManager, starling);
		}

		public override function getBottomButtons(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var btn:DisplayObject;
			var bgTexture:Texture = _assetManager.getTexture("border1");

			btn = _demoHelper.createButton(_createText("TOGGLE FILTER"), function():void {
				_toggleFilter();
			}, bgTexture);
			out.push(btn);

			return out;
		}

		public override function addAssets(assets:Array):void {
			assets.push("assets/lena.png");
		}

		public override function start():void {

			_quad1= Quad.fromTexture(_assetManager.getTexture("lena"));
			_quad1.x = 92;
			_quad1.y = 20;
			_quad1.textureSmoothing = TextureSmoothing.NONE;
			addChild(_quad1);

			_quad2 = Quad.fromTexture(_assetManager.getTexture("lena"));
			_quad2.x = 92;
			_quad2.y = 180;
			_quad2.textureSmoothing = TextureSmoothing.NONE;
			addChild(_quad2);

			_filter = new PosterizationFilter(8, 8, 4, 2); // MSX screen 8
			_quad2.filter = _filter;

		}

		private function _toggleFilter():void{
			_quad2.filter = _quad2.filter ? null : _filter;
		}

	}
}
