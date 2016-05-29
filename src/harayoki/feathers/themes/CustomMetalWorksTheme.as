package harayoki.feathers.themes
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class CustomMetalWorksTheme extends BaseCustomMetalWorksMobileTheme
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

		protected override function initializeStage():void {
			// do nothing
		}

	}
}
