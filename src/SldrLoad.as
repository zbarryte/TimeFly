package
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxGroup;

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
			tmpClockFace.x = tmpMarker.width/2.0 - tmpClockFace.width/2.0;
			
			hour = new ZNode();
			hour.loadGraphic(GSpritinator.kSliderMarkerClockHour);
			tmpClockFace.add(hour);
			
			minute = new ZNode();
			minute.loadGraphic(GSpritinator.kSliderMarkerClockMinute);
			tmpClockFace.add(minute);
			
			super(tmpX, tmpY, GSpritinator.kSliderBar, tmpMarker);
			
			addTicks();
		}
		
		override protected function addTicks():void {
			//_tickGroup = new FlxGroup();
			for (var i:uint = 0; i <= GLeveler.numMax; i++) {
				var tmpTick:ZNode = new ZNode();
				tmpTick.loadGraphic(GSpritinator.kSliderTick);
				tmpTick.x = (width - _marker.width)*(i/GLeveler.numMax) + _marker.width/2.0 - tmpTick.width/2.0;
				//_tickGroup.add(tmpTick);
				tmpTick.y = height/2.0 - tmpTick.height/2.0;
				add(tmpTick);
			}
		}
		
		override public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			super.placeMarkerAtPoint(tmpPoint);
			updateMarkerProperties();
			updateStuffBasedOnMarkerPosition();
		}
		
		private function updateMarkerProperties():void {
			// some stuff here about the clock on top
			adjustClockHands();
		}
		
		private function updateStuffBasedOnMarkerPosition():void {
			GLeveler.num = int((_marker.x/width)*GLeveler.numMax + 1);
		}
		
		public function snapMarker():void {
			_marker.x = (width - _marker.width)*(GLeveler.num/GLeveler.numMax);
			//Glob.log(percentageToCompletion);
			adjustClockHands();
		}
		
		public function goForward():void {
			GLeveler.num ++;
			/*
			var tmpPoint:FlxPoint = new FlxPoint(_marker.xScreen + kMoveDist,_marker.yScreen);
			placeMarkerAtPoint(tmpPoint);
			*/
		}
		
		public function goBackward():void {
			GLeveler.num --;
			/*
			var tmpPoint:FlxPoint = new FlxPoint(_marker.xScreen - kMoveDist,_marker.yScreen);
			placeMarkerAtPoint(tmpPoint);
			*/
		}
		
		private function adjustClockHands():void {
			minute.angle = percentageToCompletion * 360 * 24;
			hour.angle = percentageToCompletion * 360 * 2;
		}
	}
}