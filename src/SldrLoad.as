package
{
	import org.flixel.FlxPoint;

	public class SldrLoad extends ZSlider
	{
		public function SldrLoad(tmpX:Number, tmpY:Number)
		{
			var tmpMarker:ZNode = new ZNode();
			tmpMarker.loadGraphic(GSpritinator.kSliderMarker);
			
			super(tmpX, tmpY, GSpritinator.kSliderBar, tmpMarker);
		}
		
		/*
		override public function repositionMarker():void {
			super.repositionMarker();
			// some stuff
		}*/
		
		override public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			super.placeMarkerAtPoint(tmpPoint);
			updateMarkerProperties();
			updateStuffBasedOnMarkerPosition();
		}
		
		private function updateMarkerProperties():void {
			// some stuff here about the clock on top
		}
		
		private function updateStuffBasedOnMarkerPosition():void {
			GLeveler.num = int((_marker.x/width)*GLeveler.numMax + 1);
			//Glob.log(GLeveler.num);
		}
		
		public function snapMarker():void {
			_marker.x = width*(GLeveler.num/GLeveler.numMax)
		}
		
		public function goForward():void {
			//Glob.log("goForward :: not yet implemented");
			GLeveler.num ++;
		}
		
		public function goBackward():void {
			GLeveler.num --;
			//Glob.log("goBackward :: not yet implemented");
		}
	}
}