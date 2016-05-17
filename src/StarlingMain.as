package {
	import flash.display.Stage;
	import flash.display3D.Context3DFillMode;
	import flash.geom.Rectangle;
	import flash.system.System;

	import harayoki.starling.BitmapFontUtil;
	import harayoki.starling.FixedLayoutBitmapTextController;
	import harayoki.starling.display.Triangle;
	import harayoki.util.CharCodeUtil;

	import misc.DemoHelper;
	import misc.ViewportUtil;

	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Canvas;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Mesh;
	import starling.display.MeshBatch;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.rendering.IndexData;
	import starling.rendering.VertexData;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
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

		private var _demoHelper:DemoHelper;
		private var _assetManager:AssetManager;
		public function StarlingMain() {

			ViewportUtil.setupViewPort(Starling.current, CONTENTS_SIZE, true);

			_demoHelper = new DemoHelper(Starling.current, this, true);
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

		private function _scoreTest():void {

			var score:FixedLayoutBitmapTextController
				= FixedLayoutBitmapTextController.getInstance(FONT_NAME_MONO, "00000000");
			score.paddingChr = "0";
			score.align = Align.RIGHT;
			_demoHelper.locateDobj(score.displayObject, 100, 0);

			var count:int = 0;
			addEventListener(Event.ENTER_FRAME, function (ev:*) {
				count++;
				score.setTextWithPadding(count + "");
			});
		}

		private function _mapTest():void {

			var subFont:BitmapFont = TextField.getBitmapFont(FONT_NAME_ALPHABET);

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

			_demoHelper.locateDobj(
				_demoHelper.createSpriteText(
					mapall,
					mapchip.name,
					300,
					100
				), 10, 40, 1);

			var tempFont:BitmapFont = BitmapFontUtil.cloneBitmapFontAsMonoSpaceFont("tempFont", subFont, 16);
			BitmapFontUtil.setSpaceWidth(tempFont, 16);
			_demoHelper.locateDobj(
				_demoHelper.createSpriteText(
					mapall,
					tempFont.name,
					300,
					100,
					14
				), 10, 40 + 16, 1);


			_demoHelper.locateDobj(
				_demoHelper.createSpriteText(
					map,
					mapchip.name,
					300,
					600
				), 10, 110, 1);		}


		private function _meshTest():void {
			// mesh test

			var meshbatch:MeshBatch = new MeshBatch();
			var tempImage:Image = new Image(_assetManager.getTexture("oukan"));
			tempImage.x = 0;
			tempImage.y = 0;
			meshbatch.addMesh(tempImage);
			tempImage.x = 15;
			tempImage.y = 5;
			meshbatch.addMesh(tempImage);
			tempImage.x = 30;
			tempImage.y = 10;
			meshbatch.addMesh(tempImage);
			meshbatch.x = 190;
			meshbatch.y = 75;
			addChild(meshbatch);

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

		private function _triTest1():void {

			var white:Texture = _assetManager.getTexture("mx/F"); // colorchip white
			var pict1:Texture = _assetManager.getTexture("pict1");
			// var yohakuTofu:Texture = new SubTexture(tofu, null,false, new flash.geom.Rectangle(-2,-2,16,16));

			var tr1:Triangle = new Triangle(30, 30);
			tr1.x = 80;
			tr1.y = 100;
			tr1.textureSmoothing = TextureSmoothing.NONE;
			tr1.texture = white;
			tr1.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent){
				if(ev.getTouch(tr1, TouchPhase.BEGAN)) {
					trace("touched! tr1");
				}
			});

			var tr2:Triangle = new Triangle(10, 10, 0xffff00);
			tr2.x = 130;
			tr2.y = 100;
			tr2.rotation = -Math.PI * 0.2;
			tr2.textureSmoothing = TextureSmoothing.NONE;
			tr2.texture = white;
			tr2.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent){
				if(ev.getTouch(tr2, TouchPhase.BEGAN)) {
					trace("touched! tr2");
				}
			});

			var tr3:Triangle = Triangle.fromTexture(pict1);
			tr3.x = 170;
			tr3.y = 100;
			tr3.color = 0xffffff;
			tr3.textureSmoothing = TextureSmoothing.NONE;
			tr3.addEventListener(TouchEvent.TOUCH, function(ev:TouchEvent){
				if(ev.getTouch(tr3, TouchPhase.BEGAN)) {
					trace("touched! tr3");
				}
			});

			addChild(tr1);
			addChild(tr2);
			addChild(tr3);

			return;

			var bound1:Quad = Quad.fromTexture(white);
			var bound2:Quad = Quad.fromTexture(white);
			var bound3:Quad = Quad.fromTexture(white);

			bound1.alpha = 0.1;
			bound2.alpha = 0.1;
			bound3.alpha = 0.1;

			bound1.textureSmoothing = TextureSmoothing.NONE;
			bound2.textureSmoothing = TextureSmoothing.NONE;
			bound3.textureSmoothing = TextureSmoothing.NONE;

			addChild(bound1);
			addChild(bound2);
			addChild(bound3);

			_demoHelper.fitToBound(tr1, bound1);
			_demoHelper.fitToBound(tr2, bound2);
			_demoHelper.fitToBound(tr3, bound3);

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
			BitmapFontUtil.updatePadding(paddingAlphabetFont, 10, 0, 20, CharCodeUtil.getIdListByCharRange("B", "D"));

			// カラーチップフォント
			var colorTipFont1:BitmapFont =
				BitmapFontUtil.createBitmapFontFromTextureAtlas("colorchip", _assetManager, "mx/", 2);

			// BitmapFontUtil.traceBitmapCharInfo(mapchip);

			var bgTexure:Texture = _assetManager.getTexture("mx/9");
			// タッチ時にGCしてみる
			var gcobj:DisplayObject = _demoHelper.createSpriteText("[TOUCH_TO_GC]", baseFont.name, 200, 20, 0, 0xffffff);
			_demoHelper.createButton(gcobj, function():void{
				trace("gc!");
				System.gc();
			},10, 440, bgTexure);

			// タッチ時にワイヤーフレームにしてみる
			var isWireframe:Boolean = false;
			var wfobj:DisplayObject = _demoHelper.createSpriteText("[TOGGLE_WIREFRAME]", baseFont.name, 200, 20, 0, 0xffffff);
			_demoHelper.createButton(wfobj, function():void{
				isWireframe = !isWireframe;
				if (isWireframe) {
					Starling.current.context.setFillMode(Context3DFillMode.WIREFRAME);
				} else {
					Starling.current.context.setFillMode(Context3DFillMode.SOLID);
				}
			}, 10, 455, bgTexure);

			_triTest1();
		}

	}
}