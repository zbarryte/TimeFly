package
{
	public class SprWall extends ZNode
	{
		public function SprWall(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{	
			super(tmpX, tmpY,GSpritinator.kWall);
			width = GLeveler.kTileWidth;
			height = GLeveler.kTileHeight;
			immovable = true;
		}
	}
}