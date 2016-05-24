package {

	import flash.desktop.NativeApplication;
	import flash.display.BitmapData;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.system.System;
	import flash.utils.ByteArray;

	import harayoki.stage3d.Context3DFillModeControl;

	import starling.core.Starling;

	public class AirMain extends Sprite {
        public function AirMain() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			stage.quality = StageQuality.LOW;
			stage.color = 0x000000;
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}

		private function _init(ev:Event=null):void {
			StarlingMain.start(stage, _handleStartStarling);
		}

		private function _handleStartStarling(starling:Starling):void {

			trace("_handleStartStarling");

			var fillModeControl:Context3DFillModeControl =  new Context3DFillModeControl();
			fillModeControl.setContext(starling.context);

			if(NativeWindow.isSupported) {
				var root:NativeMenu = new NativeMenu();
				NativeApplication.nativeApplication.menu = root;
				var subMenu1:NativeMenu = new NativeMenu();
				root.addSubmenu(subMenu1, "menu");
				var item:NativeMenuItem;

				item = new NativeMenuItem("Execute GC");
				item.addEventListener(Event.SELECT, function(ev:Event):void{
					System.gc();
				});
				subMenu1.addItem(item);

				item = new NativeMenuItem("Toggle FillMode");
				item.addEventListener(Event.SELECT, function(ev:Event):void{
					fillModeControl.toggleWireFrame();
				});
				subMenu1.addItem(item);

				var bmd:BitmapData;
				item = new NativeMenuItem("Capture Screen");
				item.addEventListener(Event.SELECT, function(ev:Event):void{
					var viewPort:Rectangle = starling.viewPort;
					bmd = new BitmapData(viewPort.width, viewPort.height, false, stage.color);
					starling.stage.drawToBitmapData(bmd);
					_saveImage(bmd);
				});
				subMenu1.addItem(item);
			}
		}

		private function _saveImage(bmd:BitmapData):void
		{
			var date:Date = new Date();
			var filename:String = [
				"DemoCapture", date.fullYear, date.month + 1, date.date, date.hours, date.minutes, date.seconds
			].join("_") + ".png";
			var bytes:ByteArray = new ByteArray();
			var options:PNGEncoderOptions = new PNGEncoderOptions();
			bmd.encode(bmd.rect, options, bytes);
			var fr:FileReference = new FileReference();
			fr.save(bytes, filename);
		}

	}
}

