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
			
			//addTicks();
		}
		
		/*override protected*//* private function addTicks():void {
			//_tickGroup = new FlxGroup();
			for (var i:uint = 0; i <= GLeveler.numMax; i++) {
				var tmpTick:ZNode = new ZNode();
				tmpTick.loadGraphic(GSpritinator.kSliderTick);
				tmpTick.xLocal = (width - _marker.width)*(i/GLeveler.numMax) + _marker.width/2.0 - tmpTick.width/2.0;
				//_tickGroup.add(tmpTick);
				tmpTick.yLocal = height/2.0 - tmpTick.height/2.0;
				add(tmpTick);
			}
		}*/
		
		override public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			super.placeMarkerAtPoint(tmpPoint);
			//updateMarkerProperties();
			adjustClockHands();
			//updateStuffBasedOnMarkerPosition();
		}
		
		/*
		private function updateMarkerProperties():void {
			adjustClockHands();
		}
		*/
		
		/*
		//private function updateStuffBasedOnMarkerPosition():void {
		override protected function updateLinkedValue():void {
			GLeveler.num = percentageToCompletion*(GLeveler.numMax+1);//int((_marker.xLocal/width)*GLeveler.numMax + 1);
		}*/
		
		override public function snapMarker():void {
			super.snapMarker();//_marker.xLocal = (width - _marker.width)*(GLeveler.num/GLeveler.numMax);
			adjustClockHands();
		}
		
		/*
		public function goForward():void {
			GLeveler.num ++;
		}
		
		public function goBackward():void {
			GLeveler.num --;
		}
		*/
		
		private function adjustClockHands():void {
			minute.angle = percentageToCompletion * 360 * 24;
			hour.angle = percentageToCompletion * 360 * 2;
		}
	}
}