package harayoki.stage3d.agal.i {
	public interface IAGAL2CodePrinter extends IAGAL1CodePrinter{

		/**
		 * [ddx] 0x1a
		 * partial derivative in X
		 * Load partial derivative in X of source1 into destination.
		 */
		function ddx(destination:IAGALDestinationRegister, source1:IAGALRegister):IAGAL2CodePrinter;
	}
}

/*

 ddy

 0x1b

 partial derivative in Y

 Load partial derivative in Y of source1 into destination.

 ife

 0x1c

 if equal to

 Jump if source1 is equal to source2.

 ine

 0x1d

 if not equal to

 Jump if source1 is not equal to source2.

 ifg

 0x1e

 if greater than

 Jump if source1 is greater than or equal to source2.

 ifl

 0x1f

 if less than

 Jump if source1 is less than source2.

 els

 0x20

 else

 Else block

 eif

 0x21

 Endif

 Close if or else block.
 */