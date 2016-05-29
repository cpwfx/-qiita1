package harayoki.feathers.themes
{
	import feathers.themes.*;

	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class CustomMetalWorksTheme extends BaseCustomMetalWorksMobileTheme implements IAsyncTheme
	{

		public function CustomMetalWorksTheme(atlas:TextureAtlas, fontName:String="_sans")
		{
			super(fontName);
			this.atlas = atlas;
			initialize();
		}

		public function set dummyTexture(texture:Texture):void {
			BaseCustomMetalWorksMobileTheme.dummyTexture = texture;
		}

		public function get dummyTexture():Texture {
			return BaseCustomMetalWorksMobileTheme.dummyTexture;
		}

		public function isCompleteForStarling(starling:Starling):Boolean
		{
			return true;
		}

		protected override function initializeStage():void {
			// do nothing
		}

	}
}
