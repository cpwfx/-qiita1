package lazytest {
	import harayoki.starling2.MovieClipWithLabel;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class MovieClipWithLabelTest extends Sprite {
		public function MovieClipWithLabelTest(fontName:String) {

			var getLabelName:Function = function(i:int):String {
				return "label" + i;
			};

			var mc:MovieClipWithLabel = new MovieClipWithLabel(64, 64);
			mc.textureSmoothing = TextureSmoothing.NONE;
			var font:BitmapFont = TextField.getBitmapFont(fontName);
			for(var i:int=0; i< 10 ; i++) {
				var char:BitmapChar = font.getChar((i+'').charCodeAt(0));
				mc.addLabel(getLabelName(i), new <Texture>[char.texture])
			}
			addChild(mc);

			var cnt:uint = 0;
			addEventListener(Event.ENTER_FRAME, function(ev:Event) {
				cnt++;
				var labelName:String = getLabelName(Math.floor(cnt / 60) % 10);
				if(mc.hasLabel(labelName)) {
					mc.gotoAndStop(labelName);
				}
			});

		}
	}
}
