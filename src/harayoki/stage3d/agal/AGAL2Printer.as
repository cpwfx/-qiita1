package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.registers.IAGALDestinationRegister;
	import harayoki.stage3d.agal.registers.IAGALRegister;
	
	public class AGAL2Printer extends AGAL1Printer implements IAGAL2Printer {

		public function AGAL2Printer() {

		}

		public function ddx(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2Printer {
			// TODO 実装
			return this;
		}

	}
}
