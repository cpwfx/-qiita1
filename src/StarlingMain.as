package {
	import demos.DemoBase;
	import demos.MapChipTestDemo;
	import demos.MeshTestDemo;
	import demos.ScoreTextDemo;
	import demos.TriangleTest1Demo;

	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.system.System;

	import harayoki.stage3d.IContext3DFillModeControl;

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
		private static var _context3DFillModeControl:IContext3DFillModeControl;

		public static function start(nativeStage:Stage, context3DFillModeControl:IContext3DFillModeControl=null):void {
			trace("Starling version :", Starling.VERSION);

			_context3DFillModeControl = context3DFillModeControl;

			var starling:Starling = new Starling(
				StarlingMain,
				nativeStage,
				CONTENTS_SIZE
			);
			starling.skipUnchangedFrames = true;
			starling.stage.color = 0x333333;
			starling.start();

		}

		private var _demo:DemoBase;
		private var _demoHelper:DemoHelper;
		private var _assetManager:AssetManager;

		public function StarlingMain() {

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_demoHelper = new DemoHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_demo = new ScoreTextDemo(_assetManager);
			_demo = new MeshTestDemo(_assetManager);
			_demo = new MapChipTestDemo(_assetManager);
			_demo = new TriangleTest1Demo(_assetManager);

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

			if(_context3DFillModeControl) {
				_context3DFillModeControl.setContext(Starling.current.context);
			}

		}

		private function _start():void {

			MyFontManager.setup();
			_demo.start();

			var buttons:Vector.<DisplayObject> = new <DisplayObject>[];

			var bgTexure:Texture = _assetManager.getTexture("border1");

			if(_context3DFillModeControl) {
				// タッチ時にワイヤーフレームにしてみる
				var wfobj:DisplayObject = _demoHelper.createSpriteText("WIREFRAME", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
				var btn1:DisplayObject = _demoHelper.createButton(wfobj, function():void{
					_context3DFillModeControl.toggleWireFrame();
				}, bgTexure);
				buttons.push(btn1);
			}

			// タッチ時にGCしてみる
			var gcobj:DisplayObject = _demoHelper.createSpriteText("GC", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			var btn2:DisplayObject = _demoHelper.createButton(gcobj, function():void{
				trace("gc!");
				System.gc();
			},bgTexure);
			buttons.push(btn2);

			_demo.getBottomButtons(buttons);
			_demoHelper.loacateBottomLeft(buttons, CONTENTS_SIZE.width, CONTENTS_SIZE.height);

			addChild(_demo); // 最後にaddするとdrawコールを1少なくできることがある

		}

	}
}