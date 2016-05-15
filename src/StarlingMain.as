package {
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.system.System;

	import harayoki.starling.BitmapFontUtil;
	import harayoki.starling.FixedLayoutBitmapTextController;
	import harayoki.util.CharCodeUtil;

	import misc.DisplayObjectHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
			var hideInfoText:Boolean = false;
			var useTexField:Boolean = false;
			var bachableTextField:Boolean = false;
			_showTexts(hideInfoText, useTexField, bachableTextField);
		}

		private function _showTexts(hideInfoText:Boolean, useTexField:Boolean, bachableTextField:Boolean):void {


			function createBitmapFontTextField(
				fontName:String, formatString:String, color:Number=0xffffff,
				size:Number=0, width:int=0, height:int=0
			):FixedLayoutBitmapTextController {
				if(useTexField) {
					return FixedLayoutBitmapTextController.getInstanceWithForGeneralTextField(
						fontName, formatString, color, size, width, height, bachableTextField);
				} else {
					return FixedLayoutBitmapTextController.getInstance(
						fontName, formatString, color, size, width, height);
				}
			}

			// カナフォントを得る
			var baseFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_KANA);
			// アルファベットフォント(プロポーショナル)を得る
			var subFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);
			// カナフォントに英字フォントを合体
			BitmapFontUtil.overWriteCopyBitmapChars(baseFont, subFont, true, baseFont.lineHeight - subFont.lineHeight + 1);

			//// 固定幅フォントを作る
			//var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, baseFont, 16);
			//monoSpaceFont.lineHeight = 8;
			//// 半角設定
			//BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListForAscii());

			// ":"の文字を調整
			BitmapFontUtil.updatePadding(baseFont, -2, -1, -2, CharCodeUtil.getIdListByLetters(":"));

			// 余白付きドットを合成
			var dotTexture:Texture = _assetManager.getTexture("dot12x12");
			trace(dotTexture.width, dotTexture.height, dotTexture.frameWidth, dotTexture.frameHeight);
			var dotChar:BitmapChar =
				BitmapFontUtil.createBitmapCharByTexture("・", dotTexture, -1, 3, 12, true, baseFont.size);
			BitmapFontUtil.addBitmapCharToFont(baseFont, dotChar);

			BitmapFontUtil.traceBitmapCharInfo(baseFont);

			// デフォルト左寄せ空白埋め
			var score0:FixedLayoutBitmapTextController
				= createBitmapFontTextField(baseFont.name, "00000000");
			_doHelper.locateDobj(score0.displayObject, 160, 25);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("デフォルト・ヒダリよせ", baseFont.name, 200, 100, 0, 0x999999), 20, 25);

			// 右寄せ寄せ空白埋め
			var score1:FixedLayoutBitmapTextController
				= createBitmapFontTextField(baseFont.name, "00000000", 0xccffff);
			score1.align = Align.RIGHT;
			_doHelper.locateDobj(score1.displayObject, 160, 50);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("ミギよせ", baseFont.name, 200, 100, 0, 0x999999), 20, 50);

			// 右寄せ0埋め
			var score2:FixedLayoutBitmapTextController
				= createBitmapFontTextField(baseFont.name, "00000000", 0xffffcc);
			score2.paddingChr = "0";
			score2.align = Align.RIGHT;
			_doHelper.locateDobj(score2.displayObject, 160, 75);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("ミギよせ・ゼロうめ", baseFont.name, 200, 100, 0, 0x999999), 20, 75);

			// 左寄せ*埋め
			var score3:FixedLayoutBitmapTextController
				= createBitmapFontTextField(baseFont.name, "00000000", 0xffccff);
			score3.paddingChr = "*";
			score3.align = Align.LEFT;
			_doHelper.locateDobj(score3.displayObject, 160, 100);
			if(!hideInfoText) _doHelper.locateDobj(
				_doHelper.createSpriteText("ヒダリよせ・*うめ", baseFont.name, 200, 100, 0, 0x999999), 20, 100);

			// 数字以外を含む
			var time:FixedLayoutBitmapTextController
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

			var messageBox:FixedLayoutBitmapTextController =
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

			// タッチ時にGCしてみる
			var gcobj:DisplayObject = _doHelper.createSpriteText("[TOUCH TO GC]", baseFont.name, 200, 20, 0, 0xffffff);
			_doHelper.locateDobj(gcobj, 10, 450);
			gcobj.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent):void{
				if(ev.getTouch(gcobj, TouchPhase.BEGAN)) {
					trace("gc!");
					System.gc();
				}
			});

		}

	}
}