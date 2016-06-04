package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.i.IAGAL1CodePrinter;
	import harayoki.stage3d.agal.i.IAGALDestinationRegister;
	import harayoki.stage3d.agal.i.IAGALRegister;
	import harayoki.stage3d.agal.i.IAGALSamplerRegister;

	public class AGAL1CodePrinter extends AGAL1RegisterPool implements IAGAL1CodePrinter {

		private var _codes:Vector.<String>;

		public function AGAL1CodePrinter(baseCode:String="") {
			_codes = new <String>[];
			if(baseCode) {
				prependCodeDirectly(baseCode);
			}
		}

		public function clear():void {
			_codes.length = 0;
		}

		public function print():String {
			return _codes.join("\n");
		}

		public function prependCodeDirectly(code:String):IAGAL1CodePrinter {
			if(code != null && code.length > 0) {
				_codes.unshift(code.split("\n"));
			}
			return this;
		}
		
		public function appendCodeDirectly(code:String):IAGAL1CodePrinter {
			if(code != null && code.length > 0) {
				_codes.push(code.split("\n"));
			}
			return this;
		}

		private function _addCode(
			ope:String, dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister=null, flags:String=null):void {
			var code:String = ope + " "+ dest.getCode() + ", " + src1.getCode();
			_save(dest);
			_save(src1);
			if(src2) {
				code += ", " +src2.getCode();
				_save(src2);
			}
			if(flags) {
				code += flags;
			}
			_codes.push(code);
		}

		////////// agal //////////

		public function move(
				dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL1CodePrinter {
			_addCode("mov", dest, src1);
			return this;
		}

		public function add(
				dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter {
			_addCode("add", dest, src1, src2);
			return this;
		}

		public function subtract(
				dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter {
			_addCode("sub", dest, src1, src2);
			return this;
		}

		public function multiply(
				dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter {
			_addCode("mul", dest, src1, src2);
			return this;
		}

		public function divide(
				dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter {
			_addCode("div", dest, src1, src2);
			return this;
		}

		public function fractional(
			dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL1CodePrinter {
			_addCode("frc", dest, src1);
			return this;
		}

		public function saturate(
			dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL1CodePrinter {
			_addCode("sat", dest, src1);
			return this;
		}

		public function textureSample(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALSamplerRegister, flags:String="<2d, liner>"):IAGAL1CodePrinter {
			if(flags != null && flags.length > 0) {
				flags = " " + flags;
			} else {
				flags = null;
			}
			_addCode("tex", dest, src1, src2, flags);
			return this;
		}

	}
}

