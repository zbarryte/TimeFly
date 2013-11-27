package
{
	public class SprSpider extends ZNodeTime
	{
		private const kLookRadiusSq:uint = Math.pow(32*5,2);
		private const kMoveMultiplier:uint = 64*2;
		
		private var animationName:String;
		
		private const kAnimIdle:String = "kAnimIdle";
		private const kAnimMove:String = "kAnimMove";
		
		private var legs:ZNode;
		
		public function SprSpider(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
			loadGraphic(GSpritinator.kSpider,true,false,32,32);
			
			addAnimation(kAnimIdle,[0],10);
			addAnimation(kAnimMove,[1],10);
			
			var $animationCallback:Function = function($animationName:String,$animationIndex:uint,$frameIndex:uint):void {
				animationName = $animationName;
			}
			
			addAnimationCallback($animationCallback);
			
			legs = new ZNode();
			legs.loadGraphic(GSpritinator.kSpiderLegs,true,false,32,32);
			add(legs);
			
			legs.addAnimation(kAnimIdle,[0],10);
			legs.addAnimation(kAnimMove,[1,2],10);
		}
		
		public function moveTowards(tmpNode:ZNode):void {
			velocity.x = 0;
			velocity.y = 0;
			
			var $distSq:Number = Math.pow(tmpNode.x - x,2) + Math.pow(tmpNode.y - y,2);
			if ($distSq <= kLookRadiusSq) {
				var $dist:Number = Math.pow($distSq,0.5);
				var $dx:Number = (tmpNode.x - x)/$dist;
				var $dy:Number = (tmpNode.y - y)/$dist;
				
				velocity.x = $dx*kMoveMultiplier;
				velocity.y = $dy*kMoveMultiplier;
				
				var $theta:Number = Math.atan($dy/$dx)*180.0/Math.PI + 90;
				//Glob.log($theta);
				angle = $theta;
			}
		}
		
		override protected function updateAV():void {
			if (velocity.x == 0 && velocity.y == 0) {
				play(kAnimIdle);
				legs.play(kAnimIdle);
			} else {
				play(kAnimMove);
				legs.play(kAnimMove);
			}
			legs.angle = angle;
		}
		
		override protected function recordEvents():void {
			
			var $x:Number = x;
			var $y:Number = y;
			var $angle:Number = angle;
			var $event:Function = function():void {
				x = $x;
				y = $y;
				angle = $angle;
				play(animationName);
				legs.play(animationName);
			}
			
			
			timeRecord.addEventAtFrame($event,timeArrow.frame);
		}
		
		override protected function runEvents():void {
			if (!Glob.timeArrow.isNormal()) {
				super.runEvents();
			}
		}
	}
}