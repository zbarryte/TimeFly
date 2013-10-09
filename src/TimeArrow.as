package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;

	public class TimeArrow extends FlxBasic
	{
		/**
		 * Forward.
		 */
		public static const kForward:Boolean = true;
		
		/**
		 * Backward. 
		 */
		public static const kBackward:Boolean = false;
		
		/**
		 * The direction time is moving. 
		 */
		protected var _direction:Boolean;
		
		/**
		 * Counts time precisely.
		 */
		protected var _counter:Number;
		
		/**
		 * Counts only the int frame of time.
		 */
		protected var _frame:int;
		
		/**
		 * How quickly time travels (in seconds/second)
		 */
		protected var _rate:uint;
		
		/**
		 * Tracks the time direction and current frame of time.
		 */
		public function TimeArrow()
		{
			reset();
		}
		
		/**
		 * Resets vars
		 */
		public function reset():void {
			_direction = kForward;
			_counter = 0;
			_frame = 0;
		}
		
		/**
		 * Returns true if time is forward, false otherwise.
		 */
		public function isForward():Boolean {
			return _direction == kForward;
		}
		
		/**
		 * Returns true if time is backwards, false otherwise.
		 */
		public function isBackward():Boolean {
			return _direction == kBackward;
		}
		
		/**
		 * Reverses the direction of time.
		 */
		public function reverse():void {
			_direction = !_direction;
		}
		
		/**
		 * Sets time forward.
		 */
		public function goForward():void {
			_direction = kForward;
		}
		
		/**
		 * Sets time backward.
		 */
		public function goBackward():void {
			_direction = kBackward;
		}
		
		/**
		 * The current frame of time.
		 */
		public function get frame():int {
			return _frame;
		}
		
		/**
		 * Updates the frame of time. 
		 */
		override public function update():void {
			_counter += (isForward()) ? FlxG.elapsed : -FlxG.elapsed;
			_frame = Math.floor(_counter*60);
			FlxG.log(_frame);
			
			super.update();
		}
	}
}