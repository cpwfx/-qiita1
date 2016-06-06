package demos {
	import feathers.controls.Check;
	import feathers.controls.Slider;

	import harayoki.starling.FixedLayoutBitmapTextController;
	import harayoki.starling.filters.PosterizationFilter;
	import harayoki.starling.utils.AssetManager;
	
	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.FilterChain;
	import starling.filters.FragmentFilter;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;
	import starling.utils.AssetManager;
	
	public class MyFirstFilterDemo extends DemoBase {

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _quad3:Quad;
		private var _quad4:Quad;
		private var _filter2:FragmentFilter;
		private var _filter3:FragmentFilter;
		private var _filter4:FragmentFilter;

		public function MyFirstFilterDemo(assetManager:harayoki.starling.utils.AssetManager, starling:Starling = null) {
			 frontDisplay = true;
			super(assetManager, starling);
		}

		public override function getBackgroundDisplay():DisplayObject {
			var bg:Image = new Image(_assetManager.getTexture("white"));
			bg.textureSmoothing = TextureSmoothing.NONE;
			bg.color = 0x111111; // サンプル画像のalphaが見やすいように
			return bg;
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var chk:Check = createDemoCheckBox(function(chk:Check):void{
				_toggleFilter();
			}, true);
			out.push(createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("FILTER")]));

			return out;
		}

		public override function addAssets(assets:Array):void {
		}

		public override function start():void {

			_quad1 = _addImage(50, 30, "Normal");
			_quad2 = _addImage(170, 30 , "Posterization");
			_quad3 = _addImage(50, 170 , "Poster.. + Blur");
			_quad4 = _addImage(170, 170 , "Blur + Poster..");

			var pFilter2:PosterizationFilter =_createPosterizationFilter();
			var pFilter3:PosterizationFilter =_createPosterizationFilter();
			var pFilter4:PosterizationFilter =_createPosterizationFilter();

			_filter2 = pFilter2;
			_filter3 = new FilterChain(pFilter3, _createBlurFilter());
			_filter4 = new FilterChain(_createBlurFilter(), pFilter4);

			_toggleFilter();

			var sliderRed:Slider = _createSlider(30, 320, pFilter2.redDiv, "RED DIV", function(value:int):void{
				pFilter2.redDiv = value;
				pFilter3.redDiv = value;
				pFilter4.redDiv = value;
			});

			var sliderGreen:Slider = _createSlider(30, 350, pFilter2.greenDiv, "GREEN DIV", function(value:int):void{
				pFilter2.greenDiv = value;
				pFilter3.greenDiv = value;
				pFilter4.greenDiv = value;
			});
			var sliderBlue:Slider = _createSlider(30, 380, pFilter2.blueDiv, "BLUE DIV", function(value:int):void{
				pFilter2.blueDiv = value;
				pFilter3.blueDiv = value;
				pFilter4.blueDiv = value;
			});

			var sliderAlpha:Slider = _createSlider(30, 410, pFilter2.alphaDiv, "ALPHA DIV", function(value:int):void{
				pFilter2.alphaDiv = value;
				pFilter3.alphaDiv = value;
				pFilter4.alphaDiv = value;
			});

		}

		private function _createPosterizationFilter():PosterizationFilter {
			return new PosterizationFilter(8, 8, 4, 2); // MSX screen 8 + alpha
		}

		private function _createBlurFilter():BlurFilter {
			return new BlurFilter(4, 2);
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
				sp.y = quad.getBounds(this).bottom + 2;
				addChildAt(sp, 0);
			}
			return quad;
		}

		private function _toggleFilter():void{
			_quad2.filter = _quad2.filter ? null : _filter2;
			_quad3.filter = _quad3.filter ? null : _filter3;
			_quad4.filter = _quad4.filter ? null : _filter4;
		}

		private function _createSlider(xx:int, yy:int, value:int, title:String, onChange:Function):Slider {

			var textWidth:int = 90;
			var textControl:FixedLayoutBitmapTextController;
			textControl = new FixedLayoutBitmapTextController(
				MyFontManager.baseFont.name, title + ": XXX", 0xffffff, 0, textWidth);
			textControl.align = Align.LEFT;
			textControl.setTextWithPadding(title + ": " + value);
			textControl.displayObject.x = xx;
			textControl.displayObject.y = yy;
			addChildAt(textControl.displayObject, 0);

			var slider:Slider = new Slider();
			slider.minimum = 2;
			slider.maximum = 64;
			slider.value = value;
			slider.step = 1;
			slider.scaleY = 0.5;
			slider.x = xx + textWidth + 10;
			slider.y = yy - 3;
			slider.addEventListener(Event.CHANGE, function(ev:Event):void{
				textControl.setTextWithPadding(title + ": " + slider.value);
				onChange(slider.value);
			});
			addChildAt( slider , 0);
			return slider;
		}
	}
}
