package harayoki.feathers.themes
{
	import feathers.themes.*;

	import starling.core.Starling;
	import starling.textures.TextureAtlas;

	public class CustomMinimalTheme extends BaseCustomMinimalTheme implements IAsyncTheme
	{

		public function CustomMinimalTheme(atlas:TextureAtlas, fontName:String="_sans")
		{
			super(fontName);
			this.atlas = atlas;
			initialize();
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
