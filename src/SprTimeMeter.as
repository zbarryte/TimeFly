package
{
	import org.flixel.FlxGroup;

	public class SprTimeMeter extends ZNode
	{
		private var pellets:FlxGroup;
		private var numPellets:uint;
		private const kNumPelletsMax:uint = 20;
		
		private const kPelletIncreasePeriod:Number = 1.1;
		private var timer:Number;
		
		public function SprTimeMeter(tmpX:Number=0, tmpY:Number=0)
		{
			super(tmpX, tmpY, GSpritinator.kTimeMeter);
			addPellets();
			resetTimer();
			updatePelletVisibility();
		}
		
		private function addPellets():void {
			var tmpMargin:uint = 4;
			pellets = new FlxGroup();
			for (var i:uint = 0; i < kNumPelletsMax; i++) {
				var tmpPellet:ZNode = new ZNode();
				tmpPellet.loadGraphic(GSpritinator.kTimeMeterPellet);
				pellets.add(tmpPellet);
				add(tmpPellet);
				tmpPellet.xLocal = width/2.0 - tmpPellet.width/2.0;
				tmpPellet.yLocal = -tmpMargin + height - tmpPellet.height -(height)*(Number(i)/Number(kNumPelletsMax));
			}
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
			//Glob.log(numPellets);
			updatePelletVisibility();
		}
		
		private function updatePelletVisibility():void {
			
			var tmpCompletion:Number = percentageToCompletion();
			Glob.log(tmpCompletion);
			
			for (var i:uint = 0; i < pellets.length; i++) {
				var tmpPellet:ZNode = pellets.members[i];
				tmpPellet.visible = (i <= numPellets);
				
				if (tmpCompletion >= 1.0 - 1.0/Number(kNumPelletsMax)) {
					tmpPellet.color = 0xffff00;
				} else if (tmpCompletion > 0.4) {
					tmpPellet.color = 0xff8800;
				} else if (tmpCompletion > 0.2) {
					tmpPellet.color = 0xff4400;
				} else {
					tmpPellet.color = 0xff0000;
				}
			}
		}
		
		private function percentageToCompletion():Number {
			return Number(numPellets)/Number(kNumPelletsMax);
		}
	}
}