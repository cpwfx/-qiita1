package demos {
	import harayoki.starling.BitmapFontUtil;

	import misc.MyFontManager;

	import starling.core.Starling;
	import starling.text.BitmapFont;
	import starling.utils.AssetManager;
	
	public class MapChipTestDemo extends DemoBase {

		public function MapChipTestDemo(assetManager:AssetManager, starling:Starling=null) {
			super(assetManager, starling);
		}

		public override function addAssets(assets:Array):void {
			assets.push('app:/assets/maptip.xml');
			assets.push('app:/assets/colorbars.xml');
		}

		public override function start():void {

			var mapall:String = [
				"ABCDEFGHIJKLMNOP",
				"",
				"01",
			].join("\n");

			var font:BitmapFont = MyFontManager.mapchipFont;
			var subFont:BitmapFont = MyFontManager.subFont;

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
					font.name,
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
					font.name,
					300,
					600
				), 10, 110, 1);
		}

	}
}
