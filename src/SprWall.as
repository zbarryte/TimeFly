package
{
	public class SprWall extends ZNode
	{
		public function SprWall(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{	
			super(tmpX, tmpY);
			width = LevelsStore.kTileWidth;
			height = LevelsStore.kTileHeight;
			immovable = true;
		}
	}
}