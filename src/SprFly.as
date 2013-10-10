package
{
	import org.flixel.*;
	
	public class SprFly extends ZNodeTime
	{
		private const kWidth:uint = 32;
		private const kHeight:uint = 32;
		
		private const kMoveAccel:Number = kWidth*22.0;
		private const kDrag:Number = kMoveAccel;
		private const kMaxVel:Number = kMoveAccel;
		
		private const kAnimIdle:String = "kAnimIdle";
		
		private var isMovingUp:Boolean;
		private var isMovingDown:Boolean;
		private var isMovingLeft:Boolean;
		private var isMovingRight:Boolean;
		
		//private var flyPortal:SprFlyPortal;
		
		public function SprFly(X:Number=0,Y:Number=0)
		{
			//FlxG.log("("+X+","+Y+")");
			
			super(X,Y);
			loadGraphic(Glob.kFlySheet,true,false,kWidth,kHeight);
			
			addAnimation(kAnimIdle,[0,1],22,true);
			
			drag.x = kDrag;
			drag.y = kDrag;
			maxVelocity.x = kMaxVel;
			maxVelocity.y = kMaxVel;
			
			resetBools();
			
			//flyPortal = new SprFlyPortal();
			//flyPortal.visible = false;
		}
		
		private function resetBools():void {
			isMovingUp = false;
			isMovingDown = false;
			isMovingLeft = false;
			isMovingRight = false;
		}
		
		override protected function updateLocation():void {
			acceleration.x = 0;
			acceleration.y = 0;
			if (isMovingUp) {
				acceleration.y -= kMoveAccel;
			}
			if (isMovingDown) {
				acceleration.y += kMoveAccel;
			}
			if (isMovingLeft) {
				acceleration.x -= kMoveAccel;
			}
			if (isMovingRight) {
				acceleration.x += kMoveAccel;
			}
			
			// will move if I decide to make better nodes
			//flyPortal.x = x;
			//flyPortal.y = y;
			
			resetBools();
		}
		
		override protected function updateVideo():void {
			play(kAnimIdle);
			
			if (isBetweenFrames()) {
				showFromPortal();
			} else {
				hideInPortal();
			}
		}
		
		public function moveUp():void {
			isMovingUp = true;
		}
		
		public function moveDown():void {
			isMovingDown = true;
		}
		
		public function moveLeft():void {
			isMovingLeft = true;
		}
		
		public function moveRight():void {
			isMovingRight = true;
		}
		
		override protected function recordEvents():void {
			
			var tmpX:Number = x;
			var tmpY:Number = y;
			var tmpEvent:Function = function():void {
				x = tmpX;
				y = tmpY;
			}
			
			
			timeRecord.addEventAtFrame(tmpEvent,timeArrow.frame);
		}
		
		public function hideInPortal():void {
			disableRecording();
			visible = false;
			//flyPortal.visible = true;
		}
		
		public function showFromPortal():void {
			enableRecording();
			visible = true;
			//flyPortal.visible = false;
		}
		
		public function startRecordingAtThisFrame():void {
			frameStart = timeArrow.frame;
		}
		
		public function stopRecordingAtThisFrame():void {
			frameEnd = timeArrow.frame;
		}
		
		public function isDangerous():Boolean {
			return isBetweenFrames();
		}
	}
}