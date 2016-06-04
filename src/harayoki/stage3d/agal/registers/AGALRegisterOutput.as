package harayoki.stage3d.agal.registers {
	import harayoki.stage3d.agal.i.IAGALDestinationRegister;

	public class AGALRegisterOutput implements IAGALDestinationRegister {

		private var _name:String = "";

		public function AGALRegisterOutput(name:String) {
			_name = name;
		}

		public function getCode():String {
			return _name;
		}

		public function clear():void {
		}

	}
}
