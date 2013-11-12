package
{
	public class StTitle extends ZState
	{
		private var mnu:ZMenu;
		
		public function StTitle()
		{
			super();
		}
		
		override protected function createScene():void {
			addMenu();
		}
		
		private function addMenu():void {
			mnu = new ZMenu();

			var tmpMargin:uint = 44;
			
			// PLAY
			var callbackPlay:Function = function():void {
				//Glob.log("PLAY");
				switchState(StLoad);
			};
			var textPlay:String = "PLAY";
			var btnPlay:BtnBasic = new BtnBasic(callbackPlay,textPlay);
			btnPlay.placeAtScreenXPercentage(0.2);
			btnPlay.placeAtScreenYPercentage(0.8);
			mnu.add(btnPlay);
			
			// BUILD
			var callbackBuild:Function = function():void {
				Glob.log("BUILD");
			};
			var textBuild:String = "BUILD";
			var btnBuild:BtnBasic = new BtnBasic(callbackBuild,textBuild);
			btnBuild.placeRightOfSprite(btnPlay,tmpMargin);
			mnu.add(btnBuild);
			
			// SETTINGS
			var callbackSettings:Function = function():void {
				Glob.log("SETTINGS");
			};
			var textSettings:String = "SETTINGS";
			var btnSettings:BtnBasic = new BtnBasic(callbackSettings,textSettings);
			btnSettings.placeRightOfSprite(btnBuild,tmpMargin);
			mnu.add(btnSettings);
			
			add(mnu);
		}
		
		override protected function updateControls():void {
			if (Glob.kController.justPressed(GController.kCurseForward)) {
				mnu.curseForward();
			}
			
			if (Glob.kController.justPressed(GController.kCurseBackwards)) {
				mnu.curseBackwards();
			}
			
			if (Glob.kController.justPressed(GController.kSelect)) {
				mnu.select();
			}
		}
	}
}