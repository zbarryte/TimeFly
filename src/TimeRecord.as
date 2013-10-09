package
{
	import flash.utils.Dictionary;
	import org.flixel.FlxG;

	public class TimeRecord
	{
		/**
		 * Stores events for time frames
		 */
		protected var record:Dictionary;
		
		/**
		 * Records the events at time frames.
		 */
		public function TimeRecord()
		{
			record = new Dictionary();
		}
		
		/**
		 * Add an event to be fired for a time frame.
		 */
		public function addEventAtFrame(tmpEvent:Function,tmpFrame:int):void {
			if (!record) {return;}
			record[tmpFrame] = tmpEvent;
		}
		
		/**
		 * Fire a recorded event, given a time frame
		 */
		public function runEventOfFrame(frame_:int):void {
			if (!record || !record[frame_]) {return;}
			
			var event_:Function = record[frame_];
			event_();
		}
	}
}