package {

import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import harayoki.stage3d.Context3DFillModeControl;

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
			StarlingMain.start(stage, new Context3DFillModeControl());
		}
	}
}

