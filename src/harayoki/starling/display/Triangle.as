// =================================================================================================
//
//	Starling Framework
//	Copyright Gamua GmbH. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package harayoki.starling.display
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import starling.display.Mesh;
	import starling.rendering.IndexData;
	import starling.rendering.VertexData;
	import starling.styles.MeshStyle;
	import starling.textures.Texture;

	public class Triangle extends Mesh {
		private var _bounds:Rectangle;

		// helper objects
		//private static var sPoint3D:Vector3D = new Vector3D();
		private static var sMatrix:Matrix = new Matrix();
		//private static var sMatrix3D:Matrix3D = new Matrix3D();
		private static var sRectangle:Rectangle = new Rectangle();

		public function Triangle(width:Number, height:Number, color:uint = 0xffffff) {
			_bounds = new Rectangle(0, 0, width, height);

			var vertexData:VertexData = new VertexData(MeshStyle.VERTEX_FORMAT, 3);
			var indexData:IndexData = new IndexData(3);

			super(vertexData, indexData);

			if (width == 0.0 || height == 0.0)
				throw new ArgumentError("Invalid size: size must not be zero");

			setupVertices();
			this.color = color;
		}

		protected function setupVertices():void {
			var posAttr:String = "position";
			var texAttr:String = "texCoords";
			var texture:Texture = style.texture;
			var vertexData:VertexData = this.vertexData;
			var indexData:IndexData = this.indexData;

			indexData.numIndices = 0;
			indexData.addTriangle(0, 1, 2);
			vertexData.numVertices = 3;
			vertexData.trim();

			if (texture) {
				_setupVertexPositions(texture, vertexData, 0, "position", _bounds);
				_setupTextureCoordinates(texture, vertexData, 0, texAttr);
			}
			else {
				vertexData.setPoint(0, posAttr, _bounds.left, _bounds.top);
				vertexData.setPoint(1, posAttr, _bounds.right, _bounds.top);
				vertexData.setPoint(2, posAttr, _bounds.left, _bounds.bottom);

				vertexData.setPoint(0, texAttr, 0.0, 0.0);
				vertexData.setPoint(1, texAttr, 1.0, 0.0);
				vertexData.setPoint(2, texAttr, 0.0, 1.0);
			}

			setRequiresRedraw();
		}

		private function _setupVertexPositions(texture:Texture, vertexData:VertexData, vertexID:int=0,
			attrName:String="position",
			bounds:Rectangle=null):void
		{
			var frame:Rectangle = texture.frame;
			var width:Number    = texture.width;
			var height:Number   = texture.height;

			if (frame)
				sRectangle.setTo(-frame.x, -frame.y, width, height);
			else
				sRectangle.setTo(0, 0, width, height);

			vertexData.setPoint(vertexID,     attrName, sRectangle.left,  sRectangle.top);
			vertexData.setPoint(vertexID + 1, attrName, sRectangle.right, sRectangle.top);
			vertexData.setPoint(vertexID + 2, attrName, sRectangle.left,  sRectangle.bottom);

			if (bounds)
			{
				var scaleX:Number = bounds.width  / texture.frameWidth;
				var scaleY:Number = bounds.height / texture.frameHeight;

				if (scaleX != 1.0 || scaleY != 1.0 || bounds.x != 0 || bounds.y != 0)
				{
					sMatrix.identity();
					sMatrix.scale(scaleX, scaleY);
					sMatrix.translate(bounds.x, bounds.y);
					vertexData.transformPoints(attrName, sMatrix, vertexID, 3);
				}
			}
		}

		private function _setupTextureCoordinates(
			texture:Texture, vertexData:VertexData, vertexID:int=0, attrName:String="texCoords"):void
		{
			texture.setTexCoords(vertexData, vertexID    , attrName, 0.0, 0.0);
			texture.setTexCoords(vertexData, vertexID + 1, attrName, 1.0, 0.0);
			texture.setTexCoords(vertexData, vertexID + 2, attrName, 0.0, 1.0);
		}

		//public override function getBounds(targetSpace:DisplayObject, out:Rectangle = null):Rectangle {
		//	return super.getBounds(targetSpace, out);
		//}

		//override public function hitTest(localPoint:Point):DisplayObject
		//{
		//	return super.hitTest(localPoint);
		//}

		public function readjustSize(width:Number=-1, height:Number=-1):void
		{
			if (width  <= 0) width  = texture ? texture.frameWidth  : _bounds.width;
			if (height <= 0) height = texture ? texture.frameHeight : _bounds.height;

			if (width != _bounds.width || height != _bounds.height)
			{
				_bounds.setTo(0, 0, width, height);
				setupVertices();
			}
		}

		public static function fromTexture(texture:Texture):Triangle
		{
			var triangle:Triangle = new Triangle(100, 100);
			triangle.texture = texture;
			triangle.readjustSize();
			return triangle;
		}

		override public function set texture(value:Texture):void
		{
			if (value != texture)
			{
				super.texture = value;
				setupVertices();
			}
		}
	}
}