package demos {
	import feathers.controls.Check;
	import feathers.controls.Slider;

	import flash.geom.Rectangle;

	import harayoki.starling2.FixedLayoutBitmapTextController;
	import harayoki.starling2.filters.ScanLineFilter;
	import harayoki.starling2.utils.AssetManager;

	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.FilterChain;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;

	public class ScanLineFilterDemo extends DemoBase {
		
		public static var  CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320 *2, 240 * 2 * 2);

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _filter1:ScanLineFilter;
		private var _filter2:ScanLineFilter;
		private var _filter3:ScanLineFilter;
		private var _filterChain:FilterChain;
		private var _rotation:Boolean = false;

		public function ScanLineFilterDemo(assetManager:AssetManager, starling:Starling = null) {
			 frontDisplay = true;
			super(assetManager, starling);
		}

		public override function getBackgroundDisplay():DisplayObject {
			var bg:Image = new Image(_assetManager.getTexture("white"));
			bg.textureSmoothing = TextureSmoothing.NONE;
			bg.color = 0x333333; // サンプル画像のalphaが見やすいように
			return bg;
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {

			var chk1:Check = createDemoCheckBox(function(chk:Check):void{
				_toggleFilter();
			}, true);
			out.push(createDemoWrapSprite(new <DisplayObject>[chk1, createDemoText("TOGGLE FILTER")]));

			var chk2:Check = createDemoCheckBox(function(chk:Check):void{
				_toggleRotate();
			}, false);
			out.push(createDemoWrapSprite(new <DisplayObject>[chk2, createDemoText("ROTATE")]));

			return out;
		}

		public override function addAssets(assets:Array):void {
			assets.push("assets/lenna240.png");
			assets.push("assets/manmaru240.png");
			assets.push("assets/himawari240.png");
		}

		public override function start():void {

			var r:Number = 0.0;
			var g:Number = 0.0;
			var b:Number = 0.0;
			var defaultColor = ((r*255) << 16) + ((g*255) << 8) + ((b*255) << 0);

			_quad1 = _addImage(50, 10, "Scanline filter");
			_quad1.scale = 1.0;
			_quad2 = _addImage(_quad1.x + _quad1.width * 0.5 + 20, _quad1.y - _quad1.height * 0.5, "Overlap another filter");
			_quad2.scale = 1.0;

			_filter1 = _createScanLineFilter(defaultColor);
			_filter2 = _createScanLineFilter(defaultColor);
			_filter3 = _createScanLineFilter(defaultColor);
			_filter3.degree = 45;
			_filterChain = new FilterChain(_filter2, _filter3);

			_toggleFilter();

			var getColor:Function = function():uint {
				return ((sliderRed.value*255) << 16) + ((sliderGreen.value*255) << 8) + ((sliderBlue.value*255) << 0);
			}

			var XX:int = 20;
			var YY:int = 290;
			var DY:int = 20;

			var sliderDistance:Slider = _createSlider(XX, YY, _filter1.disatance, -8, 8, 1, "DISTANCE", function(value:int):void{
				_filter1.disatance = value;
				_filter2.disatance = value;
			});
			YY += DY;

			var sliderScale:Slider = _createSlider(XX, YY, _filter1.scale, 1, 16, 1, "SCALE   ", function(value:int):void{
				_filter1.scale = value;
				_filter2.scale = value;
			});
			YY += DY;

			var sliderDegree:Slider = _createSlider(XX, YY, _filter1.degree, 0, 360, 5, "DIGREE  ", function(value:int):void{
				_filter1.degree = value;
				_filter2.degree = value;
			});
			YY += DY;

			var sliderOffset:Slider = _createSlider(XX, YY, _filter2.offset, 0, 100, 1, "OFFSET  ", function(value:int):void{
				_filter1.offset = value;
				_filter2.offset = value;
			});
			YY += DY;

			var sliderRed:Slider = _createSlider(XX, YY, r, 0, 1, 0.01, "RED     ", function(value:int):void{
				_filter1.color = getColor();
				_filter2.color = getColor();
			});
			YY += DY;

			var sliderGreen:Slider = _createSlider(XX, YY, g, 0, 1, 0.01, "GREEN   ", function(value:int):void{
				_filter1.color = getColor();
				_filter2.color = getColor();
			});
			YY += DY;

			var sliderBlue:Slider = _createSlider(XX, YY, b, 0, 1, 0.01, "BLUE    ", function(value:int):void{
				_filter1.color = getColor();
				_filter2.color = getColor();
			});
			YY += DY;

			var sliderAlpha:Slider = _createSlider(XX, YY, _filter1.alpha, 0, 1, 0.01, "ALPHA   ", function(value:int):void{
				_filter1.alpha = value;
				_filter2.alpha = value;
			});
			YY += DY;

			addEventListener(EnterFrameEvent.ENTER_FRAME, function(ev:EnterFrameEvent):void{
				if(_rotation) {
					_quad1.rotation += 0.01;
				} else {
					_quad1.rotation = 0.0;
				}
				_quad2.rotation = _quad1.rotation;
			});

		}

		private function _createScanLineFilter(color:uint):ScanLineFilter {
			return new ScanLineFilter();
		}

		private function _addImage(xx:int, yy:int, title:String=""):Quad {
			var quad:Quad = Quad.fromTexture(_assetManager.getTexture("lenna240"));
			addChild(quad);
			quad.x = xx;
			quad.y = yy;
			quad.textureSmoothing = TextureSmoothing.NONE;
			if(title) {
				var sp:DisplayObject = _demoHelper.createSpriteText(title, MyFontManager.baseFont.name, 150);
				sp.x = quad.x;
				sp.y = quad.getBounds(this).bottom + 2;
				addChildAt(sp, 0);
			}
			quad.alignPivot();
			quad.x += quad.width >> 1;
			quad.y += quad.height >> 1;
			return quad;
		}

		private function _toggleFilter():void{
			_quad1.filter = _quad1.filter ? null : _filter1;
			_quad2.filter = _quad2.filter == _filterChain ? _filter3 : _filterChain;
		}

		private function _toggleRotate():void {
			_rotation = !_rotation;
		}

		private function _createSlider(xx:int, yy:int, value:int, min:Number, max:Number, step:Number, title:String, onChange:Function):Slider {

			var textWidth:int = 100;
			var textControl:FixedLayoutBitmapTextController;
			textControl = new FixedLayoutBitmapTextController(
				MyFontManager.baseFont.name, title + ": XXXX", 0xffffff, 0, textWidth);
			textControl.align = Align.LEFT;
			textControl.setTextWithPadding(title + ": " + value);
			textControl.displayObject.x = xx;
			textControl.displayObject.y = yy;
			addChildAt(textControl.displayObject, 0);

			var slider:Slider = new Slider();
			slider.minimum = min;
			slider.maximum = max;
			slider.value = value;
			slider.step = step;
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
