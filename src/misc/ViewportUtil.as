package misc {
	import flash.events.Event;
	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.utils.Align;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;

	public class ViewportUtil {

		public static var SHOW_STATS_VALIGN:String = Align.LEFT;
		public static var SHOW_STATS_HALIGN:String = Align.TOP;

		public static function setupViewPort(starling:Starling, contentsSize:Rectangle, showStats:Boolean=true):void {

			// 画面の大きさを1,2,3,4..倍に吸着して真ん中寄せ 1倍より小さい場合はそのまま
			var updateViewPort:Function = function(ev:Event=null):void {
				var w:int = starling.nativeStage.stageWidth;
				var h:int = starling.nativeStage.stageHeight;
				var scale:Number = Math.min(w/contentsSize.width,h/contentsSize.height);
				if(scale > 1.0) scale = Math.floor(scale); //0になるとエラー
				trace(['stage', w,h],'scale to', scale);
				starling.viewPort = RectangleUtil.fit(
					contentsSize,
					new Rectangle(
						(w - contentsSize.width*scale)>>1,
						(h - contentsSize.height*scale)>>1,
						contentsSize.width*scale,
						contentsSize.height*scale
					),
					ScaleMode.SHOW_ALL
				);
				if(showStats) {
					starling.showStatsAt(SHOW_STATS_VALIGN, SHOW_STATS_HALIGN);
				}
			}

			starling.nativeStage.addEventListener(Event.RESIZE, updateViewPort);
			starling.showStats = showStats;
			updateViewPort();

		}
	}
}
