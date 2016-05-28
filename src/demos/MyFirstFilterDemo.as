package demos {
	import harayoki.starling.filters.PosterizationFilter;

	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.filters.BlurFilter;
	import starling.filters.FilterChain;
	import starling.filters.FragmentFilter;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;

	public class MyFirstFilterDemo extends DemoBase {

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _quad3:Quad;
		private var _quad4:Quad;
		private var _filter2:FragmentFilter;
		private var _filter3:FragmentFilter;
		private var _filter4:FragmentFilter;

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
			assets.push("assets/lena.jpg");
		}

		public override function start():void {

			_quad1 = _addImage(50, 40, "ノーマル");
			_quad2 = _addImage(170, 40 , "ポスタリゼーション");
			_quad3 = _addImage(50, 180 , "ポスタ + ブラー");
			_quad4 = _addImage(170, 180 , "ブラー + ポスタ");

			_filter2 = _createPosterizationFilter();
			_filter3 = new FilterChain(_createPosterizationFilter(), _createBlurFilter());
			_filter4 = new FilterChain(_createBlurFilter(), _createPosterizationFilter());

			_toggleFilter();

		}

		private function _createPosterizationFilter():PosterizationFilter {
			return new PosterizationFilter(8, 8, 4, 2); // MSX screen 8
		}

		private function _createBlurFilter():BlurFilter {
			return new BlurFilter(2, 2);
		}

		private function _addImage(xx:int, yy:int, title:String=""):Quad {
			var quad:Quad = Quad.fromTexture(_assetManager.getTexture("lena"));
			quad.x = xx;
			quad.y = yy;
			quad.textureSmoothing = TextureSmoothing.NONE;
			addChild(quad);
			if(title) {
				var sp:DisplayObject = _demoHelper.createSpriteText(title, MyFontManager.baseFont.name, 150);
				sp.x = quad.x;
				sp.y = quad.getBounds(this).bottom + 5;
				addChildAt(sp, 0);
			}
			return quad;
		}

		private function _toggleFilter():void{
			_quad2.filter = _quad2.filter ? null : _filter2;
			_quad3.filter = _quad3.filter ? null : _filter3;
			_quad4.filter = _quad4.filter ? null : _filter4;
		}

	}
}
