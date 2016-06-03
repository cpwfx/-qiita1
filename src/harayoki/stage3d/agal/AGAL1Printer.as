package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.registers.IAGALDestinationRegister;
	import harayoki.stage3d.agal.registers.IAGALRegister;

	public class AGAL1Printer implements IAGAL1Printer {

		public static function test():void {
			var printer:AGAL1Printer = new AGAL1Printer();
			var r:AGAL1Registers = printer.getRegisters();
			printer.move(
				r.vt1, r.vc1.xx
			).move(
				r.op, r.vt1
			);
		}


		public function AGAL1Printer() {
		}

		public function getRegisters():AGAL1Registers {
			return AGAL1Registers.getInstance();
		}

		public function clear():void {
			// TODO
		}

		public function print():String {

		}

		////////// implements //////////

		public function move(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL1Printer {
			return this;
		}
	}
}
