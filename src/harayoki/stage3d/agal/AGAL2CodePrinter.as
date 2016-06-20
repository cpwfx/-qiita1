package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.i.IAGAL2CodePrinter;
	import harayoki.stage3d.agal.i.IAGALDestinationRegister;
	import harayoki.stage3d.agal.i.IAGALRegister;

	public class AGAL2CodePrinter extends AGAL1CodePrinter implements IAGAL2CodePrinter {

		public function AGAL2CodePrinter() {
			// not impremented now
			// 実装中
		}

		public function partialDerivativeInX(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2CodePrinter {
			// TODO 実装 ddx
			return this;
		}

		public function partialDerivativeInY(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2CodePrinter {
			// TODO 実装 ddy
			return this;
		}

		public function ifEqualTo(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter {
			// TODO 実装 ife
			return this;
		}

		public function ifNotEqualTo(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter {
			// TODO 実装 ine
			return this;
		}

		public function ifGreaterThan(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter {
			// TODO 実装 ifg
			return this;
		}

		public function ifLessThan(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter {
			// TODO 実装 ifl
			return this;
		}

		public function els(destination:IAGALDestinationRegister):IAGAL2CodePrinter {
			// TODO 実装 els
			return this;
		}

		public function endIf(destination:IAGALDestinationRegister):IAGAL2CodePrinter {
			// TODO 実装 eif
			return this;
		}
	}
}
