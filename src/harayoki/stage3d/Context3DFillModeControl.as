package harayoki.stage3d {
	import flash.display3D.Context3D;
	import flash.display3D.Context3DFillMode;

	public class Context3DFillModeControl implements IContext3DFillModeControl {

		private var _context:Context3D
		private var _isWireFrameNow:Boolean = false;

		public function Context3DFillModeControl() {
		}

		public function setContext(context:Context3D):void {
			_context = context;
		}

		public function setWireFrame(flag:Boolean):void {
			if(!_context) {
				return;
			}
			_isWireFrameNow = flag;
			if(_isWireFrameNow) {
				_context.setFillMode(Context3DFillMode.WIREFRAME);
			} else {
				_context.setFillMode(Context3DFillMode.SOLID);
			}
		}

		public function toggleWireFrame():void {
			setWireFrame(!_isWireFrameNow);
		}

		public function isWireFrameNow():Boolean {
			return _isWireFrameNow;
		}

	}
}
