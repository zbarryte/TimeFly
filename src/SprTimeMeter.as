package
{
	import org.flixel.FlxGroup;

	public class SprTimeMeter extends ZNode
	{
		private var pellets:FlxGroup;
		private var numPellets:uint;
		private const kNumPelletsMax:uint = 10;
		
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
			pellets = new FlxGroup();
			for (var i:uint = 0; i < kNumPelletsMax; i++) {
				var tmpPellet:ZNode = new ZNode();
				tmpPellet.loadGraphic(GSpritinator.kTimeMeterPellet);
				pellets.add(tmpPellet);
				add(tmpPellet);
				tmpPellet.x = width/2.0 - tmpPellet.width/2.0;
				tmpPellet.y = height - tmpPellet.height -(height)*(Number(i)/Number(kNumPelletsMax));
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
			for (var i:uint = 0; i < pellets.length; i++) {
				var tmpPellet:ZNode = pellets.members[i];
				tmpPellet.visible = (i <= numPellets);
			}
		}
	}
}