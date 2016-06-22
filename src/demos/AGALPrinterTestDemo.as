package demos {
	import harayoki.stage3d.agal.AGAL1CodePrinterForBaselineExtendedProfile;
	import harayoki.starling2.utils.AssetManager;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.utils.AssetManager;

	public class AGALPrinterTestDemo extends DemoBase {

		public function AGALPrinterTestDemo(assetManager:harayoki.starling2.utils.AssetManager, starling:Starling = null) {
			super(assetManager, starling);
		}

		public override function setBottomUI(out:Vector.<DisplayObject>):Vector.<DisplayObject> {
			return out;
		}

		public override function start():void {

		}

	}
}
