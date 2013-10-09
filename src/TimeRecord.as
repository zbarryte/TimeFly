package
{
	import flash.utils.Dictionary;

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
		public function addEventAtFrame(event_:Function,frame_:int):void {
			if (!record) {return;}
			
			var tmpEncapsulatedEvent:Function = function():void {
				event_();
			}
			
			record[frame_] = tmpEncapsulatedEvent;
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