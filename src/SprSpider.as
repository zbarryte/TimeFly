package
{
	public class SprSpider extends ZNodeTime
	{
		private const kLookRadius:uint = 32*22;
		private const kMoveMultiplier:uint = 64;
		
		public function SprSpider(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y,GSpritinator.kSpider);
		}
		
		public function moveTowards(tmpNode:ZNode):void {
			velocity.x = 0;
			velocity.y = 0;
			
			var tmpDistSq:Number = Math.pow(tmpNode.x - x,2) + Math.pow(tmpNode.y - y,2);
			//if (tmpDistSq <= kLookRadius) {
				var tmpDist:Number = Math.pow(tmpDistSq,0.5);
				var tmpDX:Number = (tmpNode.x - x)/tmpDist;
				var tmpDY:Number = (tmpNode.y - y)/tmpDist;
				
				velocity.x = tmpDX*kMoveMultiplier;
				velocity.y = tmpDY*kMoveMultiplier;
			//}
		}
	}
}