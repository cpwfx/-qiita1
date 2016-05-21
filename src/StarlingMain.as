package {
	import demos.DemoBase;
	import demos.MapChipTestDemo;
	import demos.MeshTestDemo;
	import demos.ScoreTextDemo;
	import demos.TriangleTest1Demo;

	import flash.display.Stage;
	import flash.display3D.Context3DFillMode;
	import flash.geom.Rectangle;
	import flash.system.System;

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

		public static function start(nativeStage:Stage):void {
			trace("Starling version :", Starling.VERSION);

			var starling:Starling = new Starling(
				StarlingMain,
				nativeStage,
				CONTENTS_SIZE
			);
			starling.skipUnchangedFrames = true;
			starling.start();
			starling.stage.color = 0x333333;
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
			addChild(_demo);

			MyFontManager.setupAsset(_assetManager);
			var assetsCandidates:Array = [];
			_demo.addAssets(assetsCandidates);
			assetsCandidates.push('assets/atlas.png');
			assetsCandidates.push('assets/atlas.xml');
			assetsCandidates.push('assets/colorbars.xml');

			var assets:Array = [];
			//重複を省く
			for each(var file:String in assetsCandidates) {
				if(assets.indexOf(file) == -1) {
					assets.push(file);
				}
			}

			_assetManager.enqueue(assets);
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			MyFontManager.setup();
			_demo.start();

			var bgTexure:Texture = _assetManager.getTexture("border1");

			// タッチ時にGCしてみる
			var gcobj:DisplayObject = _demoHelper.createSpriteText("GC", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			var btn2:DisplayObject = _demoHelper.createButton(gcobj, function():void{
				trace("gc!");
				System.gc();
			},bgTexure);

			// タッチ時にワイヤーフレームにしてみる
			var isWireframe:Boolean = false;
			var wfobj:DisplayObject = _demoHelper.createSpriteText("WIREFRAME", MyFontManager.baseFont.name, 200, 20, 0, 0xffffff);
			var btn1:DisplayObject = _demoHelper.createButton(wfobj, function():void{
				isWireframe = !isWireframe;
				if (isWireframe) {
					Starling.current.context.setFillMode(Context3DFillMode.WIREFRAME);
				} else {
					Starling.current.context.setFillMode(Context3DFillMode.SOLID);
				}
			}, bgTexure);

			var buttons:Vector.<DisplayObject> = new <DisplayObject>[
				btn1,
				btn2
			];
			_demo.getBottomButtons(buttons);

			_demoHelper.loacateBottomLeft(buttons, CONTENTS_SIZE.width, CONTENTS_SIZE.height);

		}

	}
}