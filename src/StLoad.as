package
{
	public class StLoad extends ZState
	{	
		private var sldr:SldrLoad;
		
		public function StLoad()
		{
			super();
		}
		
		override protected function createScene():void {
			addSlider();
		}
		
		private function addSlider():void {
			sldr = new SldrLoad(0,0);
			sldr.centerX();
			sldr.placeAtScreenYPercentage(0.65);
			sldr.repositionMarker();
			add(sldr);
		}
		
		override protected function updateControls():void {
			if (Glob.controller.justPressed(GController.back)) {
				switchState(StTitle);
			}
			
			if (Glob.controller.pressedLeftClick()) {
				sldr.placeMarkerAtPoint(Glob.controller.clickPoint());
			}
		}
	}
}