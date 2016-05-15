package {
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import harayoki.starling.BitmapFontTextFieldFixedLocation;
	import harayoki.starling.BitmapFontUtil;
	import harayoki.util.CharCodeUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_MONO:String = "mono_space";
		private static const FONT_NAME_KANA:String = "kana_only";
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
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});
		}

		private function _start():void {
			_showTexts(false, false);
		}

		private function _showTexts(hideInfoText:Boolean, useTexField:Boolean):void {


			function createBitmapFontTextField(
				fontName:String, formatString:String, color:Number=0xffffff,
				size:Number=0, width:int=0, height:int=0
			):BitmapFontTextFieldFixedLocation {
				if(useTexField) {
					return BitmapFontTextFieldFixedLocation.getInstanceWithForGeneralTextField(
						fontName, formatString, color, size, width, height);
				} else {
					return BitmapFontTextFieldFixedLocation.getInstance(
						fontName, formatString, color, size, width, height);
				}
			}

			// カナフォントを得る
			var baseFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_KANA);
			// アルファベットフォント(プロポーショナル)を得る
			var subFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);
			// カナフォントに英字フォントを合体
			BitmapFontUtil.overWriteCopyBitmapChars(baseFont, subFont, true, baseFont.lineHeight - subFont.lineHeight + 1);

			// 固定幅フォントを作る
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, baseFont, 16);
			monoSpaceFont.lineHeight = 8;
			// 半角設定
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListForAscii());

			// 余白付きドットを合成
			var dotTexture:Texture = _assetManager.getTexture("dot12x12");
			trace(dotTexture.width, dotTexture.height, dotTexture.frameWidth, dotTexture.frameHeight);
			var dotChar:BitmapChar =
				BitmapFontUtil.createBitmapCharByTexture("・", dotTexture, -1, 3, 12, true, baseFont.size);
			BitmapFontUtil.addBitmapCharToFont(baseFont, dotChar);

			BitmapFontUtil.traceBitmapCharInfo(baseFont);

			// デフォルト右寄せ空白埋め
			var score0:BitmapFontTextFieldFixedLocation
				= createBitmapFontTextField(baseFont.name, "00000000");
			_doHelper.locateDobj(score0.displayObject, 160, 25);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("デフォルト・ヒダリよせ", baseFont.name, 200, 100, 0, 0x999999), 20, 25);

			// 左寄せ寄せ空白埋め
			var score1:BitmapFontTextFieldFixedLocation
				= createBitmapFontTextField(baseFont.name, "00000000", 0xccffff);
			score1.align = Align.RIGHT;
			_doHelper.locateDobj(score1.displayObject, 160, 50);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("ミギよせ", baseFont.name, 200, 100, 0, 0x999999), 20, 50);

			// 右寄せ0埋め
			var score2:BitmapFontTextFieldFixedLocation
				= createBitmapFontTextField(baseFont.name, "00000000", 0xffffcc);
			score2.paddingChr = "0";
			score2.align = Align.RIGHT;
			_doHelper.locateDobj(score2.displayObject, 160, 75);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("ミギよせ・ゼロうめ", baseFont.name, 200, 100, 0, 0x999999), 20, 75);

			// 左寄せ0埋め
			var score3:BitmapFontTextFieldFixedLocation
				= createBitmapFontTextField(baseFont.name, "00000000", 0xffccff);
			score3.paddingChr = "*";
			score3.align = Align.LEFT;
			_doHelper.locateDobj(score3.displayObject, 160, 100);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("ヒダリよせ・ゼロうめ", baseFont.name, 200, 100, 0, 0x999999), 20, 100);

			// 数字以外を含む
			var time:BitmapFontTextFieldFixedLocation
				= createBitmapFontTextField(baseFont.name, "00:00", 0xcccccc);
			_doHelper.locateDobj(time.displayObject, 160, 125);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("スウジいがいをふくむ", baseFont.name, 200, 100, 0, 0x999999), 20, 125);

			// メッセージ表示処理
			var message:String = "・じゅげむ　じゅげむ　ごこうのすりきれ" +
				"かいじゃりすいぎょの　すいぎょうまつ" +
				"うんらいまつ　ふうらいまつ" +
				"くうねるところにすむところ" +
				"やぶらこうじのやぶこうじ" +
				"ぱいぽ　ぱいぽ　ぱいぽのしゅーりんがん" +
				"しゅーりんがんのぐーりんだい" +
				"ぐーりんだいのぽんぽこぴーの" +
				"ぽんぽこなーの" +
				"ちょうきゅうめいのちょうすけ" +
				"・・・・・　　　　　　　　　";

			var messageBox:BitmapFontTextFieldFixedLocation =
				createBitmapFontTextField(baseFont.name,
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ" +
					"ああああああああああああああああ",
					0xffffff, 0, 16*16);
			_doHelper.locateDobj(messageBox.displayObject, 20, 175);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("メッセージボックス", baseFont.name, 200, 100, 0, 0x999999), 20, 150);

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

				messageBox.setTextWithPadding(message.slice(0, 1 + (count) % message.length));

			});

		}


	}
}