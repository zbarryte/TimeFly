package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;

	public class SldrLoad extends ZSlider
	{
		private const kMoveDist:uint = 2;
		
		private var minute:ZNode;
		private var hour:ZNode;
		
		public function SldrLoad(tmpX:Number, tmpY:Number)
		{
			var tmpMarker:ZNode = new ZNode();
			tmpMarker.loadGraphic(GSpritinator.kSliderMarker);
			
			var tmpClockFace:ZNode = new ZNode();
			tmpClockFace.loadGraphic(GSpritinator.kSliderMarkerClockFace);
			tmpMarker.add(tmpClockFace);
			tmpClockFace.xLocal = tmpMarker.width/2.0 - tmpClockFace.width/2.0;
			
			hour = new ZNode();
			hour.loadGraphic(GSpritinator.kSliderMarkerClockHour);
			tmpClockFace.add(hour);
			
			minute = new ZNode();
			minute.loadGraphic(GSpritinator.kSliderMarkerClockMinute);
			tmpClockFace.add(minute);
			
			var tmpSetLinkedValue:Function = function(tmpUint:uint):void {
				GLeveler.num = tmpUint;
			};
			var tmpLinkedValueMax:uint = GLeveler.numMax;
			
			super(tmpX,tmpY,tmpSetLinkedValue,tmpLinkedValueMax,GSpritinator.kSliderBar, tmpMarker);
		}
		
		override public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			super.placeMarkerAtPoint(tmpPoint);
			adjustClockHands();
		}
		
		override public function snapMarker():void {
			super.snapMarker();
			adjustClockHands();
		}
		
		private function adjustClockHands():void {
			minute.angleLocal = percentageToCompletion * 360 * 24;
			hour.angleLocal = percentageToCompletion * 360 * 2;
		}
	}
}