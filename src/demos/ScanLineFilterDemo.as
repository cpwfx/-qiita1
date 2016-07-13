package demos {
	import feathers.controls.Check;
	import feathers.controls.Radio;
	import feathers.controls.Slider;
	import feathers.core.ToggleGroup;

	import flash.geom.Rectangle;

	import harayoki.colors.ColorRGBHSV;
	import harayoki.starling2.FixedLayoutBitmapTextController;
	import harayoki.starling2.filters.ScanLineFilter;
	import harayoki.starling2.filters.SlashShadedFilter;
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
		private static const PIC_NAMES:Array = ["PIC1","PIC2","PIC3","PIC4","QUAD1","QUAD2"];

		private var _quad1:Quad;
		private var _quad2:Quad;
		private var _quad3:Quad;
		private var _filter1:ScanLineFilter;
		private var _filter2A:ScanLineFilter;
		private var _filter2B:ScanLineFilter;
		private var _filterChain:FilterChain;
		private var _filter3:SlashShadedFilter;
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
			_textures.push(null);
			_textures.push(null);

			var color:ColorRGBHSV = ColorRGBHSV.fromRGB(0, 0, 0, 128);

			_quad1 = _addImage(56, 20, _textures[0], "Scanline Filter #1");
			_quad2 = _addImage(
				_quad1.x - _quad1.width * 0.5, _quad1.y + _quad1.height * 0.5 + 40,
				_textures[0], "Scanline Filter #1 + #2"
			);
			_quad3 = _addImage(_quad2.x - _quad2.width * 0.5, _quad2.y + _quad2.height * 0.5 + 40,
				_textures[0], "SlashShade Filter\n(45 degree fixed)");

			_filter1  = _createScanLineFilter(color);
			_filter2A = _createScanLineFilter(color);
			_filter2B = _createScanLineFilter(color);
			_filter2B.degree = 60;
			_filter2B.scale = 1.0;
			_filter2B.strength = 4.0;
			_filterChain = new FilterChain(_filter2A, _filter2B);

			var filter1Selected:Boolean = true;
			var filter2ASelected:Boolean = true;
			var filter2BSelected:Boolean = true;
			var toggleFilter1:Function = function(isSelected:Boolean, index:int=0):void{
				filter1Selected = isSelected;
				_quad1.filter = filter1Selected ? _filter1 : null;
			}
			toggleFilter1(filter1Selected);

			var toggleFilter2:Function = function(isSelected:Boolean, index:int=0):void{
				if(index==0) {
					filter2ASelected = isSelected;
				} else {
					filter2BSelected = isSelected;
				}
				toggleFilters();
			}
			var toggleFilters:Function = function():void {
				if(filter2ASelected && filter2BSelected) {
					_quad2.filter = _filterChain;
				} else if(filter2ASelected) {
					_quad2.filter = _filter2A;
				} else if(filter2BSelected) {
					_quad2.filter = _filter2B;
				} else {
					_quad2.filter = null;
				}
			}
			toggleFilters();

			_createUiSet1(_quad1, new <ScanLineFilter>[_filter1,_filter2A], filter1Selected, false, toggleFilter1, 0, color, 330, 16);
			_createUiSet1(_quad2, new <ScanLineFilter>[_filter2B], filter2ASelected, true, toggleFilter2, 1, color, 330, 16 + 280);

			_filter3 = new SlashShadedFilter();
			_quad3.filter = _filter3;
			var filter3Selected:Boolean = true;
			var toggleFilter3:Function = function(isSelected:Boolean):void{
				filter3Selected = isSelected;
				_quad3.filter = filter3Selected ? _filter3 : null;
			}
			_createUiSet2(_quad3, new <SlashShadedFilter>[_filter3], filter3Selected, toggleFilter3, 2, color, 330, 16 + 280 + 280);
			toggleFilter3(filter3Selected);
		}

		private function _createUiSet1(quad:Quad, filters:Vector.<ScanLineFilter>, filterOn:Boolean, doubleFilter:Boolean, onToggle:Function, picIndex:int, color:ColorRGBHSV, xx:int, yy:int):void {

			color = color.clone();

			var dy:int = 20;
			var doRotateAnim:Boolean = false;
			var doScaleAnim:Boolean = false;
			var doOffsetAnim:Boolean = false;

			var chk:Check;
			var chkSp:Sprite;
			var xx2:int = xx;
			var dxx2:int = 90;


			if(doubleFilter) {
				chk = createDemoCheckBox(function(chk:Check):void{
					onToggle.apply(null, [chk.isSelected, 1]);
				}, filterOn);
				chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Filter #2")]);
				addChild(chkSp);
				chkSp.x = xx2;
				chkSp.y = yy;
				xx2 += 90;

			}

			chk = createDemoCheckBox(function(chk:Check):void{
				onToggle.apply(null, [chk.isSelected, 0]);
			}, filterOn);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Filter #1")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;

			xx2 = xx;
			yy += dy;

			chk = createDemoCheckBox(function(chk:Check):void{
				doRotateAnim = !doRotateAnim;
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("RotateTest")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			chk = createDemoCheckBox(function(chk:Check):void{
				doScaleAnim = !doScaleAnim;
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("ScaleTest")]);
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
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("OffsetAnim")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			yy += dy + 10;

			xx2 = xx;

			var radioGroup:ToggleGroup;
			radioGroup = _createRadio(xx, yy, 64, PIC_NAMES, picIndex, function(index:int):void {
				_updateTexture(quad, index);
			});
			yy += dy;
			yy += dy;
			yy += dy*0.5;

			var sliderStrength:Slider = _createSlider(xx, yy, filters[0].strength, -5, 5, 1, "STRENGTH", function(value:int):void{
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

			var sliderRed:Slider = _createSlider(xx, yy, color.r / 255, 0, 1, 0.01, "RED     ", function(value:Number):void{
				color.r = value * 255;
				for each(var filter:ScanLineFilter in filters) {
					filter.color = color.toARGBNumber();
				}
			});
			yy += dy;

			var sliderGreen:Slider = _createSlider(xx, yy, color.g / 255, 0, 1, 0.01, "GREEN   ", function(value:Number):void{
				color.g = value * 255;
				for each(var filter:ScanLineFilter in filters) {
					filter.color = color.toARGBNumber();
				}
			});
			yy += dy;

			var sliderBlue:Slider = _createSlider(xx, yy, color.b / 255, 0, 1, 0.01, "BLUE    ", function(value:Number):void{
				color.b = value * 255;
				for each(var filter:ScanLineFilter in filters) {
					filter.color = color.toARGBNumber();
				}
			});
			yy += dy;

			var sliderAlpha:Slider = _createSlider(xx, yy, color.a / 255, 0, 1, 0.01, "ALPHA   ", function(value:Number):void{
				color.a = value * 255;
				for each(var filter:ScanLineFilter in filters) {
					filter.alpha = color.a / 255;
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
					quad.scale = 1.0 + Math.sin(theta2 * 2) * 0.25;
				} else {
					theta2 = 0;
					quad.scale = 1.0;
				}
			});

		}

		private function _createUiSet2(quad:Quad, filters:Vector.<SlashShadedFilter>, filterOn:Boolean, onToggle:Function, picIndex:int, color:ColorRGBHSV, xx:int, yy:int):void {
			color = color.clone();

			var dy:int = 20;
			var doRotateAnim:Boolean = false;
			var doScaleAnim:Boolean = false;
			var doOffsetAnim:Boolean = false;

			var chk:Check;
			var chkSp:Sprite;
			var xx2:int = xx;
			var dxx2:int = 90;

			chk = createDemoCheckBox(function(chk:Check):void{
				onToggle.apply(null, [chk.isSelected]);
			}, filterOn);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("Filter #3")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;

			yy += dy;

			chk = createDemoCheckBox(function(chk:Check):void{
				doRotateAnim = !doRotateAnim;
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("RotateTest")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			chk = createDemoCheckBox(function(chk:Check):void{
				doScaleAnim = !doScaleAnim;
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("ScaleTest")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			chk = createDemoCheckBox(function(chk:Check):void{
				doOffsetAnim = !doOffsetAnim;
				for each(var filter:SlashShadedFilter in filters) {
					doOffsetAnim ? Starling.juggler.add(filter) : Starling.juggler.remove(filter);
				}
			}, false);
			chkSp = createDemoWrapSprite(new <DisplayObject>[chk, createDemoText("OffsetAnim")]);
			addChild(chkSp);
			chkSp.x = xx2;
			chkSp.y = yy;
			xx2 += dxx2;

			yy += dy + 10;

			xx2 = xx;

			var radioGroup:ToggleGroup;
			radioGroup = _createRadio(xx, yy, 64, PIC_NAMES, picIndex, function(index:int):void {
				_updateTexture(quad, index);
			});
			yy += dy;
			yy += dy;
			yy += dy*0.5;

			radioGroup = _createRadio(xx, yy, 64, ["SLASH", "BACK SLASH"], SlashShadedFilter.TYPE_SLASH, function(index:int):void {
				for each(var filter:SlashShadedFilter in filters) {
					if(index == SlashShadedFilter.TYPE_SLASH) {
						filter.type = SlashShadedFilter.TYPE_SLASH;
					} else {
						filter.type = SlashShadedFilter.TYPE_BACK_SLASH;
					}
				}
			});
			yy += dy;

			var sliderStrength:Slider = _createSlider(xx, yy, filters[0].distance, 0, 16, 1, "DISTANCE", function(value:int):void{
				for each(var filter:SlashShadedFilter in filters) {
					filter.distance = value;
				}
			});
			yy += dy;

			var sliderOffset:Slider = _createSlider(xx, yy, filters[0].offset, 0, 100, 1, "OFFSET  ", function(value:int):void{
				for each(var filter:SlashShadedFilter in filters) {
					filter.offset = value;
				}
			});
			yy += dy;

			var sliderRed:Slider = _createSlider(xx, yy, color.r / 255, 0, 1, 0.01, "RED     ", function(value:Number):void{
				color.r = value * 255;
				for each(var filter:SlashShadedFilter in filters) {
					filter.color = color.toARGBNumber();
				}
			});
			yy += dy;

			var sliderGreen:Slider = _createSlider(xx, yy, color.g / 255, 0, 1, 0.01, "GREEN   ", function(value:Number):void{
				color.g = value * 255;
				for each(var filter:SlashShadedFilter in filters) {
					filter.color = color.toARGBNumber();
				}
			});
			yy += dy;

			var sliderBlue:Slider = _createSlider(xx, yy, color.b / 255, 0, 1, 0.01, "BLUE    ", function(value:Number):void{
				color.b = value * 255;
				for each(var filter:SlashShadedFilter in filters) {
					filter.color = color.toARGBNumber();
				}
			});
			yy += dy;

			var sliderAlpha:Slider = _createSlider(xx, yy, color.a / 255, 0, 1, 0.01, "ALPHA   ", function(value:Number):void{
				color.a = value * 255;
				for each(var filter:SlashShadedFilter in filters) {
					filter.alpha = color.a / 255;
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
					quad.scale = 1.0 + Math.sin(theta2 * 2) * 0.25;
				} else {
					theta2 = 0;
					quad.scale = 1.0;
				}
			});

		}

		private function _createScanLineFilter(color:ColorRGBHSV):ScanLineFilter {
			return new ScanLineFilter(2.0, 0.0, 1, color.toARGBNumber(), color.a / 255);
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

		private function _createRadio(xx:int, yy:int, partWidth:int, titles:Array, selectedIndex:int, onChange:Function):ToggleGroup {

			var group:ToggleGroup = new ToggleGroup();

			var orgX:int = xx;
			var orgY:int = yy;

			for(var i:int=0; i< titles.length; i++) {

				if((i % 4) == 0 && i!=0) {
					xx = orgX;
					yy += 20;
				}

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

		private function _createSlider(xx:int, yy:int, value:Number, min:Number, max:Number, step:Number, title:String, onChange:Function):Slider {

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

		private function _updateTexture(quad:Quad, index:int) {
			quad.color = 0xffffff;
			quad.setVertexColor(0, 0xffffff);
			quad.setVertexColor(1, 0xffffff);
			quad.setVertexColor(2, 0xffffff);
			quad.setVertexColor(3, 0xffffff);
			var texture:Texture = _textures[index];
			quad.texture = texture;
			if(texture) {
				return;
			}
			if((index % 2) == 0) {
				quad.setVertexColor(0, 0xffffff);
				quad.setVertexColor(1, 0xff0000);
				quad.setVertexColor(2, 0x00ff00);
				quad.setVertexColor(3, 0x0000ff);
			} else {
				quad.color = ColorRGBHSV.fromRGB(
					255*Math.random(),255*Math.random(),255*Math.random(),128 + 127*Math.random()).toRGBNumber();
			}
		}
	}
}
