package
{
	public class SprTimeMeter extends ZNode
	{
		private var numPellets:uint;
		private const kNumPelletsMax:uint = 10;
		
		private const kPelletIncreasePeriod:Number = 4.4;
		private var timer:Number;
		
		public function SprTimeMeter(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX, tmpY, GSpritinator.kTimeMeter);
			
			resetTimer();
		}
		
		private function resetTimer():void {
			timer = 0;
		}
		
		override protected function updateMechanics():void {
			timer += Glob.elapsed;
			if (timer > kPelletIncreasePeriod) {
				resetTimer();
				addPellet();
			}
		}
		
		private function addPellet():void {
			numPellets = (numPellets + 1 < kNumPelletsMax) ? numPellets + 1 : kNumPelletsMax;
		}
	}
}