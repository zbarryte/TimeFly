package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;

	public class TimeArrow extends FlxBasic
	{
		private const kFastRate:uint = 2.0;
		private const kNormalRate:uint = 1.0;
		private const kSlowRate:uint = 0.5;
		
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
		 * Returns the rate of time.
		 */
		public function get rate():uint {
			return _rate;
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
		 * Returns true if time is normal rate
		 */
		public function isNormal():Boolean {
			return _rate == kNormalRate;
		}
		
		/**
		 * Returns true if time is fast rate
		 */
		public function isFast():Boolean {
			return _rate == kFastRate;
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
		 * Sets rate to fast rate.
		 */
		public function makeFast():void {
			_rate = kFastRate; 
		}
		
		/**
		 * Sets rate to normal rate.
		 */
		public function makeNormal():void {
			_rate = kNormalRate;
		}
		
		/**
		 * Sets the rate slow rate.
		 */
		public function makeSlow():void {
			_rate = kSlowRate;
		}
		
		public function goFastForward():void {
			makeFast();
			goForward();
		}
		
		public function goFastBackward():void {
			makeFast();
			goBackward();
		}
		
		public function goNormalForward():void {
			makeNormal();
			goForward();
		}
		
		public function goNormalBackward():void {
			makeNormal();
			goBackward();
		}
		
		public function goSlowForward():void {
			makeSlow();
			goForward();
		}
		
		public function goSlowBackward():void {
			makeSlow();
			goBackward();
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
			var tmpElapsed:Number = (isForward()) ? FlxG.elapsed : -FlxG.elapsed;
			_counter += tmpElapsed*_rate;
			_frame = Math.floor(_counter*60);
			
			//FlxG.log(_frame);
			
			super.update();
		}
	}
}