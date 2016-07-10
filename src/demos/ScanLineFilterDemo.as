package demos {
	import feathers.controls.Check;
	import feathers.controls.Radio;
	import feathers.controls.Slider;
	import feathers.core.ToggleGroup;

	import flash.geom.Rectangle;

	import harayoki.starling2.FixedLayoutBitmapTextController;
	import harayoki.starling2.filters.ScanLineFilter;
	import harayoki.starling2.utils.AssetManager;

	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.FilterChain;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;

	public class ScanLineFilterDemo extends DemoBase {
		
		public static var  CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320 *2, 240 * 2 * 2);
		private static const PIC_NAMES:Array = ["PIC1","PIC2","PIC3","PIC4"];

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _filter1:ScanLineFilter;
		private var _filter2:ScanLineFilter;
		private var _filter3:ScanLineFilter;
		private var _filterChain:FilterChain;
		private var _textures:Vector.<Texture>;

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

		//var chk1:Check = createDemoCheckBox(function(chk:Check):void{
		//	_toggleFilter();
		//}, true);
		//out.push(createDemoWrapSprite(new <DisplayObject>[chk1, createDemoText("TOGGLE FILTER")]));

			return out;
		}

		public override function addAssets(assets:Array):void {
			assets.push("assets/lenna240.png");
			assets.push("assets/colors240.png");
			assets.push("assets/manmaru240.png");
			assets.push("assets/himawari240.png");
		}

		public override function start():void {

			_textures = new <Texture>[];
			_textures.push(_assetManager.getTexture("lenna240"));
			_textures.push(_assetManager.getTexture("colors240"));
			_textures.push(_assetManager.getTexture("manmaru240"));
			_textures.push(_assetManager.getTexture("himawari240"));

			var r:Number = 0.0;
			var g:Number = 0.0;
			var b:Number = 0.0;
			var defaultColor = ((r*255) << 16) + ((g*255) << 8) + ((b*255) << 0);

			_quad1 = _addImage(40, 40, _textures[0], "Scanline filter");
			_quad2 = _addImage(
				_quad1.x + 320 - _quad1.width * 0.5, _quad1.y - _quad1.height * 0.5,
				_textures[0], "Overlap another filter"
			);

			_filter1 = _createScanLineFilter(defaultColor);
			_filter2 = _createScanLineFilter(defaultColor);
			_filter3 = _createScanLineFilter(defaultColor);
			_filter3.degree = 90;
			_filter3.scale = 1.0;
			_filter3.strength = 1.0;
			_filterChain = new FilterChain(_filter2, _filter3);

			var filter1Selected:Boolean = true;
			var filter2Selected:Boolean = true;
			var toggleFilters:Function = function():void {
				_quad1.filter = filter1Selected ? _filter1 : null;
				if(filter1Selected && filter2Selected) {
					_quad2.filter = _filterChain;
				} else if(filter1Selected) {
					_quad2.filter = _filter2;
				} else if(filter2Selected) {
					_quad2.filter = _filter3;
				} else {
					_quad2.filter = null;
				}
			}
			toggleFilters();
			var toggleFilter1:Function = function(isSelected:Boolean):void{
				filter1Selected = isSelected;
				toggleFilters();
			}
			var toggleFilter2:Function = function(isSelected:Boolean):void{
				filter2Selected = isSelected;
				toggleFilters();
			}

			_createUiSet(_quad1, new <ScanLineFilter>[_filter1,_filter2], toggleFilter1, 0, defaultColor, 20, 310);
			_createUiSet(_quad2, new <ScanLineFilter>[_filter3], toggleFilter2, 1, defaultColor, 340, 310);

		}

		private function _createUiSet(quad:Quad, filters:Vector.<ScanLineFilter>, onToggle:Function, picIndex:int, defaultColor:uint, xx:int, yy:int):void {

			var dy:int = 20;
			var doRotateAnim:Boolean = false;
			var doScaleAnim:Boolean = false;
			var doOffsetAnim:Boolean = false;

			var r:Number = ((defaultColor & 0xff0000) >> 16) / 255;
			var g:Number = ((defaultColor & 0x00ff00) >> 8) / 255 ;
			var b:Number = ((defaultColor & 0x0000ff)) / 255;

			var getColor:Function = function():uint {
				return ((sliderRed.value*255) << 16) + ((sliderGreen.value*255) << 8) + ((sliderBlue.value*255) << 0);
			};

			var chk:Check;
			var chkSp:Sprite;
			var xx2:int = xx;
			var dxx2:int = 70;

			chk = createDemoCheckBox(function(chk:Check):void{
				onToggle.apply(null, [chk.isSelected]);
			}, true);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Filter")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			chk = createDemoCheckBox(function(chk:Check):void{
				doRotateAnim = !doRotateAnim;
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Rotate")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			chk = createDemoCheckBox(function(chk:Check):void{
				doScaleAnim = !doScaleAnim;
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Scale")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			chk = createDemoCheckBox(function(chk:Check):void{
				doOffsetAnim = !doOffsetAnim;
				for each(var filter:ScanLineFilter in filters) {
					doOffsetAnim ? Starling.juggler.add(filter) : Starling.juggler.remove(filter);
				}
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Offset")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			yy += dy + 10;

			xx2 = xx;

			var radioGroup:ToggleGroup = _createRadio(xx, yy, PIC_NAMES, picIndex, function(index:int):void {
				quad.texture = _textures[index];
			});
			yy += dy;

			var sliderDistance:Slider = _createSlider(xx, yy, filters[0].strength, 0, 5, 1, "STRENGTH", function(value:int):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.strength = value;
				}
			});
			yy += dy;

			var sliderScale:Slider = _createSlider(xx, yy, filters[0].scale, 1, 16, 1, "SCALE   ", function(value:int):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.scale = value;
				}
			});
			yy += dy;

			var sliderDegree:Slider = _createSlider(xx, yy, filters[0].degree, 0, 360, 5, "DIGREE  ", function(value:int):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.degree = value;
				}
			});
			yy += dy;

			var sliderOffset:Slider = _createSlider(xx, yy, filters[0].offset, 0, 100, 1, "OFFSET  ", function(value:int):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.offset = value;
				}
			});
			yy += dy;

			var sliderRed:Slider = _createSlider(xx, yy, r, 0, 1, 0.01, "RED     ", function(value:Number):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.color = getColor();
				}
			});
			yy += dy;

			var sliderGreen:Slider = _createSlider(xx, yy, g, 0, 1, 0.01, "GREEN   ", function(value:Number):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.color = getColor();
				}
			});
			yy += dy;

			var sliderBlue:Slider = _createSlider(xx, yy, b, 0, 1, 0.01, "BLUE    ", function(value:Number):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.color = getColor();
				}
			});
			yy += dy;

			var sliderAlpha:Slider = _createSlider(xx, yy, filters[0].alpha, 0, 1, 0.01, "ALPHA   ", function(value:Number):void{
				for each(var filter:ScanLineFilter in filters) {
					filter.alpha = value;
				}
			});
			yy += dy;

			var theta1:Number = 0;
			var theta2:Number = 0;
			quad.addEventListener(EnterFrameEvent.ENTER_FRAME, function(ev:EnterFrameEvent):void{
				if(doRotateAnim) {
					theta1 = (theta1 + 0.01) % (Math.PI * 2);
					quad.rotation = theta1;
				} else {
					theta1 = 0;
					quad.rotation = 0.0;
				}
				if(doScaleAnim) {
					theta2 = (theta2 + 0.01) % (Math.PI * 2);
					quad.scale = 1.0 + Math.sin(theta2 * 2) * 0.5;
				} else {
					theta2 = 0;
					quad.scale = 1.0;
				}
			});

		}

		private function _createScanLineFilter(color:uint):ScanLineFilter {
			return new ScanLineFilter();
		}

		private function _addImage(xx:int, yy:int, texture:Texture, title:String=""):Quad {
			var quad:Quad = Quad.fromTexture(texture);
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

		private function _createRadio(xx:int, yy:int, titles:Array, selectedIndex:int, onChange:Function):ToggleGroup {

			var partWidth:int = 64;
			var group:ToggleGroup = new ToggleGroup();

			for(var i:int=0; i< titles.length; i++) {

				var radio:Radio = new Radio();
				radio.x = xx;
				radio.y = yy + 2;
				radio.toggleGroup = group;
				addChild(radio);
				radio.scale = 0.5;

				var titleSp:Sprite = _demoHelper.createSpriteText(titles[i], MyFontManager.baseFont.name);
				titleSp.x = xx + 22;
				titleSp.y = yy;
				addChildAt(titleSp, 0);

				xx += partWidth;
			}

			group.addEventListener(Event.CHANGE, function(ev:Event):void {
				onChange.apply(null, [group.selectedIndex]);
			});

			group.selectedIndex = selectedIndex;

			return group;
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
