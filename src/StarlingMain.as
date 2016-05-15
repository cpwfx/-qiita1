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
	import starling.display.Canvas;
	import starling.display.DisplayObject;
	import starling.display.Mesh;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.rendering.IndexData;
	import starling.rendering.VertexData;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Align;
	import starling.utils.AssetManager;

	public class StarlingMain extends Sprite {

		private static const FONT_NAME_ALPHABET:String = "alphabet";
		private static const FONT_NAME_KANA:String = "kana_only";
		private static const FONT_NAME_MONO:String = "mono_space";
		private static const FONT_NAME_PADDING:String = "mono_padding";
		private static const FONT_NAME_COLORCHIP:String = "colorchip";
		private static const FONT_NAME_COLORCHIP2:String = "colorchip2";
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
			_assetManager.enqueueWithName('app:/assets/colorbars.xml');
			_assetManager.enqueueWithName('app:/assets/maptip.xml');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/kana_only.fnt');
			_assetManager.enqueueWithName('app:/assets/px12fontshadow/alphabet.fnt');
			_assetManager.loadQueue(function(ratio:Number):void {
			    if(ratio == 1) {
					_start();
				}
			});

		}

		private function _start():void {

			var baseFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_KANA);
			var subFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);
			
			// カナフォントに英字フォントを
			BitmapFontUtil.overWriteCopyBitmapChars(baseFont, subFont, true, baseFont.lineHeight - subFont.lineHeight + 1);
			
			// 固定幅フォントを作る
			var monoSpaceFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont(FONT_NAME_MONO, baseFont, 16);
			monoSpaceFont.lineHeight = 16;
			// 半角設定
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListForAscii());
			// 句読点も
			BitmapFontUtil.setFixedWidth(monoSpaceFont, 8, true, CharCodeUtil.getIdListByLetters("、。"));

			var paddingAlphabetFont:BitmapFont = BitmapFontUtil.cloneBitmapFont(FONT_NAME_PADDING, subFont);
			BitmapFontUtil.updatePadding(paddingAlphabetFont, 10, 0, 20, CharCodeUtil.getIdListByCharRange("B","D"));

			// カラーチップフォント
			var colorTipFont1:BitmapFont =
				BitmapFontUtil.createBitmapFontFromTextureAtlas("colorchip", _assetManager, "mx/", 2);

			// マップチップフォント
			var mapchip:BitmapFont =
				BitmapFontUtil.createBitmapFontFromTextureAtlasAsMonoSpaceFont(
					"mapchip", _assetManager, "map1/" , 16, 16, 16 );
			BitmapFontUtil.setSpaceWidth(mapchip, 16);

			var mapall:String = [
				"ABCDEFGHIJKLMNOP",
				"",
				"01",
			].join("\n");

			var map:String = [
				"CCCCIIIIIIIIAAAA",
				"CCCIIIIIIAAAAMAA",
				"CCCCIIIAAAAAAAAA",
				"CCIIIAAAAOAAAAOA",
				"CCIIIIAAAAAAAAAA",
				"CCCIIIIAAAAAAAAA",
				"CCCCCIIAAAAOAAAA",
				"CCCCCCCIIAAAAAOA",
				"CCCCCCCCCIIAAAAA",
				"CCCCCCCCCCCEGGGG",
				"CCCCCCCCCCCCLLHL",
				"CCCCCCCCCCCCLPDP",
				"JJJCCCCCCCCCLDDD",
				"BBJJCCCCCCCCLDKD",
				"BNBJJCCCCCCCLDDF",
				"BBBJJCCCCCCCPPPP",
			].join("\n");

			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					mapall,
					mapchip.name,
					300,
					100
				), 10, 40, 1);

			var tempFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont("tempFont", subFont, 16);
			BitmapFontUtil.setSpaceWidth(tempFont, 16);
			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					mapall,
					tempFont.name,
					300,
					100,
					14
				), 10, 40 + 16, 1);


			_doHelper.locateDobj(
				_doHelper.createSpriteText(
					map,
					mapchip.name,
					300,
					600
				), 10, 110, 1);

//			BitmapFontUtil.traceBitmapCharInfo(mapchip);

			var score:FixedLayoutBitmapTextController
				= FixedLayoutBitmapTextController.getInstance(monoSpaceFont.name, "00000000");
			score.paddingChr = "0";
			score.align = Align.RIGHT;
			_doHelper.locateDobj(score.displayObject, 100, 0);

			var count:int = 0;
			addEventListener(Event.ENTER_FRAME, function(ev:*){
				count++;
				score.setTextWithPadding(count + "");
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

			// mesh test

			var vertexData:VertexData = new VertexData();
			var deg60:Number = Math.PI*2/3;
			vertexData.setPoint(0, "position", 10, 0);
			vertexData.setPoint(1, "position", Math.cos(deg60)*10, Math.sin(deg60)*10);
			vertexData.setPoint(2, "position", Math.cos(-deg60)*10, Math.sin(-deg60)*10);

			var indexData:IndexData = new IndexData();
			indexData.addTriangle(0, 1, 2);

			var mesh:Mesh = new Mesh(vertexData, indexData);
			mesh.setVertexColor(0, 0xff0000);
			mesh.setVertexColor(1, 0x00ff00);
			mesh.setVertexColor(2, 0x0000ff);
			mesh.x = 100;
			mesh.y = 85;
			addChild(mesh);
			mesh.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent):void{
				if(ev.getTouch(mesh, TouchPhase.BEGAN)) {
					trace("mesh!");
					System.gc();
				}
			});

			var circle:Canvas = new Canvas();
			circle.beginFill(0xff0000, 0.5);
			circle.drawCircle(0, 0, 10);
			circle.beginFill(0x00ff00, 0.5);
			circle.drawCircle(10, 0, 10);
			circle.beginFill(0x0000ff, 0.5);
			circle.drawCircle(5, 10, 10);
			circle.x = 150;
			circle.y = 85;
			addChild(circle);

		}


	}
}