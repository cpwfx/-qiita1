package harayoki.stage3d.agal.registers {
	public class AGALRegisterConstant implements IAGALConstantRegister, IAGALRegister {

		private var _name:String = "";
		private var _index:uint;

		public function AGALRegisterConstant(name:String, index:uint) {
			_name = name;
			_index = index;
		}

		public function get name():String {
			return _name + _index;
		}
		public function get index():uint {
			return _index;
		}


		public function get     x():AGALRegisterConstant {
			return this;
		}

		public function get     y():AGALRegisterConstant {
			return this;
		}

		public function get     z():AGALRegisterConstant {
			return this;
		}

		public function get     w():AGALRegisterConstant {
			return this;
		}

		public function get   xx():AGALRegisterConstant {
			return this;
		}

		public function get   xy():AGALRegisterConstant {
			return this;
		}

		public function get   xz():AGALRegisterConstant {
			return this;
		}

		public function get   xw():AGALRegisterConstant {
			return this;
		}

		public function get   yx():AGALRegisterConstant {
			return this;
		}

		public function get   yy():AGALRegisterConstant {
			return this;
		}

		public function get   yz():AGALRegisterConstant {
			return this;
		}

		public function get   yw():AGALRegisterConstant {
			return this;
		}

		public function get   zx():AGALRegisterConstant {
			return this;
		}

		public function get   zy():AGALRegisterConstant {
			return this;
		}

		public function get   zz():AGALRegisterConstant {
			return this;
		}

		public function get   zw():AGALRegisterConstant {
			return this;
		}

		public function get   wx():AGALRegisterConstant {
			return this;
		}

		public function get   wy():AGALRegisterConstant {
			return this;
		}

		public function get   wz():AGALRegisterConstant {
			return this;
		}

		public function get   ww():AGALRegisterConstant {
			return this;
		}

		public function get  xxx():AGALRegisterConstant {
			return this;
		}
		public function get  xxy():AGALRegisterConstant {
			return this;
		}
		public function get  xxz():AGALRegisterConstant {
			return this;
		}
		public function get  xxw():AGALRegisterConstant {
			return this;
		}

		public function get  xyx():AGALRegisterConstant {
			return this;
		}
		public function get  xyy():AGALRegisterConstant {
			return this;
		}
		public function get  xyz():AGALRegisterConstant {
			return this;
		}
		public function get xyw():AGALRegisterConstant {
			return this;
		}

		public function get xzx():AGALRegisterConstant {
			return this;
		}
		public function get xzy():AGALRegisterConstant {
			return this;
		}
		public function get xzz():AGALRegisterConstant {
			return this;
		}
		public function get xzw():AGALRegisterConstant {
			return this;
		}
		public function get xwx():AGALRegisterConstant {
			return this;
		}
		public function get xwy():AGALRegisterConstant {
			return this;
		}
		public function get xwz():AGALRegisterConstant {
			return this;
		}
		public function get xww():AGALRegisterConstant {
			return this;
		}

		public function get yyx():AGALRegisterConstant {
			return this;
		}
		public function get yyy():AGALRegisterConstant {
			return this;
		}
		public function get yyz():AGALRegisterConstant {
			return this;
		}
		public function get yyw():AGALRegisterConstant {
			return this;
		}

		public function get yxy():AGALRegisterConstant {
			return this;
		}
		public function get yxz():AGALRegisterConstant {
			return this;
		}
		public function get yzx():AGALRegisterConstant {
			return this;
		}
		public function get yzz():AGALRegisterConstant {
			return this;
		}


		public function get zzz():AGALRegisterConstant {
			return this;
		}

		public function get www():AGALRegisterConstant {
			return this;
		}

		public function get xxxx():AGALRegisterConstant {
			return this;
		}

		public function get yyyy():AGALRegisterConstant {
			return this;
		}

		public function get zzzz():AGALRegisterConstant {
			return this;
		}

		public function get wwww():AGALRegisterConstant {
			return this;
		}

	}
}
