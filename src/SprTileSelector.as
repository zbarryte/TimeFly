package
{
	public class SprTileSelector extends ZNode
	{			
		public function SprTileSelector(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX, tmpY);
			loadGraphic(GSpritinator.kTilePalette,true,false,32,32);
		}
		
		/*
		private function addPalette():void {
			palette = new ZNode();
			palette.loadGraphic(GSpritinator.kTilePalette);
			add(palette);
			hidePalette();
		}
		
		public function showPalette():void {
			palette.visible = true;
		}
		
		public function hidePalette():void {
			palette.visible = false;
		}
		
		public function isPaletteHidden():Boolean {
			return !palette.visible;
		}
		*/
	}
}