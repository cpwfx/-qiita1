package harayoki.stage3d.agal {
	import flash.utils.Dictionary;

	import harayoki.stage3d.agal.i.IAGALRegister;
	import harayoki.stage3d.agal.registers.*;

	public class AGAL1RegisterPool{


		private var _instances:Dictionary;

		public function AGAL1RegisterPool() {

			_instances = new Dictionary();
			_instances[AGALRegisterVertexConstant] = new <AGALRegisterVertexConstant>[];
			_instances[AGALRegisterVertexTemporary] = new <AGALRegisterVertexTemporary>[];
			_instances[AGALRegisterFragmentConstant] = new <AGALRegisterFragmentConstant>[];
			_instances[AGALRegisterFragmentTemporary] = new <AGALRegisterFragmentTemporary>[];
			_instances[AGALRegisterVertexAttribute] = new <AGALRegisterVertexAttribute>[];
			_instances[AGALRegisterVarying] = new <AGALRegisterVarying>[];
		}

		protected function _save(register:IAGALRegister):void {
			register.clear();
			if(register is AGALRegisterVertexConstant) {
				var v1:Vector.<AGALRegisterVertexConstant> = _instances[AGALRegisterVertexConstant];
				v1.push(AGALRegisterVertexConstant(register));
				// trace("saved as AGALRegisterVertexConstant");
			} else if(register is AGALRegisterFragmentTemporary) {
				var v2:Vector.<AGALRegisterFragmentTemporary> = _instances[AGALRegisterFragmentTemporary];
				v2.push(AGALRegisterFragmentTemporary(register));
				// trace("saved as AGALRegisterFragmentTemporary");
			} else if(register is AGALRegisterFragmentConstant) {
				var v3:Vector.<AGALRegisterFragmentConstant> = _instances[AGALRegisterFragmentConstant];
				v3.push(AGALRegisterFragmentConstant(register));
				// trace("saved as AGALRegisterFragmentConstant");
			} else if(register is AGALRegisterVertexTemporary) {
				var v4:Vector.<AGALRegisterVertexTemporary> = _instances[AGALRegisterVertexTemporary];
				v4.push(AGALRegisterVertexTemporary(register));
				// trace("saved as AGALRegisterVertexTemporary");
			} else if(register is AGALRegisterVertexTemporary) {
				var v5:Vector.<AGALRegisterVertexAttribute> = _instances[AGALRegisterVertexAttribute];
				v5.push(AGALRegisterVertexAttribute(register));
				// trace("saved as AGALRegisterVertexAttribute");
			} else if(register is AGALRegisterVarying) {
				var v6:Vector.<AGALRegisterVarying> = _instances[AGALRegisterVarying];
				v6.push(AGALRegisterVarying(register));
				// trace("saved as AGALRegisterVarying");
			}

		}

		private function _getAGALRegisterVertexAttribute(index:int):AGALRegisterVertexAttribute {
			var v:Vector.<AGALRegisterVertexAttribute> = _instances[AGALRegisterVertexAttribute];
			var r:AGALRegisterVertexAttribute =  v.length > 0 ? v.pop() : new AGALRegisterVertexAttribute(index);
			r.index = index;
			return r;
		}

		private function _getAGALRegisterVertexConstant(index:int):AGALRegisterVertexConstant {
			var v:Vector.<AGALRegisterVertexConstant> = _instances[AGALRegisterVertexConstant];
			var r:AGALRegisterVertexConstant =  v.length > 0 ? v.pop() : new AGALRegisterVertexConstant(index);
			r.index = index;
			return r;
		}

		private function _getAGALRegisterVertexTemporary(index:int):AGALRegisterVertexTemporary {
			var v:Vector.<AGALRegisterVertexTemporary> = _instances[AGALRegisterVertexTemporary];
			var r:AGALRegisterVertexTemporary =  v.length > 0 ? v.pop() : new AGALRegisterVertexTemporary(index);
			r.index = index;
			return r;
		}

		private function _getAGALRegisterFragmentTemporary(index:int):AGALRegisterFragmentTemporary {
			var v:Vector.<AGALRegisterFragmentTemporary> = _instances[AGALRegisterFragmentTemporary];
			var r:AGALRegisterFragmentTemporary =  v.length > 0 ? v.pop() : new AGALRegisterFragmentTemporary(index);
			r.index = index;
			return r;
		}

		private function _getAGALRegisterFragmentConstant(index:int):AGALRegisterFragmentConstant {
			var v:Vector.<AGALRegisterFragmentConstant> = _instances[AGALRegisterFragmentConstant];
			var r:AGALRegisterFragmentConstant =  v.length > 0 ? v.pop() : new AGALRegisterFragmentConstant(index);
			r.index = index;
			return r;
		}

		private function _getAGALRegisterVarying(index:int):AGALRegisterVarying {
			var v:Vector.<AGALRegisterVarying> = _instances[AGALRegisterVarying];
			var r:AGALRegisterVarying =  v.length > 0 ? v.pop() : new AGALRegisterVarying(index);
			r.index = index;
			return r;
		}

		////////// outputs //////////

		public const op:AGALRegisterVertexOutput = new AGALRegisterVertexOutput();

		public const oc:AGALRegisterFragmentOutput = new AGALRegisterFragmentOutput();

		public function get v0():AGALRegisterVarying {
			return _getAGALRegisterVarying(0);
		}

		public function get v1():AGALRegisterVarying {
			return _getAGALRegisterVarying(1);
		}

		public function get v2():AGALRegisterVarying {
			return _getAGALRegisterVarying(2);
		}

		public function get v3():AGALRegisterVarying {
			return _getAGALRegisterVarying(3);
		}

		public function get v4():AGALRegisterVarying {
			return _getAGALRegisterVarying(4);
		}

		public function get v5():AGALRegisterVarying {
			return _getAGALRegisterVarying(5);
		}

		public function get v6():AGALRegisterVarying {
			return _getAGALRegisterVarying(6);
		}

		public function get v7():AGALRegisterVarying {
			return _getAGALRegisterVarying(7);
		}

		public function get vc0():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(0);
		}

		public function get vc1():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(1);
		}

		public function get vc2():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(2);
		}

		public function get vc3():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(3);
		}

		public function get vc4():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(4);
		}

		public function get vc5():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(5);
		}

		public function get vc6():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(6);
		}

		public function get vc7():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(7);
		}

		public function get vc8():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(8);
		}

		public function get vc9():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(9);
		}

		public function get vc10():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(10);
		}

		public function get vc11():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(11);
		}

		public function get vc12():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(12);
		}

		public function get vc13():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(13);
		}

		public function get vc14():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(14);
		}

		public function get vc15():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(15);
		}

		public function get vc16():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(16);
		}

		public function get vc17():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(17);
		}

		public function get vc18():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(18);
		}

		public function get vc19():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(19);
		}

		public function get vc20():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(20);
		}

		public function get vc21():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(21);
		}

		public function get vc22():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(22);
		}

		public function get vc23():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(23);
		}

		public function get vc24():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(24);
		}

		public function get vc25():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(25);
		}

		public function get vc26():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(26);
		}

		public function get vc27():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(27);
		}

		public function get vc28():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(28);
		}

		public function get vc29():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(29);
		}

		public function get vc30():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(30);
		}

		public function get vc31():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(31);
		}

		public function get vc32():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(32);
		}

		public function get vc33():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(33);
		}

		public function get vc34():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(34);
		}

		public function get vc35():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(35);
		}

		public function get vc36():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(36);
		}

		public function get vc37():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(37);
		}

		public function get vc38():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(38);
		}

		public function get vc39():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(39);
		}

		public function get vc40():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(40);
		}

		public function get vc41():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(41);
		}

		public function get vc42():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(42);
		}

		public function get vc43():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(43);
		}

		public function get vc44():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(44);
		}

		public function get vc45():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(45);
		}

		public function get vc46():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(46);
		}

		public function get vc47():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(47);
		}

		public function get vc48():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(48);
		}

		public function get vc49():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(49);
		}

		public function get vc50():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(50);
		}

		public function get vc51():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(51);
		}

		public function get vc52():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(52);
		}

		public function get vc53():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(53);
		}

		public function get vc54():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(54);
		}

		public function get vc55():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(55);
		}

		public function get vc56():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(56);
		}

		public function get vc57():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(57);
		}

		public function get vc58():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(58);
		}

		public function get vc59():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(59);
		}

		public function get vc60():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(60);
		}

		public function get vc61():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(61);
		}

		public function get vc62():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(62);
		}

		public function get vc63():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(63);
		}

		public function get vc64():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(64);
		}

		public function get vc65():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(65);
		}

		public function get vc66():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(66);
		}

		public function get vc67():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(67);
		}

		public function get vc68():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(68);
		}

		public function get vc69():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(69);
		}

		public function get vc70():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(70);
		}

		public function get vc71():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(71);
		}

		public function get vc72():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(72);
		}

		public function get vc73():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(73);
		}

		public function get vc74():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(74);
		}

		public function get vc75():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(75);
		}

		public function get vc76():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(76);
		}

		public function get vc77():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(77);
		}

		public function get vc78():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(78);
		}

		public function get vc79():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(79);
		}

		public function get vc80():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(80);
		}

		public function get vc81():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(81);
		}

		public function get vc82():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(82);
		}

		public function get vc83():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(83);
		}

		public function get vc84():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(84);
		}

		public function get vc85():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(85);
		}

		public function get vc86():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(86);
		}

		public function get vc87():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(87);
		}

		public function get vc88():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(88);
		}

		public function get vc89():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(89);
		}

		public function get vc90():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(90);
		}

		public function get vc91():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(91);
		}

		public function get vc92():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(92);
		}

		public function get vc93():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(93);
		}

		public function get vc94():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(94);
		}

		public function get vc95():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(95);
		}

		public function get vc96():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(96);
		}

		public function get vc97():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(97);
		}

		public function get vc98():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(98);
		}

		public function get vc99():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(99);
		}

		public function get vc100():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(100);
		}

		public function get vc101():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(101);
		}

		public function get vc102():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(102);
		}

		public function get vc103():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(103);
		}

		public function get vc104():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(104);
		}

		public function get vc105():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(105);
		}

		public function get vc106():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(106);
		}

		public function get vc107():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(107);
		}

		public function get vc108():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(108);
		}

		public function get vc109():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(109);
		}

		public function get vc110():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(110);
		}

		public function get vc111():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(111);
		}

		public function get vc112():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(112);
		}

		public function get vc113():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(113);
		}

		public function get vc114():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(114);
		}

		public function get vc115():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(115);
		}

		public function get vc116():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(116);
		}

		public function get vc117():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(117);
		}

		public function get vc118():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(118);
		}

		public function get vc119():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(119);
		}

		public function get vc120():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(120);
		}

		public function get vc121():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(121);
		}

		public function get vc122():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(122);
		}

		public function get vc123():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(123);
		}

		public function get vc124():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(124);
		}

		public function get vc125():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(125);
		}

		public function get vc126():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(126);
		}

		public function get vc127():AGALRegisterVertexConstant {
			return _getAGALRegisterVertexConstant(127);
		}

		public function get vt0():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(0);
		}

		public function get vt1():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(1);
		}

		public function get vt2():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(2);
		}

		public function get vt3():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(3);
		}

		public function get vt4():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(4);
		}

		public function get vt5():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(5);
		}

		public function get vt6():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(6);
		}

		public function get vt7():AGALRegisterVertexTemporary {
			return _getAGALRegisterVertexTemporary(7);
		}

		public function get va0():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(0);
		}

		public function get va1():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(1);
		}

		public function get va2():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(2);
		}

		public function get va3():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(3);
		}

		public function get va4():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(4);
		}

		public function get va5():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(5);
		}

		public function get va6():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(6);
		}

		public function get va7():AGALRegisterVertexAttribute {
			return _getAGALRegisterVertexAttribute(7);
		}

		public function get ft0():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(0);
		}

		public function get ft1():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(1);
		}

		public function get ft2():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(2);
		}

		public function get ft3():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(3);
		}

		public function get ft4():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(4);
		}

		public function get ft5():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(5);
		}

		public function get ft6():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(6);
		}

		public function get ft7():AGALRegisterFragmentTemporary {
			return _getAGALRegisterFragmentTemporary(7);
		}

		public function get fc0():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(0);
		}

		public function get fc1():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(1);
		}

		public function get fc2():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(2);
		}

		public function get fc3():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(3);
		}

		public function get fc4():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(4);
		}

		public function get fc5():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(5);
		}

		public function get fc6():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(6);
		}

		public function get fc7():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(7);
		}

		public function get fc8():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(8);
		}

		public function get fc9():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(9);
		}

		public function get fc10():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(10);
		}

		public function get fc11():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(11);
		}

		public function get fc12():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(12);
		}

		public function get fc13():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(13);
		}

		public function get fc14():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(14);
		}

		public function get fc15():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(15);
		}

		public function get fc16():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(16);
		}

		public function get fc17():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(17);
		}

		public function get fc18():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(18);
		}

		public function get fc19():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(19);
		}

		public function get fc20():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(20);
		}

		public function get fc21():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(21);
		}

		public function get fc22():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(22);
		}

		public function get fc23():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(23);
		}

		public function get fc24():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(24);
		}

		public function get fc25():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(25);
		}

		public function get fc26():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(26);
		}

		public function get fc27():AGALRegisterFragmentConstant {
			return _getAGALRegisterFragmentConstant(27);
		}


	}
}
// 開発用メソッド コードジェネレート
internal function _traceCode():void {

	var i:int;

	for (i;i<8;i++) {
		trace("		public function get v" + i + "():AGALRegisterVarying {");
		trace("			return _getAGALRegisterVarying("+i+");");
		trace("		}\n");
	}

	for (i;i<8;i++) {
		trace("		public function get va" + i + "():AGALRegisterVertexAttribute {");
		trace("			return _getAGALRegisterVertexAttribute("+i+");");
		trace("		}\n");
	}

	for (i;i<8;i++) {
		trace("		public function get vt" + i + "():AGALRegisterVertexTemporary {");
		trace("			return _getAGALRegisterVertexTemporary("+i+");");
		trace("		}\n");
	}

	for (i=0;i<128;i++) {
		trace("		public function get vc" + i + "():AGALRegisterVertexConstant {");
		trace("			return _getAGALRegisterVertexConstant("+i+");");
		trace("		}\n");
	}

	for (i=0;i<8;i++) {
		trace("		public function get ft" + i + "():AGALRegisterFragmentTemporary {");
		trace("			return _getAGALRegisterFragmentTemporary("+i+");");
		trace("		}\n");
	}

	for (i=0;i<28;i++) {
		trace("		public function get fc" + i + "():AGALRegisterFragmentConstant {");
		trace("			return _getAGALRegisterFragmentConstant("+i+");");
		trace("		}\n");
	}

}
