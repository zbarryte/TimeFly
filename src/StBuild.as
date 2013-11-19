package
{
	import org.flixel.FlxPoint;
	
	public class StBuild extends ZState
	{
		private var buildArea:ZTilemap;
		//private var tileIndex:uint = 3;
		private var tileSelector:SprTileSelector;
		private var tilePalette:SprTilePalette;
		
		public function StBuild()
		{
		}
		
		override protected function createScene():void {
			addBuildArea();
			addToolsPanel();
		}
		
		private function addToolsPanel():void {
			var tmpToolsPanel:ZNode = new ZNode();
			tmpToolsPanel.loadGraphic(GSpritinator.kToolsPanel);
			add(tmpToolsPanel);
			
			tileSelector = new SprTileSelector();
			add(tileSelector);
			tileSelector.frame = 2;
			
			tilePalette = new SprTilePalette();
			add(tilePalette);
			hideTilePalette();
		}
		
		private function addBuildArea():void {
			buildArea = new ZTilemap();
			var tmpWidth:uint = 28;
			var tmpHeight:uint = 16;
			buildArea.loadMapWithSize(tmpWidth,tmpHeight,GLeveler.kTilesFunc,GLeveler.kTileWidth,GLeveler.kTileHeight);
			add(buildArea);
			//buildArea.x = 10;
			//buildArea.y = 22;
			buildArea.centerXY();
		}
		
		override protected function updateControls():void {
			if (Glob.kController.justPressed(GController.kBack)) {
				switchState(StTitle);
			}
			
			
			/*
			var tmpPoint:FlxPoint = Glob.kController.clickPoint();
			if (Glob.kController.mouseOver(buildArea)) {
				buildArea.setTileIndexAtScreenXY(tmpPoint.x,tmpPoint.y,tileIndex);
			}
			else {
				buildArea.setTileIndexAtScreenXY(tmpPoint.x,tmpPoint.y,1);
			}
			*/
			if (Glob.kController.justPressedLeftClick()) {
				
				if (Glob.kController.mouseOver(buildArea)) {	
					drawTileAtClick();
				}
				if (isTilePaletteHidden() && Glob.kController.mouseOver(tileSelector)) {
					showTilePalette();
				}
				else if (!isTilePaletteHidden()) {
					hideTilePalette();
					if (Glob.kController.mouseOver(tilePalette)) {
						tileSelector.frame = tilePalette.frameForPoint(Glob.kController.clickPoint());
					}
				}
				/*
				else if (tileSelector.isPaletteHidden() && Glob.kController.mouseOver(tileSelector)) {
					tileSelector.showPalette();
				}
				else if (!tileSelector.isPaletteHidden()) {
					// also should be over the palette, put the selected palette tile into the tile selector
				}
				*/
			}
		}
		
		private function drawTileAtClick():void {
			var tmpClick:FlxPoint = Glob.kController.clickPoint();
			buildArea.setTileIndexAtScreenXY(tmpClick.x,tmpClick.y,tileSelector.frame);
		}
		
		private function hideTilePalette():void {
			tilePalette.visible = false;
		}
		
		private function showTilePalette():void {
			tilePalette.visible = true;
		}
		
		private function isTilePaletteHidden():Boolean {
			return !tilePalette.visible;
		}
	}
}