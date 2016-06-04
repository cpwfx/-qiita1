package harayoki.stage3d.agal.i {
	public interface IAGAL1CodePrinter {

		// @see http://jacksondunstan.com/articles/1664

		function clear():void;

		function print():String;

		function appendCodeDirectly(code:String):IAGAL1CodePrinter;

		function prependCodeDirectly(code:String):IAGAL1CodePrinter;

		/**
		 * [mov] 0x00
		 * move data from source1 to destination, component-wise
		 */
		function move(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL1CodePrinter

		/**
		 * [add] 0x01
		 * destination = source1 + source2, component-wise
		 */
		function add(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter;

		/**
		 * [sub] 0x02
		 *  destination = source1 - source2, component-wise
		 */
		function subtract(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter;

		/**
		 *  [mul] 0x03
		 *  destination = source1 * source2, component-wise
		 */
		function multiply(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter;

		/**
		 * [div] 0x04
		 * destination = source1 / source2, component-wise
		 */
		function divide(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter;


		/**
		 * [frc] 0x08
		 * destination = source1 - (float)floor(source1), component-wise
		 */
		function fractional(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL1CodePrinter;

		/**
		 * [sat] 0x16
		 * destination = maximum(minimum(source1,1),0), component-wise
		 */
		function saturate(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL1CodePrinter;


		/**
		 * [tex] 0x28 (fragment shader only)
		 * destination equals load from texture source2 at coordinates source1.
		 * In this case, source2 must be in sampler format.
		 */
		function textureSample(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALSamplerRegister, flags:String="<2d, liner>"):IAGAL1CodePrinter;

	}
}


/*



 function xxx(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL1CodePrinter;

 rcp

 0x05

 reciprocal

 destination = 1/source1, component-wise

 min

 0x06

 minimum

 destination = minimum(source1,source2), component-wise

 max

 0x07

 maximum

 destination = maximum(source1,source2), component-wise


 sqt

 0x09

 square root

 destination = sqrt(source1), component-wise

 rsq

 0x0a

 reciprocal root

 destination = 1/sqrt(source1), component-wise

 pow

 0x0b

 power

 destination = pow(source1,source2), component-wise

 log

 0x0c

 logarithm

 destination = log_2(source1), component-wise

 exp

 0x0d

 exponential

 destination = 2^source1, component-wise

 nrm

 0x0e

 normalize

 destination = normalize(source1), component-wise (produces only a 3 component result, destination must be masked to .xyz or less)

 sin

 0x0f

 sine

 destination = sin(source1), component-wise

 cos

 0x10

 cosine

 destination = cos(source1), component-wise

 crs

 0x11

 cross product

 destination.x = source1.y * source2.z - source1.z * source2.y

 destination.y = source1.z * source2.x - source1.x * source2.z

 destination.z = source1.x * source2.y - source1.y * source2.x

 (produces only a 3 component result, destination must be masked to .xyz or less)

 dp3

 0x12

 dot product

 destination = source1.x*source2.x + source1.y*source2.y + source1.z*source2.z

 dp4

 0x13

 dot product

 destination = source1.x*source2.x + source1.y*source2.y + source1.z*source2.z + source1.w*source2.w

 abs

 0x14

 absolute

 destination = abs(source1), component-wise

 neg

 0x15

 negate

 destination = -source1, component-wise



 m33

 0x17

 multiply matrix 3x3

 destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z)

 destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z)

 destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z)

 (produces only a 3 component result, destination must be masked to .xyz or less)

 m44

 0x18

 multiply matrix 4x4

 destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z) + (source1.w * source2[0].w)

 destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z) + (source1.w * source2[1].w)

 destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z) + (source1.w * source2[2].w)

 destination.w = (source1.x * source2[3].x) + (source1.y * source2[3].y) + (source1.z * source2[3].z) + (source1.w * source2[3].w)

 m34

 0x19

 multiply matrix 3x4

 destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z) + (source1.w * source2[0].w)

 destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z) + (source1.w * source2[1].w)

 destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z) + (source1.w * source2[2].w)

 (produces only a 3 component result, destination must be masked to .xyz or less)

 kil

 0x27

 kill/discard (fragment shader only)

 If single scalar source component is less than zero, fragment is discarded and not drawn to the frame buffer. (Destination register must be set to all 0)


 sge

 0x29

 set-if-greater-equal

 destination = source1 >= source2 ? 1 : 0, component-wise

 slt

 0x2a

 set-if-less-than

 destination = source1 < source2 ? 1 : 0, component-wise

 seq

 0x2c

 set-if-equal

 destination = source1 == source2 ? 1 : 0, component-wise

 sne

 0x2d

 set-if-not-equal

 destination = source1 != source2 ? 1 : 0, component-wise
 */