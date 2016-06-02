package harayoki.stage3d.agal.registers {
	public class AGALRegisterOutput implements IAGALDestinationRegister {

		private var _name:String = "";

		public function AGALRegisterOutput(name:String) {
			_name = name;
		}

		public function get name():String {
			return _name;
		}
	}
}
