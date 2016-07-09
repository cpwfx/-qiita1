package {
	import demos.AGALPrinterTestDemo;
	import demos.DemoBase;
	import demos.MapChipTestDemo;
	import demos.MeshTestDemo;
	import demos.PosterizationFilterDemo;
	import demos.PosterizationStyleDemo;
	import demos.ColorPaletteTestDemo;
	import demos.ScanLineFilterDemo;
	import demos.ScoreTextDemo;
	import demos.TriangleTest1Demo;
	import demos.TriangleTest3Demo;

	import feathers.controls.Check;

	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display3D.Context3DProfile;
	import flash.geom.Rectangle;
	import flash.geom.Rectangle;

	import harayoki.feathers.themes.CustomMetalWorksTheme;
	import harayoki.starling2.utils.AssetManager;

	import misc.DemoHelper;
	import misc.MyFontManager;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.TextureAtlas;

	public class StarlingMain extends Sprite {

		private static const DEFAULT_CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320, 240 * 2);

		private static var _starling:Starling;
		private static var _startCallback:Function;

		private static var DemoClass:Class;
		private static var contentSize:Rectangle;

		public static function start(nativeStage:Stage, startCallback:Function = null):void {
			trace("Starling version :", Starling.VERSION);

			DemoClass = ScoreTextDemo;
			DemoClass = MeshTestDemo;
			DemoClass = MapChipTestDemo;
			DemoClass = TriangleTest1Demo;
			DemoClass = TriangleTest3Demo;
			DemoClass = ColorPaletteTestDemo;
			DemoClass = AGALPrinterTestDemo;
			DemoClass = PosterizationFilterDemo;
			DemoClass = PosterizationStyleDemo;
			DemoClass = ScanLineFilterDemo;

			contentSize = (DemoClass.CONTENTS_SIZE as Rectangle) || DEFAULT_CONTENTS_SIZE;

			_startCallback = startCallback;

			_starling = new Starling(
				StarlingMain,
				nativeStage,
				contentSize,
				null,
				"auto",
				Context3DProfile.STANDARD_CONSTRAINED // for 2016 smart phone
			);
			_starling.enableErrorChecking = false;
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

			trace("Stage3D profile:", _starling.profile);


			_demoHelper = new DemoHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_demo = new DemoClass(_assetManager);

			ViewportUtil.setupViewPort(Starling.current, contentSize || DEFAULT_CONTENTS_SIZE, true);

			MyFontManager.setupAsset(_assetManager);

			// 順序を確実に保たないと入れ子アトラスが解決できない模様 (atlas.png内に別のatlasがある)
			_assetManager.enqueue('assets/atlas.png');
			_assetManager.enqueue('assets/atlas.xml');

			_assetManager.setBeforeTextureCreationCallback(function(name:String,bmd:BitmapData):BitmapData{
				if(name=="atlas") {
					_assetManager.addBitmapData(name, bmd);
				}
				return null;
			});
			_assetManager.addEventListener(Event.TEXTURES_RESTORED, function(ev:Event):void {
				trace("TEXTURES_RESTORED");
			});

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
				var file:Object = assetsCandidates[i];
				if(file is String) {
					if(assetsAdded.indexOf(file) == -1) {
						assetsAdded.push(file);
						_assetManager.enqueue(file);
					}
				} else {
					for(var key:String in file) {
						_assetManager.enqueueWithName(file[key], key);
					}
				}
			}

			_assetManager.setBeforeTextureCreationCallback(_demo.beforeTextureCreationCallback);

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
				bg.width = contentSize.width;
				bg.height = contentSize.height;
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
				_demoHelper.loacateBottomLeft(uiList, contentSize.width, contentSize.height);
			}

			if(_demo.frontDisplay) {
				addChild(_demo); // 最後にaddするとdrawコールを1少なくできることがある
			}

		}

	}
}