package harayoki.stage3d {
	import flash.display3D.Context3D;

	// wireframe設定がweb書き出しで使えないのでコンパイルが通るように一度インターフェースで包む
	public interface IContext3DFillModeControl {
		function setContext(context:Context3D):void;
		function setWireFrame(flag:Boolean):void;
		function toggleWireFrame():void;
		function isWireFrameNow():Boolean;
	}
}
