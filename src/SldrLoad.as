package
{
	public class SldrLoad extends ZSlider
	{
		public function SldrLoad(tmpX:Number, tmpY:Number)
		{
			var tmpMarker:ZNode = new ZNode();
			tmpMarker.loadGraphic(GSpritinator.kSliderMarker);
			
			super(tmpX, tmpY, GSpritinator.kSliderBar, tmpMarker);
		}
		
		override public function repositionMarker():void {
			super.repositionMarker();
			// some stuff
		}
	}
}