package demos {
	import starling.core.Starling;
	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Mesh;
	import starling.display.MeshBatch;
	import starling.rendering.IndexData;
	import starling.rendering.VertexData;
	import starling.utils.AssetManager;
	
	public class MeshTestDemo extends DemoBase {
		public function MeshTestDemo(assetManager:AssetManager, starling:Starling=null) {
			super(assetManager, starling);
		}

		public override function start():void {

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

	}
}
