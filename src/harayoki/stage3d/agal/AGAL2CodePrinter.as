package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.i.IAGAL2CodePrinter;
	import harayoki.stage3d.agal.i.IAGALDestinationRegister;
	import harayoki.stage3d.agal.i.IAGALRegister;
	import harayoki.stage3d.agal.i.IAGALSamplerRegister;

	public class AGAL2CodePrinter extends AGALCodePrinterBase implements IAGAL2CodePrinter {

		// not impremented now
		public function AGAL2CodePrinter() {
		}

		public function prependCodeDirectly(code:String):IAGAL2CodePrinter {
			_prependCodeDirectly(code);
			return this;
		}

		public function appendCodeDirectly(code:String):IAGAL2CodePrinter {
			_appendCodeDirectly(code);
			return this;
		}

		// TODO add registers extended

		////////// agal1 //////////

		public function move(
			dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("mov", dest, src1);
			return this;
		}

		public function add(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("add", dest, src1, src2);
			return this;
		}

		public function subtract(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("sub", dest, src1, src2);
			return this;
		}

		public function multiply(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("mul", dest, src1, src2);
			return this;
		}

		public function divide(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("div", dest, src1, src2);
			return this;
		}

		public function fractional(
			dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("frc", dest, src1);
			return this;
		}

		public function saturate(
			dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("sat", dest, src1);
			return this;
		}

		public function textureSample(
			dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALSamplerRegister, flags:String="<2d, liner>"):IAGAL2CodePrinter {
			if(flags != null && flags.length > 0) {
				flags = " " + flags;
			} else {
				flags = null;
			}
			_addCode("tex", dest, src1, src2, flags);
			return this;
		}

		public function reciprocal(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("rcp", dest, src1);
			return this;
		}

		public function minimum(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("min", dest, src1, src2);
			return this;
		}

		public function maximum(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("max", dest, src1, src2);
			return this;
		}

		public function squareRoot(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("sqt", dest, src1);
			return this;
		}

		public function reciprocalRoot(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("rsq", dest, src1);
			return this;
		}

		public function power(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("pow", dest, src1, src2);
			return this;
		}

		public function logarithm(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("log", dest, src1);
			return this;
		}

		public function exponential(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("exp", dest, src1);
			return this;
		}

		public function normalize(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("nrm", dest, src1);
			return this;
		}

		public function sine(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("sin", dest, src1);
			return this;
		}

		public function cosine(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("cos", dest, src1);
			return this;
		}

		public function crossProduct(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("crs", dest, src1, src2);
			return this;
		}

		public function dotProduct3(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("dp3", dest, src1, src2);
			return this;
		}

		public function dotProduct4(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("dp4", dest, src1, src2);
			return this;
		}

		public function absolute(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("abs", dest, src1);
			return this;
		}

		public function negate(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("neg", dest, src1);
			return this;
		}

		public function  multiplyMatrix3x3(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("m33", dest, src1, src2);
			return this;
		}

		public function  multiplyMatrix4x4(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("m44", dest, src1, src2);
			return this;
		}

		public function  multiplyMatrix3x4(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("m34", dest, src1, src2);
			return this;
		}

		public function kill(dest:IAGALDestinationRegister, src1:IAGALRegister):IAGAL2CodePrinter {
			_addCode("kil", dest, src1);
			return this;
		}

		public function setIfGreaterEqual (dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("sge", dest, src1, src2);
			return this;
		}

		public function setIfLessThan(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("", dest, src1, src2);
			return this;
		}

		public function setIfEqual(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("seq", dest, src1, src2);
			return this;
		}

		public function setIfNotEqual(dest:IAGALDestinationRegister, src1:IAGALRegister, src2:IAGALRegister):IAGAL2CodePrinter {
			_addCode("sne", dest, src1, src2);
			return this;
		}

		////////// agal2 //////////

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
