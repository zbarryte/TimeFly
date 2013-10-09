package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{
		protected var _timeArrow:TimeArrow;
		protected var _timeRecord:TimeRecord;
		protected var _canRecord:Boolean;
		
		public function ZNode(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			_timeArrow = Glob.timeArrow;
			_timeRecord = new TimeRecord();
			enableRecording();
		}
		
		override public function update():void {
			super.update();
			updateLocation();
			updateVideo();
			if (_timeArrow) {
				runEvents();
				if (_canRecord) {recordEvents();}
			}
		}
		
		protected function runEvents():void {
			_timeRecord.runEventOfFrame(_timeArrow.frame);
		}
		
		
		protected function recordEvents():void {
			FlxG.log(":: recordEvents() :: not yet implemented by " + this);
		}
		
		protected function updateLocation():void {
			FlxG.log(":: updateLocation() :: not yet implemented by " + this);
		}
		
		protected function updateVideo():void {
			FlxG.log(":: updateVideo() :: not yet implemented by " + this);
		}
		
		public function enableRecording():void {
			_canRecord = true;
		}
		
		public function disableRecording():void {
			_canRecord = false;
		}
	}
}