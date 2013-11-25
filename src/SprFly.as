package
{
	import org.flixel.*;
	
	public class SprFly extends ZNodeTime
	{
		private const kWidth:uint = 8;
		private const kHeight:uint = 8;
		
		private const kMoveAccel:Number = 32.0*11.0*0.5;
		private const kDrag:Number = kMoveAccel;
		private const kMaxVel:Number = kMoveAccel;
		private const kMaxVelFast:Number = kMaxVel*2.2;
		
		private const kAnimIdle:String = "kAnimIdle";
		
		private var isMovingUp:Boolean;
		private var isMovingDown:Boolean;
		private var isMovingLeft:Boolean;
		private var isMovingRight:Boolean;
		private var isSpeedBoosted:Boolean;
		
		public var isTraveling:Boolean;
		
		private var imgPortal:SprFlyPortal;
		private var imgFly:ZNode;
		
		private const kCloneColor:Number = 0xff0000;
		
		public function SprFly(X:Number=0,Y:Number=0)
		{
			//FlxG.log("("+X+","+Y+")");
			
			super(X,Y);
			width = kWidth;
			height = kHeight;
			
			addImgFly();
			addImgPortal();
			
			drag.x = kDrag;
			drag.y = kDrag;
			//maxVelocity.x = kMaxVel;
			//maxVelocity.y = kMaxVel;
			
			resetBools();
			
			//flyPortal = new SprFlyPortal();
			//flyPortal.visible = false;
		}
		
		private function addImgFly():void {
			imgFly = new ZNode();
			imgFly.loadGraphic(GSpritinator.kFly,true,false,32,32);
			imgFly.addAnimation(kAnimIdle,[0,1,2,3],22,true);
			imgFly.xLocal = width/2.0 - imgFly.width/2.0;
			imgFly.yLocal = height/2.0 - imgFly.height/2.0;
			add(imgFly);
		}
		
		private function addImgPortal():void {
			imgPortal = new SprFlyPortal();
			imgPortal.visible = false;
			imgPortal.color = kCloneColor;
			imgPortal.xLocal = width/2.0 - imgFly.width/2.0;
			imgPortal.yLocal = height/2.0 - imgFly.width/2.0;
			add(imgPortal);
		}
		
		private function resetBools():void {
			isMovingUp = false;
			isMovingDown = false;
			isMovingLeft = false;
			isMovingRight = false;
			isSpeedBoosted = false;
		}
		
		override protected function updateMechanics():void {
			acceleration.x = 0;
			acceleration.y = 0;
			maxVelocity.x = (isSpeedBoosted ? kMaxVelFast : kMaxVel);
			maxVelocity.y = (isSpeedBoosted ? kMaxVelFast : kMaxVel);
			if (isMovingUp) {
				acceleration.y -= kMoveAccel*(isSpeedBoosted ? 2 : 1);
			}
			if (isMovingDown) {
				acceleration.y += kMoveAccel*(isSpeedBoosted ? 2 : 1);
			}
			if (isMovingLeft) {
				acceleration.x -= kMoveAccel*(isSpeedBoosted ? 2 : 1);
			}
			if (isMovingRight) {
				acceleration.x += kMoveAccel*(isSpeedBoosted ? 2 : 1);
			}
						
			// will move if I decide to make better nodes
			//flyPortal.x = x;
			//flyPortal.y = y;
			
			resetBools();
		}
		
		override protected function updateAV():void {
			imgFly.play(kAnimIdle);
			
			if (isBetweenFrames() && !isTraveling) {
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
			velocity.x = 0;
			velocity.y = 0;
			disableRecording();
			//color = 0x0000ff;
			imgFly.visible = false;
			//flyPortal.visible = true;
			imgPortal.visible = true;
		}
		
		public function showFromPortal():void {
			enableRecording();
			//color = 0xffffff;
			imgFly.visible = true;
			//flyPortal.visible = false;
			imgPortal.visible = false;
		}
		
		public function clonify():void {
			imgFly.color = kCloneColor;
			stopRecordingAtThisFrame();
		}
		
		public function startTimeTraveling():void {
			hideInPortal();
			isTraveling = true;
		}
		
		public function stopTimeTraveling():void {
			showFromPortal();
			isTraveling = false;
			startRecordingAtThisFrame();
		}
		
		public function startRecordingAtThisFrame():void {
			frameStart = timeArrow.frame;
		}
		
		public function stopRecordingAtThisFrame():void {
			frameEnd = timeArrow.frame;
		}
		
		public function isDangerous():Boolean {
			return isBetweenFrames() && _canRecord;
		}
		
		public function speedBoost():void {
			isSpeedBoosted = true;
		}
	}
}