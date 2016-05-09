package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontTextFieldFixedLocation;
	import harayoki.starling.BitmapFontUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_MONO:String = "mono_space";
		private static const CONTENTS_SIZE:Rectangle = new Rectangle(0, 0, 320, 240 * 2);

		public static function start(nativeStage:Stage):void {
			trace("Starling version :", Starling.VERSION);

			var starling:Starling = new Starling(
				StarlingMain,
				nativeStage,
				CONTENTS_SIZE
			);
			starling.skipUnchangedFrames = true;
			starling.start();
			starling.stage.color = 0x666666;
		}

		private var _doHelper:DisplayObjectHelper;
		private var _assetManager:AssetManager;
		public function StarlingMain() {

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_doHelper = new DisplayObjectHelper(Starling.current, this, true);
			_assetManager = new AssetManager();
			_assetManager.verbose = true;

			_assetManager.enqueueWithName('app:/assets/atlas.png');
			_assetManager.enqueueWithName('app:/assets/atlas.xml');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {

			// アルファベットフォント(プロポーショナル)を得る
			var font:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);

			// 固定幅フォントを作る
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, font, 8);
			monoSpaceFont.lineHeight = 8;
			BitmapFontUtil.traceBitmapCharInfo(monoSpaceFont);

			// デフォルト右寄せ空白埋め
			var score0:BitmapFontTextFieldFixedLocation
				= new BitmapFontTextFieldFixedLocation(monoSpaceFont.name, "00000000");
			_doHelper.locateDobj(score0, 40, 25);

			// 左寄せ寄せ空白埋め
			var score1:BitmapFontTextFieldFixedLocation
				= new BitmapFontTextFieldFixedLocation(monoSpaceFont.name, "00000000", 0xccffff);
			score1.align = Align.LEFT;
			_doHelper.locateDobj(score1, 40, 50);

			// 右寄せ0埋め
			var score2:BitmapFontTextFieldFixedLocation
				= new BitmapFontTextFieldFixedLocation(monoSpaceFont.name, "00000000", 0xffffcc);
			score2.paddingChr = "0";
			score2.align = Align.RIGHT;
			_doHelper.locateDobj(score2, 40, 75);

			// 左寄せ0埋め
			var score3:BitmapFontTextFieldFixedLocation
				= new BitmapFontTextFieldFixedLocation(monoSpaceFont.name, "00000000", 0xffccff);
			score3.paddingChr = "0";
			score3.align = Align.LEFT;
			_doHelper.locateDobj(score3, 40, 100);

			// 数字以外を含む
			var time:BitmapFontTextFieldFixedLocation
				= new BitmapFontTextFieldFixedLocation(monoSpaceFont.name, "00:00", 0xcccccc);
			time.paddingChr = "0";
			time.align = Align.LEFT;
			_doHelper.locateDobj(time, 40, 125);

			var count:int = 0;
			addEventListener(Event.ENTER_FRAME, function(ev:*){
				count = (count + 1) % 100000000;
				var text = (""  + count);
				score0.setTextWithPadding(text);
				score1.setTextWithPadding(text);
				score2.setTextWithPadding(text);
				score3.setTextWithPadding(text);

				text = ("00" + (count % 100)).slice(-2);
				time.setText(text + ":" + text);
			});

		}


	}
}