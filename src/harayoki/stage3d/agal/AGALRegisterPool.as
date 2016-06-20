package harayoki.stage3d.agal {
	import flash.utils.Dictionary;

	import harayoki.stage3d.agal.i.IAGALRegister;
	import harayoki.stage3d.agal.registers.*;

	internal class AGALRegisterPool{

		private static var _instance:AGALRegisterPool;
		public static function getInstance():AGALRegisterPool {
			if(!_instance) {
				_instance = new AGALRegisterPool();
			}
			return _instance;
		}

		private var _registers:Dictionary;

		public function AGALRegisterPool() {

			_registers = new Dictionary();
			_registers[AGALRegisterVertexConstant] = new <AGALRegisterVertexConstant>[];
			_registers[AGALRegisterVertexTemporary] = new <AGALRegisterVertexTemporary>[];
			_registers[AGALRegisterFragmentConstant] = new <AGALRegisterFragmentConstant>[];
			_registers[AGALRegisterFragmentTemporary] = new <AGALRegisterFragmentTemporary>[];
			_registers[AGALRegisterVertexAttribute] = new <AGALRegisterVertexAttribute>[];
			_registers[AGALRegisterVarying] = new <AGALRegisterVarying>[];
		}

		// レジスタの再利用のため使用済みのレジスタを保持
		public function save(register:IAGALRegister):void {
			register.clear();
			if(register is AGALRegisterVertexConstant) {
				var v1:Vector.<AGALRegisterVertexConstant> = _registers[AGALRegisterVertexConstant];
				v1.push(AGALRegisterVertexConstant(register));
			} else if(register is AGALRegisterFragmentTemporary) {
				var v2:Vector.<AGALRegisterFragmentTemporary> = _registers[AGALRegisterFragmentTemporary];
				v2.push(AGALRegisterFragmentTemporary(register));
			} else if(register is AGALRegisterFragmentConstant) {
				var v3:Vector.<AGALRegisterFragmentConstant> = _registers[AGALRegisterFragmentConstant];
				v3.push(AGALRegisterFragmentConstant(register));
			} else if(register is AGALRegisterVertexTemporary) {
				var v4:Vector.<AGALRegisterVertexTemporary> = _registers[AGALRegisterVertexTemporary];
				v4.push(AGALRegisterVertexTemporary(register));
			} else if(register is AGALRegisterVertexTemporary) {
				var v5:Vector.<AGALRegisterVertexAttribute> = _registers[AGALRegisterVertexAttribute];
				v5.push(AGALRegisterVertexAttribute(register));
			} else if(register is AGALRegisterVarying) {
				var v6:Vector.<AGALRegisterVarying> = _registers[AGALRegisterVarying];
				v6.push(AGALRegisterVarying(register));
			}

		}

		public function getAGALRegisterVertexAttribute(index:int):AGALRegisterVertexAttribute {
			var v:Vector.<AGALRegisterVertexAttribute> = _registers[AGALRegisterVertexAttribute];
			var r:AGALRegisterVertexAttribute =  v.length > 0 ? v.pop() : new AGALRegisterVertexAttribute(index);
			r.index = index;
			return r;
		}

		public function getAGALRegisterVertexConstant(index:int):AGALRegisterVertexConstant {
			var v:Vector.<AGALRegisterVertexConstant> = _registers[AGALRegisterVertexConstant];
			var r:AGALRegisterVertexConstant =  v.length > 0 ? v.pop() : new AGALRegisterVertexConstant(index);
			r.index = index;
			return r;
		}

		public function getAGALRegisterVertexTemporary(index:int):AGALRegisterVertexTemporary {
			var v:Vector.<AGALRegisterVertexTemporary> = _registers[AGALRegisterVertexTemporary];
			var r:AGALRegisterVertexTemporary =  v.length > 0 ? v.pop() : new AGALRegisterVertexTemporary(index);
			r.index = index;
			return r;
		}

		public function getAGALRegisterFragmentTemporary(index:int):AGALRegisterFragmentTemporary {
			var v:Vector.<AGALRegisterFragmentTemporary> = _registers[AGALRegisterFragmentTemporary];
			var r:AGALRegisterFragmentTemporary =  v.length > 0 ? v.pop() : new AGALRegisterFragmentTemporary(index);
			r.index = index;
			return r;
		}

		public function getAGALRegisterFragmentConstant(index:int):AGALRegisterFragmentConstant {
			var v:Vector.<AGALRegisterFragmentConstant> = _registers[AGALRegisterFragmentConstant];
			var r:AGALRegisterFragmentConstant =  v.length > 0 ? v.pop() : new AGALRegisterFragmentConstant(index);
			r.index = index;
			return r;
		}

		public function getAGALRegisterVarying(index:int):AGALRegisterVarying {
			var v:Vector.<AGALRegisterVarying> = _registers[AGALRegisterVarying];
			var r:AGALRegisterVarying =  v.length > 0 ? v.pop() : new AGALRegisterVarying(index);
			r.index = index;
			return r;
		}


	}
}
// 開発用メソッド コードジェネレート
internal function _traceCode():void {

	var i:int;

	for (i;i<8;i++) {
		trace("		public function get v" + i + "():AGALRegisterVarying {");
		trace("			return _getAGALRegisterVarying("+i+");");
		trace("		}\n");
	}

	for (i;i<8;i++) {
		trace("		public function get va" + i + "():AGALRegisterVertexAttribute {");
		trace("			return _getAGALRegisterVertexAttribute("+i+");");
		trace("		}\n");
	}

	for (i;i<8;i++) {
		trace("		public function get vt" + i + "():AGALRegisterVertexTemporary {");
		trace("			return _getAGALRegisterVertexTemporary("+i+");");
		trace("		}\n");
	}

	for (i=0;i<128;i++) {
		trace("		public function get vc" + i + "():AGALRegisterVertexConstant {");
		trace("			return _getAGALRegisterVertexConstant("+i+");");
		trace("		}\n");
	}

	for (i=0;i<8;i++) {
		trace("		public function get ft" + i + "():AGALRegisterFragmentTemporary {");
		trace("			return _getAGALRegisterFragmentTemporary("+i+");");
		trace("		}\n");
	}

	for (i=0;i<28;i++) {
		trace("		public function get fc" + i + "():AGALRegisterFragmentConstant {");
		trace("			return _getAGALRegisterFragmentConstant("+i+");");
		trace("		}\n");
	}

}
