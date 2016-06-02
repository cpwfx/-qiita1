package harayoki.stage3d.agal {
	import harayoki.stage3d.agal.registers.*;
	public class AGAL1Registers {
		private static var _instance:AGAL1Registers;
		public static function getInstance():AGAL1Registers {
			if(!_instance) {
				_instance = new AGAL1Registers();
			}
			return _instance;
		}

		public const vc1  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  1);
		public const vc2  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  2);
		public const vc3  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  3);
		public const vc4  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  4);
		public const vc5  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  5);
		public const vc6  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  6);
		public const vc7  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  7);
		public const vc8  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  8);
		public const vc9  :AGALRegisterVertexConstant = new AGALRegisterVertexConstant(  9);
		public const vc10 :AGALRegisterVertexConstant = new AGALRegisterVertexConstant( 10);
		// todo 11 ~ 127
		public const vc128:AGALRegisterVertexConstant = new AGALRegisterVertexConstant(128);

		public const vt1:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  1);
		public const vt2:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  2);
		public const vt3:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  3);
		public const vt4:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  4);
		public const vt5:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  5);
		public const vt6:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  6);
		public const vt7:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  7);
		public const vt8:  AGALRegisterVertexTemporary = new AGALRegisterVertexTemporary(  8);

		public const op:   AGALRegisterVertexOutput = new AGALRegisterVertexOutput();

	}
}
