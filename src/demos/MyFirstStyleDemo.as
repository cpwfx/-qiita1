package demos {
	import feathers.controls.Check;
	import feathers.controls.Slider;

	import harayoki.starling.FixedLayoutBitmapTextController;
	import harayoki.starling.styles.PosterizationStyle;

	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.FragmentFilter;
	import starling.styles.MeshStyle;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class MyFirstStyleDemo extends DemoBase {

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _quad3:Quad;
		private var _quad4:Quad;

		private var _filter4:FragmentFilter;

		private var _style2:PosterizationStyle;
		private var _style3:PosterizationStyle;
		private var _style4:PosterizationStyle;

		public function MyFirstStyleDemo(assetManager:AssetManager, starling:Starling = null) {
			 frontDisplay = true;
			super(assetManager, starling);
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			var chk:Check;
			chk = createDemoCheckBox(function(chk:Check):void{
				_setStyle(chk.isSelected);
			}, true);
			out.push(createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("STYLE")]));

			chk = createDemoCheckBox(function(chk:Check):void{
				_toggleFilter();
			}, true);
			out.push(createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("FILTER")]));

			return out;
		}

		public override function addAssets(assets:Array):void {
		}

		public override function start():void {

			_quad1 = _addImage(50, 30, "Default Style");
			_quad2 = _addImage(170, 30 , "Posterization(Fixed)");
			_quad3 = _addImage(50, 170 , "Posterization2");
			_quad4 = _addImage(170, 170 , "Poster.. + Blur");

			_filter4 = new BlurFilter(4,4);

			_style2 = _createPosterizationStyle(8, 8, 4, 2); // MSX screen8
			_style3 = _createPosterizationStyle(3, 3, 12, 4);
			_style4 = _createPosterizationStyle(3, 3, 12, 4);

			_toggleFilter();
			_setStyle(true);

			var sliderRed:Slider = _createSlider(30, 320, _style3.redDiv, "RED DIV", function(value:int):void{
				_style3.redDiv = value;
				_style4.redDiv = value;
			});

			var sliderGreen:Slider = _createSlider(30, 350, _style3.greenDiv, "GREEN DIV", function(value:int):void{
				_style3.greenDiv = value;
				_style4.greenDiv = value;
			});
			var sliderBlue:Slider = _createSlider(30, 380, _style3.blueDiv, "BLUE DIV", function(value:int):void{
				_style3.blueDiv = value;
				_style4.blueDiv = value;
			});

			var sliderAlpha:Slider = _createSlider(30, 410, _style3.alphaDiv, "ALPHA DIV", function(value:int):void{
				_style3.alphaDiv = value;
				_style4.alphaDiv = value;
			});

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

		private function _toggleFilter():void {
			_quad4.filter = _quad4.filter ? null : _filter4;
		}

		private function _setStyle(active:Boolean):void{
			_quad2.setStyle(active ? _style2 : null);
			_quad3.setStyle(active ? _style3 : null);
			_quad4.setStyle(active ? _style4 : null);

			// force update if is is skipUnchangedFrames is true.
			// 強制画面更新(skipUnchangedFramesがtrueだとStyleをNullにしただけだと更新が入らない
			alpha = 0.9999999;
			alpha = 1.0;

		}

		private function _createPosterizationStyle(rDiv:int,gDiv:int,bDiv:int,aDiv:int):PosterizationStyle {
			return new PosterizationStyle(rDiv, gDiv, bDiv, aDiv);
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
