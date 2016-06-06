package demos {
	import harayoki.starling.BitmapFontUtil;
	import harayoki.starling.FixedLayoutBitmapTextController;
	import harayoki.starling.utils.AssetManager;
	import harayoki.util.CharCodeUtil;

	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.utils.Align;

	public class ScoreTextDemo extends DemoBase {

		public function ScoreTextDemo(assetmanager:AssetManager, starling:Starling=null) {
			super(assetmanager, starling);
		}

		public override function start():void {

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

			var font:BitmapFont = BitmapFontUtil.cloneBitmapFont("font", MyFontManager.baseFont);

			// ":"の文字を調整
			BitmapFontUtil.updatePadding(font, -2, -1, -2, CharCodeUtil.getIdListByLetters(":"));

			// 余白付きドットを合成
			var dotTexture:Texture = _assetManager.getTexture("dot12x12");
			trace(dotTexture.width, dotTexture.height, dotTexture.frameWidth, dotTexture.frameHeight);
			var dotChar:BitmapChar =
				BitmapFontUtil.createBitmapCharByTexture("・", dotTexture, -1, 3, 12, true, font.size);
			BitmapFontUtil.addBitmapCharToFont(font, dotChar);

			BitmapFontUtil.traceBitmapCharInfo(font);

			// デフォルト左寄せ空白埋め
			var score0:FixedLayoutBitmapTextController
				= createBitmapFontTextField(font.name, "00000000");
			_demoHelper.locateDobj(score0.displayObject, 160, 25);
			if(!hideInfoText) _demoHelper.locateDobj(
				_demoHelper.createSpriteText("デフォルト・ヒダリよせ", font.name, 200, 100, 0, 0x999999), 20, 25);

			// 右寄せ寄せ空白埋め
			var score1:FixedLayoutBitmapTextController
				= createBitmapFontTextField(font.name, "00000000", 0xccffff);
			score1.align = Align.RIGHT;
			_demoHelper.locateDobj(score1.displayObject, 160, 50);
			if(!hideInfoText) _demoHelper.locateDobj(
				_demoHelper.createSpriteText("ミギよせ", font.name, 200, 100, 0, 0x999999), 20, 50);

			// 右寄せ0埋め
			var score2:FixedLayoutBitmapTextController
				= createBitmapFontTextField(font.name, "00000000", 0xffffcc);
			score2.paddingChr = "0";
			score2.align = Align.RIGHT;
			_demoHelper.locateDobj(score2.displayObject, 160, 75);
			if(!hideInfoText) _demoHelper.locateDobj(
				_demoHelper.createSpriteText("ミギよせ・ゼロうめ", font.name, 200, 100, 0, 0x999999), 20, 75);

			// 左寄せ*埋め
			var score3:FixedLayoutBitmapTextController
				= createBitmapFontTextField(font.name, "00000000", 0xffccff);
			score3.paddingChr = "*";
			score3.align = Align.LEFT;
			_demoHelper.locateDobj(score3.displayObject, 160, 100);
			if(!hideInfoText) _demoHelper.locateDobj(
				_demoHelper.createSpriteText("ヒダリよせ・*うめ", font.name, 200, 100, 0, 0x999999), 20, 100);

			// 数字以外を含む
			var time:FixedLayoutBitmapTextController
				= createBitmapFontTextField(font.name, "00:00", 0xcccccc);
			_demoHelper.locateDobj(time.displayObject, 160, 125);
			if(!hideInfoText) _demoHelper.locateDobj(
				_demoHelper.createSpriteText("スウジいがいをふくむ", font.name, 200, 100, 0, 0x999999), 20, 125);

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
				createBitmapFontTextField(font.name,
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

			_demoHelper.locateDobj(messageBox.displayObject, 20, 175);
			if(!hideInfoText) _demoHelper.locateDobj(
				_demoHelper.createSpriteText("メッセージボックス", font.name, 200, 100, 0, 0x999999), 20, 150);

			var count:int = 0;
			addEventListener(Event.ENTER_FRAME, function(ev:*):void{
				count = (count + 1) % 100000000;
				var text:String = (""  + count);
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
