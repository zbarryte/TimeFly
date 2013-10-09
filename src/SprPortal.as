package
{
	public class SprPortal extends ZNode
	{
		private const kRotationRate:uint = 1;
		
		public function SprPortal(X:Number=0, Y:Number=0)
		{
			super(X,Y);
			loadGraphic(Glob.kPortalSheet);
		}
		
		override protected function updateAnimation():void {
			var tmpAngleOffset:Number = _timeArrow.rate*kRotationRate;
			tmpAngleOffset *= (_timeArrow.isForward()) ? 1 : -1;
			angle += tmpAngleOffset;
			
		}
	}
}