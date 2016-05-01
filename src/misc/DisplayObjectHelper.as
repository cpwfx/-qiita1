package misc {

	import flash.text.TextFormatAlign;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.text.TextOptions;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;

	public class DisplayObjectHelper {

		private var _forDotArt:Boolean; // DOTアート対応フラグ
		private var _baseDisplayObject:DisplayObjectContainer;
		public function DisplayObjectHelper(starling:Starling, baseDisplayObject:DisplayObjectContainer, forDotArt:Boolean=false) {
			_baseDisplayObject = baseDisplayObject;
			_forDotArt = forDotArt;
			if(_forDotArt) {
				starling.antiAliasing = 0; // デフォルト値は0だが念のため
			}
		}

		public function createText(text:String="", fontName:String=null, size:int=12, color:int=0xffffff):TextField {
			var fmt:TextFormat = new TextFormat(fontName, size, color);
			fmt.horizontalAlign = Align.LEFT;
			fmt.size = size;
			var tf:TextField = new TextField(10, 10, text, fmt);
			tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			tf.pixelSnapping = _forDotArt;
			return tf;
		}

		public function createSpriteText(text:String="", fontName:String=null, size:int=12, width:int = 100, height:int=12, color:int=0xffffff):Sprite {

			var fmt:TextFormat = new TextFormat(fontName, size, color);
			fmt.horizontalAlign = TextFormatAlign.LEFT;
			var opt:TextOptions = new TextOptions(true, false);
			var sp:Sprite = TextField.getBitmapFont(fontName).createSprite(width, height, text, fmt, opt);
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

		public function locateDobj(dobj:DisplayObject, x:int = 0, y: int = 0, scale:Number=1.0, rotation:Number=0, parent:DisplayObjectContainer=null):void {
			parent = parent ? parent : _baseDisplayObject;
			dobj.x = _forDotArt ? ~~x : x;
			dobj.y = _forDotArt ? ~~y : y;
			dobj.scale = scale;
			dobj.rotation = rotation;
			parent.addChild(dobj);
		}

	}
}
