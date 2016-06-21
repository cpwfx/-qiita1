package harayoki.stage3d.agal.i {
	public interface IAGAL2CodePrinter {
		
		
		// @see http://jacksondunstan.com/articles/1664
		
		/**
		 * [mov] 0x00
		 * move data from source1 to destination, component-wise
		 */
		function move(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter
		
		/**
		 * [add] 0x01
		 * destination = source1 + source2, component-wise
		 */
		function add(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [sub] 0x02
		 *  destination = source1 - source2, component-wise
		 */
		function subtract(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 *  [mul] 0x03
		 *  destination = source1 * source2, component-wise
		 */
		function multiply(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [div] 0x04
		 * destination = source1 / source2, component-wise
		 */
		function divide(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		
		/**
		 * [frc] 0x08
		 * destination = source1 - (float)floor(source1), component-wise
		 */
		function fractional(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [sat] 0x16
		 * destination = maximum(minimum(source1,1),0), component-wise
		 */
		function saturate(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		
		/**
		 * [tex] 0x28 (fragment shader only)
		 * destination equals load from texture source2 at coordinates source1.
		 * In this case, source2 must be in sampler format.
		 */
		function textureSample(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALSamplerRegister, flags:String="<2d, liner>"):IAGAL2CodePrinter;
		
		/**
		 * [rcp] 0x05
		 *  destination = 1/source1, component-wise
		 */
		function reciprocal(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [min] 0x06
		 * destination = minimum(source1,source2), component-wise
		 */
		function minimum(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [max] 0x07
		 * destination = maximum(source1,source2), component-wise
		 */
		function maximum(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [sqt] 0x09
		 * destination = sqrt(source1), component-wise
		 */
		function squareRoot(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [rsq] 0x0a
		 * destination = 1/sqrt(source1), component-wise
		 */
		function reciprocalRoot(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [pow] 0x0b
		 * destination = pow(source1,source2), component-wise
		 */
		function power(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [log] 0x0c
		 * destination = log_2(source1), component-wise
		 */
		function logarithm(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [exp] 0x0d
		 * destination = 2^source1, component-wise
		 */
		function exponential(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [nrm] 0x0e
		 * destination = normalize(source1), component-wise (produces only a 3 component result, destination must be masked to .xyz or less)
		 */
		function normalize(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [sin] 0x0f
		 * destination = sin(source1), component-wise
		 */
		function sine(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [cos] 0x10
		 * destination = cos(source1), component-wise
		 */
		function cosine(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [crs] 0x11
		 * destination.x = source1.y * source2.z - source1.z * source2.y
		 * destination.y = source1.z * source2.x - source1.x * source2.z
		 * destination.z = source1.x * source2.y - source1.y * source2.x
		 * (produces only a 3 component result, destination must be masked to .xyz or less)
		 */
		function crossProduct(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [dp3] 0x12
		 * destination = source1.x*source2.x + source1.y*source2.y + source1.z*source2.z
		 */
		function dotProduct3(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [dp4] 0x13
		 * destination = source1.x*source2.x + source1.y*source2.y + source1.z*source2.z + source1.w*source2.w
		 */
		function  dotProduct4(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [abs] 0x14
		 * destination = abs(source1), component-wise
		 */
		function absolute(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [neg] 0x15
		 * destination = -source1, component-wise
		 */
		function negate(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [m33] 0x17
		 * destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z)
		 * destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z)
		 * destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z)
		 * (produces only a 3 component result, destination must be masked to .xyz or less)
		 */
		function  multiplyMatrix3x3(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [m44] 0x18
		 * destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z) + (source1.w * source2[0].w)
		 * destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z) + (source1.w * source2[1].w)
		 * destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z) + (source1.w * source2[2].w)
		 * destination.w = (source1.x * source2[3].x) + (source1.y * source2[3].y) + (source1.z * source2[3].z) + (source1.w * source2[3].w)
		 */
		function  multiplyMatrix4x4(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [m34] 0x19
		 * destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z) + (source1.w * source2[0].w)
		 * destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z) + (source1.w * source2[1].w)
		 * destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z) + (source1.w * source2[2].w)
		 * (produces only a 3 component result, destination must be masked to .xyz or less)
		 */
		function  multiplyMatrix3x4(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [kil] 0x27
		 * (fragment shader only)
		 * If single scalar source component is less than zero, fragment is discarded and not drawn to the frame buffer. (Destination register must be set to all 0)
		 */
		function kill(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [sge] 0x29
		 * destination = source1 >= source2 ? 1 : 0, component-wise
		 */
		function setIfGreaterEqual (dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [slt] 0x2a
		 * destination = source1 < source2 ? 1 : 0, component-wise
		 */
		function setIfLessThan(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [seq] 0x2c
		 * destination = source1 == source2 ? 1 : 0, component-wise
		 */
		function setIfEqual(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
		/**
		 * [sne] 0x2d
		 * destination = source1 != source2 ? 1 : 0, component-wise
		 */
		function setIfNotEqual(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter;
		
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
		function els():IAGAL2CodePrinter; // elseは予約語なのでels

		/**
		 * [eif] 0x21
		 * Close if or else block.
		 */
		function endIf():IAGAL2CodePrinter;
	}
}

