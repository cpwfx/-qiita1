package {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.textures.TextureSmoothing;
	import starling.utils.Align;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	public class StarlingMain extends Sprite {

		private static const DEFAULT_FONT_NAME:String = "pxfont12shadow";
		private static const CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320*2, 224*2);

		public static function start(nativeStage:Stage):void {
			trace("Staaling version", Starling.VERSION);

			var starling:Starling = new Starling(
				StarlingMain,
				nativeStage,
				CONTENTS_SIZE
			);
			starling.skipUnchangedFrames = true;
			starling.antiAliasing = 0; // DOTアート対応
			starling.start();
			starling.stage.color = 0x666666;
			nativeStage.addEventListener(Event.RESIZE,_updateViewPort);
			_updateViewPort();
		}

		// 画面の大きさを1,2,3,4..倍に吸着して真ん中寄せ 1倍より小さい場合はそのまま
		private static function _updateViewPort(ev:*=null):void {
			var starling:Starling = Starling.current;
			var w:int = starling.nativeStage.stageWidth;
			var h:int = starling.nativeStage.stageHeight;
			var scale:Number = Math.min(w/CONTENTS_SIZE.width,h/CONTENTS_SIZE.height);
			if(scale > 1.0) scale = Math.floor(scale); //0になるとエラー
			trace([w,h],'scale to', scale);
			starling.viewPort = RectangleUtil.fit(
				CONTENTS_SIZE,
				new Rectangle((w - CONTENTS_SIZE.width*scale)>>1, (h - CONTENTS_SIZE.height*scale)>>1, CONTENTS_SIZE.width*scale,CONTENTS_SIZE.height*scale),
				ScaleMode.SHOW_ALL
			);
			starling.showStats = true;
			starling.showStatsAt(Align.LEFT, Align.TOP);
		}

		private var _assetManager:AssetManager;
		public function StarlingMain() {

			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_assetManager.enqueueWithName('app:/assets/pxfont12shadow.png');
			_assetManager.enqueueWithName('app:/assets/pxfont12shadow.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {
			_locateDobj(_createText("Konoyouni Eiji Font ga\ntadashiku hyouji\ndekimashita!!",DEFAULT_FONT_NAME , 24), 10, 40);
		}

		private function _createText(text:String="", fontName:String=null, size:int=12, color:int=0xffffff):TextField {
			var fmt:TextFormat = new TextFormat(fontName, size, color);
			fmt.horizontalAlign = Align.LEFT;
			fmt.size = size;
			var tf:TextField = new TextField(10, 10, text, fmt);
			tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			tf.pixelSnapping = true; // DOTアート対応
			return tf;
		}

		private function _locateDobj(dobj:DisplayObject, x:int = 0, y: int = 0, scale:Number=1.0, parent:DisplayObjectContainer=null):void {
			parent = parent ? parent : this;
			dobj.x = x;
			dobj.y = y;
			dobj.scale = scale;
			parent.addChild(dobj);
		}


	}
}