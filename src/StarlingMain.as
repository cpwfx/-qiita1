package {
	import demos.AGALPrinterTestDemo;
	import demos.DemoBase;
	import demos.MapChipTestDemo;
	import demos.MeshTestDemo;
	import demos.MyFirstFilterDemo;
	import demos.MyFirstStyleDemo;
	import demos.ScoreTextDemo;
	import demos.TriangleTest1Demo;
	import demos.TriangleTest3Demo;

	import feathers.controls.Check;

	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.feathers.themes.CustomMetalWorksTheme;
	import harayoki.starling.utils.AssetManager;

	import misc.DemoHelper;
	import misc.MyFontManager;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

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
			_starling.stage.blendMode = BlendMode.AUTO; // NONE?
			_starling.start();

		}

		private var _demo:DemoBase;
		private var _demoHelper:DemoHelper;
		private var _assetManager:AssetManager;

		public function StarlingMain() {

			if (_startCallback) {
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
			_demo = new MyFirstStyleDemo(_assetManager);
			_demo = new AGALPrinterTestDemo(_assetManager);
			_demo = new MyFirstFilterDemo(_assetManager);

			MyFontManager.setupAsset(_assetManager);

			// 順序を確実に保たないと入れ子アトラスが解決できない模様 (atlas.png内に別のatlasがある)
			_assetManager.enqueue('assets/atlas.png');
			_assetManager.enqueue('assets/atlas.xml');

			// load main assets
			_assetManager.loadQueue(function(ratio:Number):void {
				if(ratio == 1) {
					_loadSubAssets();
				}
			});

		}
		private function _loadSubAssets():void {

			var assetsCandidates:Array = [];
			_demo.addAssets(assetsCandidates);
			assetsCandidates.push("assets/metalworks_desktop_custom.xml");
			assetsCandidates.push('assets/colorbars.xml');

			var assetsAdded:Array = [];
			//重複を省く
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

			var themeAtlas:TextureAtlas = _assetManager.getTextureAtlas("metalworks_desktop_custom");
			var theme:CustomMetalWorksTheme = new CustomMetalWorksTheme(themeAtlas, MyFontManager.baseFont.name);
			theme.dummyTexture = _assetManager.getTexture("white");

			var bg:DisplayObject = _demo.getBackgroundDisplay();
			if (bg) {
				bg.width = CONTENTS_SIZE.width;
				bg.height = CONTENTS_SIZE.height;
				addChild(bg);
			}

			addChild(_demo)
			_demo.start();

			var uiList:Vector.<DisplayObject> = new <DisplayObject>[];

			var chk:Check = _demo.createDemoCheckBox(function(chk:Check):void{
				if(chk.isSelected) {
					_starling.skipUnchangedFrames = true;
				} else {
					_starling.skipUnchangedFrames = false;
				}
			}, true);
			uiList.push(_demo.createDemoWrapSprite(new <DisplayObject>[chk, _demo.createDemoText("SkpUnchngdFrms")]));

			// 各デモでボタンを追加 nullが入っていると改行になる
			_demo.setBottomUI(uiList);

			if(uiList.length > 0) {
				_demoHelper.loacateBottomLeft(uiList, CONTENTS_SIZE.width, CONTENTS_SIZE.height);
			}

			if(_demo.frontDisplay) {
				addChild(_demo); // 最後にaddするとdrawコールを1少なくできることがある
			}

		}

	}
}