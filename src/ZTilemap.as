package
{
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ZTilemap extends FlxTilemap
	{
		public function ZTilemap()
		{
			super();
		}
		
		public function loadMapWithSize(tmpWidthInTiles:uint,tmpHeightInTiles:uint,tmpTileGraphic:Class,tmpTileWidth:uint,tmpTileHeight:uint):void {
			
			var tmpData:Array = new Array();
			for (var i:uint = 0; i < tmpWidthInTiles*tmpHeightInTiles; i++) {
				tmpData.push(0);
			}
			
			var tmpCSV:String = FlxTilemap.arrayToCSV(tmpData,tmpWidthInTiles,true);
			
			loadMap(tmpCSV,tmpTileGraphic,tmpTileWidth,tmpTileHeight);
		}
		
		public function setTileIndexAtScreenXY(tmpX:Number,tmpY:Number,tmpNew:uint):void {
			var tmpTileIndex:uint = getIndexForScreenXY(tmpX,tmpY);
			Glob.log(tmpTileIndex);
			setTileByIndex(tmpTileIndex,tmpNew);
		}
		
		private function getIndexForScreenXY(tmpX:uint,tmpY:uint):uint {
			tmpX -= x;
			tmpY -= y;
			
			var tmpCol:uint = widthInTiles * Number(tmpX/width);
			var tmpRow:uint = heightInTiles * Number(tmpY/height);
			
			return (tmpRow*widthInTiles) + tmpCol;
		}
		
		public function placeBelowSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x;
			y = tmpSpr.y + tmpSpr.height + tmpMargin;
		}
		
		public function placeAboveSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x;
			y = tmpSpr.y - height - tmpMargin;
		}
		
		public function placeRightOfSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x + tmpSpr.width + tmpMargin;
			y = tmpSpr.y;
		}
		
		public function placeLeftOfSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x - width - tmpMargin;
			y = tmpSpr.y;
		}
		
		public function placeAtScreenXPercentage(tmpPercentage:Number):void {
			x = FlxG.width*tmpPercentage - width/2.0;
		}
		
		public function placeAtScreenYPercentage(tmpPercentage:Number):void {
			y = FlxG.height*tmpPercentage - height/2.0;
		}
		
		public function centerX():void {
			placeAtScreenXPercentage(0.5);
		}
		
		public function centerY():void {
			placeAtScreenYPercentage(0.5);
		}
		
		public function centerXY():void {
			centerX();
			centerY();
		}
		
		public function placeFarLeft():void {
			x = 0;
		}
		
		public function placeFarRight():void {
			x = FlxG.width - width;
		}
		
		public function placeFarTop():void {
			y = 0;
		}
		
		public function placeFarBottom():void {
			y = FlxG.height - height;
		}
	}
}