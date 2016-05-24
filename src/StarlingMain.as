package {
	import demos.DemoBase;
	import demos.MapChipTestDemo;
	import demos.MeshTestDemo;
	import demos.ScoreTextDemo;
	import demos.TriangleTest1Demo;
	import demos.TriangleTest3Demo;

	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.FixedLayoutBitmapTextController;

	import misc.DemoHelper;
	import misc.MyFontManager;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320, 240 * 2);

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
			_starling.stage.color = 0x000000;
			_starling.start();

		}

		private var _demo:DemoBase;
		private var _demoHelper:DemoHelper;
		private var _assetManager:AssetManager;

		public function StarlingMain() {

			if(_startCallback) {
				_startCallback.apply(null, [_starling]);
			}

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_demoHelper = new DemoHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_demo = new ScoreTextDemo(_assetManager);
			_demo = new MeshTestDemo(_assetManager);
			_demo = new MapChipTestDemo(_assetManager);
			_demo = new TriangleTest1Demo(_assetManager);
			_demo = new TriangleTest3Demo(_assetManager);

			MyFontManager.setupAsset(_assetManager);
			var assetsCandidates:Array = [];
			_demo.addAssets(assetsCandidates);
			assetsCandidates.push('assets/colorbars.xml');
			assetsCandidates.push('assets/atlas.png');
			assetsCandidates.push('assets/atlas.xml');

			var assetsAdded:Array = [];
			//重複を省く 順序を保たないと入れ子アトラスが解決できない模様 (atlas.png内にcolorbarsがある)
			for(var i:int=0; i < assetsCandidates.length; i++) {
				var file:String = assetsCandidates[i];
				if(assetsAdded.indexOf(file) == -1) {
					assetsAdded.push(file);
					_assetManager.enqueue(file);
				}
			}

			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});

			//if(_context3DFillModeControl) {
			//	_context3DFillModeControl.setContext(Starling.current.context);
			//}

		}

		private function _start():void {

			MyFontManager.setup();

			var bg:DisplayObject = _demo.getBackgroundDisplay();
			if (bg) {
				bg.width = CONTENTS_SIZE.width;
				bg.height = CONTENTS_SIZE.height;
				addChild(bg);
			}

			addChild(_demo)
			_demo.start();

			var buttons:Vector.<DisplayObject> = new <DisplayObject>[];

			var bgTexture:Texture = _assetManager.getTexture("border1");

			// タッチ時にskipUnchangedFrames切り替え
			var infoTextControl1:FixedLayoutBitmapTextController;
			infoTextControl1 = new FixedLayoutBitmapTextController(MyFontManager.baseFont.name, "SkpUnchngdFrms:XXX");
			infoTextControl1.setText("SkpUnchngdFrms:YES");
			var btn:DisplayObject = _demoHelper.createButton(infoTextControl1.displayObject, function():void {
				_starling.skipUnchangedFrames = !_starling.skipUnchangedFrames;
				if(_starling.skipUnchangedFrames) {
					infoTextControl1.setText("SkpUnchngdFrms:YES");
				} else {
					infoTextControl1.setText("SkpUnchngdFrms: NO");
				}
			}, bgTexture);
			buttons.push(btn);

			// 各デモでボタンを追加 nullが入っていると改行になる
			_demo.getBottomButtons(buttons);

			if(buttons.length > 0) {
				_demoHelper.loacateBottomLeft(buttons, CONTENTS_SIZE.width, CONTENTS_SIZE.height);
			}

			if(_demo.frontDisplay) {
				addChild(_demo); // 最後にaddするとdrawコールを1少なくできることがある
			}

		}

	}
}