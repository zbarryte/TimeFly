package
{
	import org.flixel.FlxG;
	
	public class ZNodeTime extends ZNode
	{
		protected var _timeArrow:TimeArrow;
		protected var _timeRecord:TimeRecord;
		protected var _canRecord:Boolean;
		
		protected var _frameStart:int;
		protected var _frameEnd:int;
		
		public function ZNodeTime(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			_timeArrow = Glob.timeArrow;
			_timeRecord = new TimeRecord();
			enableRecording();
			frameStart = _timeArrow.frame;
			_frameEnd = int.MAX_VALUE;
		}
		
		override public function update():void {
			super.update();
			updateRecording();
		}
		
		private function updateRecording():void {
			
			//FlxG.log("start: "+_frameStart+"  at: "+_timeArrow.frame+"  end: "+_frameEnd);
			
			if (_timeArrow && isBetweenFrames())
			{
				runEvents();
				
				if (_canRecord)
				{
					recordEvents();
				}
			}
		}
		
		public function isBetweenFrames():Boolean {
			return _frameStart <= _timeArrow.frame && _timeArrow.frame <= _frameEnd;
		}
		
		protected function runEvents():void {
			_timeRecord.runEventOfFrame(_timeArrow.frame);
		}
		
		
		protected function recordEvents():void {
			//FlxG.log(":: recordEvents() :: not yet implemented by " + this);
		}
		
		public function enableRecording():void {
			_canRecord = true;
		}
		
		public function disableRecording():void {
			_canRecord = false;
		}
		
		protected function set frameStart(tmpFrameStart:int):void {
			_frameStart = tmpFrameStart;
		}
		
		protected function set frameEnd(tmpFrameEnd:int):void {
			_frameEnd = tmpFrameEnd;
		}
		
		protected function get timeArrow():TimeArrow {
			return _timeArrow;
		}
		
		protected function get timeRecord():TimeRecord {
			return _timeRecord;
		}
	}
}