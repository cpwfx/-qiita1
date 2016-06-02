package harayoki.stage3d.agal.registers {
	public class AGALRegisterConstant implements IAGALConstantRegister, IAGALRegister {

		private var _name:String = "";
		private var _index:uint;

		public function AGALRegisterConstant(name:String, index:uint) {
			_name = name;
			_index = index;
		}

		public function get name():String {
			return _name + _index;
		}
		public function get index():uint {
			return _index;
		}
	}
}
