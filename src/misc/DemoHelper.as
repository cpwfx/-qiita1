package misc {

	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObject;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.text.TextOptions;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;

	public class DemoHelper {

		private var _forDotArt:Boolean; // DOTアート対応フラグ
		private var _baseDisplayObject:DisplayObjectContainer;
		public function DemoHelper(starling:Starling, baseDisplayObject:DisplayObjectContainer, forDotArt:Boolean=false) {
			_baseDisplayObject = baseDisplayObject;
			_forDotArt = forDotArt;
			if(_forDotArt) {
				starling.antiAliasing = 0; // デフォルト値は0だが念のため
			}
		}

		public function createText(text:String="", fontName:String=null, size:Number=0, color:int=0xffffff, border:Boolean=false):TextField {
			var fnt:BitmapFont = TextField.getBitmapFont(fontName);
			if(!fnt) {
				trace('No bitmap font for', fontName);
			}
			var fmt:TextFormat = new TextFormat(fontName, size, color);
			fmt.horizontalAlign = Align.LEFT;
			fmt.size = isNaN(size) || size <= 0 ? fnt.size : size;
			var tf:TextField = new TextField(10, 10, text, fmt);
			tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			tf.pixelSnapping = _forDotArt;
			tf.border = border;
			return tf;
		}

		public function createSpriteTextWithTextFormat(
			fmt:TextFormat,
			text:String="",
			width:int = 100,
			height:int=100,
			opt:TextOptions=null
		):Sprite {
			return _createSpriteText(text, "", width, height, 0, 0, fmt, opt);
		}

		public function createSpriteText(
			text:String="",
			fontName:String=null,
			width:int = 100,
			height:int=100,
			size:Number=0,
			color:int=0xffffff,
			opt:TextOptions=null
		):Sprite {
			return _createSpriteText(text, fontName, width, height, size, color, null, opt);
		}

		public function _createSpriteText(
			text:String="",
			fontName:String=null,
			width:int = 100,
			height:int=100,
			size:Number=0,
			color:int=0xffffff,
			fmt:TextFormat=null,
			opt:TextOptions=null
		):Sprite {
			var fnt:BitmapFont = TextField.getBitmapFont(fontName);
			if(!fnt) {
				trace('No bitmap font for', fontName);
				return new Sprite();
			}
			size = isNaN(size) || size <= 0 ? fnt.size : size;
			if(!fmt) {
				fmt  = new TextFormat(fontName, size, color);
				fmt.horizontalAlign = Align.LEFT;
				fmt.verticalAlign = Align.TOP;
			}
			if(!opt) {
				opt = new TextOptions(true, false);
			}
			var sp:Sprite = fnt.createSprite(width, height, text, fmt, opt);
			if(sp.numChildren == 0) {
				trace('No letters in sprite, may be textbox is too small or no bitmap chars.\narguments :\n', arguments);
			}
			if(_forDotArt) {
				var i:int = sp.numChildren;
				while(i--) {
					var image:Image = sp.getChildAt(i) as Image
					if(image) {
						image.textureSmoothing =TextureSmoothing.NONE;
					}
				}
			}
			return sp;
		}

		public function locateDobj(dobj:DisplayObject, x:int = 0, y: int = 0, scale:Number=1.0, rotation:Number=0, parent:DisplayObjectContainer=null):DisplayObject {
			parent = parent ? parent : _baseDisplayObject;
			dobj.x = _forDotArt ? ~~x : x;
			dobj.y = _forDotArt ? ~~y : y;
			dobj.scale = scale;
			dobj.rotation = rotation;
			parent.addChild(dobj);
			return dobj;
		}

		public function createButton(
			contents:DisplayObject, handler:Function,
			x:Number=NaN, y:Number=NaN, bgTexture:Texture=null,
			textureSmoothing:String=null
		):Sprite {
			var sp:Sprite = new Sprite();
			sp.touchGroup = true;
			sp.touchable = true;
			sp.addChild(contents);
			sp.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent):void{
				if(ev.getTouch(sp, TouchPhase.ENDED)) {
					sp.alpha = 0.5;
					_delay(50, function():void{
						sp.alpha = 1.0;
					});
					handler && handler();
				}
			});
			if(!isNaN(x)) {
				sp.x = x;
			}
			if(!isNaN(y)) {
				sp.y = y;
			}
			_baseDisplayObject.addChild(sp);
			if(bgTexture) {
				var bg:Image = new Image(bgTexture);
				contents.getBounds(sp, _workRect);
				_workRect.inflate(8,8);
				bg.textureSmoothing = textureSmoothing ? textureSmoothing : TextureSmoothing.NONE;
				bg.scale9Grid = new flash.geom.Rectangle(bg.width/2,bg.height/2,1,1);
				bg.touchable = true;
				bg.x = _workRect.x;
				bg.y = _workRect.y;
				bg.width = _workRect.width;
				bg.height = _workRect.height;
				sp.addChildAt(bg, 0);
			}
			return sp;
		}

		private function _delay(wait:int, func:Function, args:Array=null):void {
			setTimeout(function():void{
				func.apply(null,args ? args : []);
			}, wait);
		}

		private var _workRect:Rectangle = new flash.geom.Rectangle();
		public function fitToBound(target:DisplayObject, boundObj:DisplayObject, texture:Texture=null):void {
			var targetSpace:DisplayObjectContainer = boundObj.parent;
			if(targetSpace) {
				target.getBounds(targetSpace, _workRect);
				boundObj.x = _workRect.x;
				boundObj.y = _workRect.y;
				boundObj.width = _workRect.width;
				boundObj.height = _workRect.height;
			};
		}

	}
}
