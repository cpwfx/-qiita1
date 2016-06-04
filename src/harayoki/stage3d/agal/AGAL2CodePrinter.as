package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.i.IAGAL2CodePrinter;
	import harayoki.stage3d.agal.i.IAGALDestinationRegister;
	import harayoki.stage3d.agal.i.IAGALRegister;

	public class AGAL2CodePrinter extends AGAL1CodePrinter implements IAGAL2CodePrinter {

		public function AGAL2CodePrinter() {
			// not impremented now
			// 実装中
		}

		public function ddx(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2CodePrinter {
			// TODO
			return this;
		}

	}
}
