package
{
	import org.flixel.FlxPoint;
	
	public class SprTilePalette extends ZNode
	{
		private var widthInTiles:uint;
		private var heightInTiles:uint;
		
		public function SprTilePalette(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{
			super(tmpX, tmpY, GSpritinator.kTilePalette);
			
			widthInTiles = 4;
			heightInTiles = 2;
		}
		
		public function frameForPoint(tmpPoint:FlxPoint):uint {
			
			var tmpX:Number = tmpPoint.x;
			var tmpY:Number = tmpPoint.y;
			
			tmpX -= x;
			tmpY -= y;
			
			var tmpCol:uint = widthInTiles * Number(tmpX/width);
			var tmpRow:uint = heightInTiles * Number(tmpY/height);
			
			return (tmpRow*widthInTiles) + tmpCol;
		}
	}
}