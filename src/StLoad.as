package
{
	public class StLoad extends ZState
	{	
		private var sldr:SldrLoad;
		private var mnu:ZMenu;
		
		override protected function createScene():void {
			addSlider();
			addMenu();
		}
		
		private function addSlider():void {
			sldr = new SldrLoad(0,0);
			sldr.centerX();
			sldr.placeAtScreenYPercentage(0.65);
			sldr.snapMarker();
			add(sldr);
		}
		
		private function addMenu():void {
			mnu = new ZMenu();
			
			// PLAY
			var tmpCallbackPlay:Function = function():void {
				switchState(StPlay);
			};
			var tmpTextPlay:String = "PLAY";
			var tmpBtnPlay:BtnBasic = new BtnBasic(tmpCallbackPlay,tmpTextPlay);
			mnu.add(tmpBtnPlay);
			tmpBtnPlay.centerX();
			tmpBtnPlay.placeAtScreenYPercentage(0.8);
			
			add(mnu);
		}
		
		override protected function updateControls():void {
			if (Glob.kController.justPressed(GController.kBack)) {
				switchState(StTitle);
			}
			
			if (Glob.kController.pressedLeftClick()) {
				sldr.placeMarkerAtPoint(Glob.kController.clickPoint());
			}
			
			if (Glob.kController.justPressed(GController.kTimeForward)) {
				// move slider forward one unit
				sldr.goForward();
			}
			if (Glob.kController.justPressed(GController.kTimeBackward)) {
				// move slider backward one unit
				sldr.goBackward();
			}
			
			if (Glob.kController.justReleasedLeftClick() ||
				Glob.kController.justReleased(GController.kTimeForward) ||
				Glob.kController.justReleased(GController.kTimeBackward)) {
				
				sldr.snapMarker();
			}
			
			if (Glob.kController.justPressed(GController.kSelect)) {
				mnu.select();
			}
		}
	}
}