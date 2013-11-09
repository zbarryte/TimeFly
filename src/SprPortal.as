package
{
	public class SprPortal extends ZNodeTime
	{
		private const kRotationRate:uint = 3;
		
		private const kScaleRate:Number = 0.0022;
		private const kScaleMax:Number = 1.22;
		private const kScaleMin:Number = 0.88;
		
		private const kAlphaMax:Number = 0.88;
		private const kAlphaMin:Number = 0.22;
		
		private var scaleDir:int;
		
		public function SprPortal(X:Number=0, Y:Number=0)
		{
			super(X,Y);
			loadGraphic(Glob.kPortalSheet);
			antialiasing = true;
			scaleDir = 1;
		}
		
		override protected function updateAnimation():void {
			// rotate
			var tmpAngleOffset:Number = timeArrow.rate*kRotationRate;
			tmpAngleOffset *= (timeArrow.isForward()) ? -1 : 1;
			angle += tmpAngleOffset;
			// pulse scale
			scaleDir *= (kScaleMin < scale.x && scale.x < kScaleMax) ? 1 : -1;
			var tmpScaleOffset:Number = timeArrow.rate*kScaleRate;
			tmpScaleOffset *= scaleDir*((timeArrow.isForward()) ? -1: 1);
			scale.x += tmpScaleOffset;
			if (scale.x < kScaleMin) {scale.x = kScaleMin;}
			if (scale.x > kScaleMax) {scale.x = kScaleMax;}
			scale.y = scale.x;
			// pulse alpha
			alpha = kAlphaMin + (kAlphaMax -kAlphaMin)*Math.abs(scale.x - ((kScaleMax-kScaleMin)/2.0 + kScaleMin))/((kScaleMax-kScaleMin)/2.0 + kScaleMin);
			alpha = 1.0 - alpha
		}
		
		override protected function recordEvents():void {
			//
		}
		
		override protected function updateMechanics():void {
			//
		}
		
		override protected function updateAV():void {
			// 
		}
	}
}