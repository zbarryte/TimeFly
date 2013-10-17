package
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	public class SprCrusher extends ZNodeTime
	{
		public static const kUp:FlxPoint = new FlxPoint(0.0,-1.0);
		public static const kDown:FlxPoint = new FlxPoint(0.0,1.0);
		public static const kLeft:FlxPoint = new FlxPoint(-1.0,0.0);
		public static const kRight:FlxPoint = new FlxPoint(1.0,0.0);
		
		private const kRate:Number = 32;
		protected var _direction:FlxPoint;
		
		public function set direction(tmpDirection:FlxPoint):void {
			_direction = tmpDirection;
			goInDirection();
		}
		
		public function get isUp():Boolean {return _direction.x == kUp.x && _direction.y == kUp.y;}
		public function get isDown():Boolean {return _direction.x == kDown.x && _direction.y == kDown.y;}
		public function get isLeft():Boolean {return _direction.x == kLeft.x && _direction.y == kLeft.y;}
		public function get isRight():Boolean {return _direction.x == kRight.x && _direction.y == kRight.y;}
		
		protected var _velocityX:Number;
		protected var _velocityY:Number;
		
		public function SprCrusher(tmpX:Number=0,tmpY:Number=0,tmpSimpleGraphic:Class=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			loadGraphic(Glob.kCrusherSheet);
			//mass = Number.MAX_VALUE;
			
		}
		
		public function goUp():void {
			direction = kUp;
		}
		
		public function goDown():void {
			direction = kDown;
		}
		
		public function goLeft():void {
			direction = kLeft;
		}
		
		public function goRight():void {
			direction = kRight;
		}
		
		private function goInDirection():void {
			_velocityX = _direction.x*kRate;
			_velocityY = _direction.y*kRate;
		}
		
		public function reverseDirection():void {
			direction = new FlxPoint(_direction.x*-1,_direction.y*-1);
		}
		
		override protected function recordEvents():void {
			var tmpX:Number = x;
			var tmpY:Number = y;
			var tmpEvent:Function = function():void {
				x = tmpX;
				y = tmpY;
			};
			timeRecord.addEventAtFrame(tmpEvent,timeArrow.frame);
		}
		
		override protected function updateLocation():void {
			var tmpTimeDirection:int = (timeArrow.isForward()) ? 1 : -1;
			velocity.x = _velocityX*timeArrow.rate*tmpTimeDirection;
			velocity.y = _velocityY*timeArrow.rate*tmpTimeDirection;
		}
		
		override protected function updateVideo():void {
			//
		}
	}
}