package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import harayoki.starling.utils.AssetManager;

	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Align;

	public class StarlingMain extends Sprite {

		private static const CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 640, 1024);

		private static var _starling:Starling;
		private static var _startCallback:Function;

		public static function start(nativeStage:Stage, startCallback:Function = null):void {
			trace("Starling version :", Starling.VERSION);

			_startCallback = startCallback;

			_starling = new Starling(
				StarlingMain,
				nativeStage,
				CONTENTS_SIZE
			);
			_starling.skipUnchangedFrames = true;
			_starling.stage.color = 0x111111;
			_starling.start();

		}

		private var _assetManager:AssetManager;

		public function StarlingMain() {

			if (_startCallback) {
				_startCallback.apply(null, [_starling]);
			}

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_assetManager.enqueue('assets/kota.png');
			_assetManager.enqueueWithName('assets/kota.png',"kota2");
			_assetManager.enqueueWithName('assets/kota.png',"kota3");

			_assetManager.setBeforeTextureCreationCallback(onBeforeTextureCreation);

			_assetManager.loadQueue(function(ratio:Number):void {
				if(ratio == 1) {
					_start();
				}
			});

		}

		private function onBeforeTextureCreation(name:String, bmd:BitmapData):Boolean {
			if(name=="kota") {
				return true; // 保持する
			}

			if(name =="kota2") {
				var bFilter:BlurFilter = new BlurFilter(1, 8);
				bmd.applyFilter(bmd, bmd.rect, bmd.rect.topLeft, bFilter);
				return false; // 保持しない
			}

			if(name =="kota3") {
				var mapBmd:BitmapData = new BitmapData(bmd.width, bmd.height,false,0xffffffff);
				mapBmd.perlinNoise(40,10,10,10,true,true);

				var dFilter:DisplacementMapFilter =
					new DisplacementMapFilter(mapBmd, new Point(0,0), 1, 0, 16, 1 );
				bmd.applyFilter(bmd, bmd.rect, bmd.rect.topLeft, dFilter);

				return true; // 保持する
			}

			return false;
		}

		private function _start():void {

			var format:TextFormat = new TextFormat("_sans", 12, 0xffffff);
			format.horizontalAlign = Align.LEFT;

			var bmd1:BitmapData = _assetManager.getBitmapData("kota");
			var bmd2:BitmapData = _assetManager.getBitmapData("kota2");
			var bmd3:BitmapData = _assetManager.getBitmapData("kota3");

			var tf0:TextField = new TextField(500, 60, "", format);
			tf0.text = "BitmapDatas : " + _assetManager.getBitmapDataNames() + "\n" +
				"Textures : " + _assetManager.getTextureNames();
			tf0.x = 60; tf0.y = 20;
			addChild(tf0);

			var tf1:TextField = new TextField(500, 30, "kota  bitmapdata:"+bmd1, format);
			tf1.x = 60; tf1.y = 70;
			addChild(tf1);
			var tf2:TextField = new TextField(500, 30, "kota2 bitmapdata:"+bmd2 + " + BlurFilter", format);
			tf2.x = 60; tf2.y = 370;
			addChild(tf2);
			var tf3:TextField = new TextField(500, 30, "kota3 bitmapdata:"+bmd3 + " + DisplacementMapFilter", format);
			tf3.x = 60; tf3.y = 670;
			addChild(tf3);

			var img1:Quad = Quad.fromTexture(_assetManager.getTexture("kota"));
			img1.x = 60; img1.y = 100;
			addChild(img1);

			var img2:Quad = Quad.fromTexture(_assetManager.getTexture("kota2"));
			img2.x = 60; img2.y = 400;
			addChild(img2);

			var img3:Quad = Quad.fromTexture(_assetManager.getTexture("kota3"));
			img3.x = 60; img3.y = 700;
			addChild(img3);

		}

	}
}