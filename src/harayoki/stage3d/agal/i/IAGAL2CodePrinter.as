package harayoki.stage3d.agal.i {
	public interface IAGAL2CodePrinter extends IAGAL1CodePrinter{

		/**
		 * [ddx] 0x1a
		 * partial derivative in X
		 * Load partial derivative in X of source1 into destination.
		 */
		function partialDerivativeInX(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2CodePrinter;

		/**
		 * [ddy] 0x1b
		 * Load partial derivative in Y of source1 into destination.
		 */
		function partialDerivativeInY(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2CodePrinter;

		/**
		 * [ife] 0x1c
		 * Jump if source1 is equal to source2.
		 */
		function ifEqualTo(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter;

		/**
		 * [ine] 0x1d
		 * Jump if source1 is not equal to source2.
		 */
		function ifNotEqualTo(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter;

		/**
		 * [ifg] 0x1e
		 * Jump if source1 is greater than or equal to source2.
		 */
		function ifGreaterThan(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter;

		/**
		 * [ifl] 0x1f
		 * if less than
		 * Jump if source1 is less than source2.
		 */
		function ifLessThan(destination:IAGALDestinationRegister, source1:IAGALRegister, source2:IAGALRegister):IAGAL2CodePrinter;

		/**
		 * [els] 0x20
		 * Else block
		 */
		function els(destination:IAGALDestinationRegister):IAGAL2CodePrinter; // elseは予約語なのでels

		/**
		 * [eif] 0x21
		 * Close if or else block.
		 */
		function endIf(destination:IAGALDestinationRegister):IAGAL2CodePrinter;
	}
}

