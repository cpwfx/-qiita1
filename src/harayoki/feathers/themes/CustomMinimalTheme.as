package harayoki.feathers.themes
{
	import starling.textures.TextureAtlas;

	public class CustomMinimalTheme extends BaseCustomMinimalTheme
	{

		public function CustomMinimalTheme(atlas:TextureAtlas, fontName:String="_sans")
		{
			super(fontName);
			this.atlas = atlas;
			initialize();
		}

		protected override function initializeStage():void {
			// do nothing
		}

	}
}
