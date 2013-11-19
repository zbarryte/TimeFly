package
{
	import flash.events.Event;
	import org.flixel.FlxGame;
	
	//[SWF(width="896", height="512", backgroundColor="#000000")]
	[SWF(width="960", height="576", backgroundColor="#000000")]
	
	public class TimeFly extends FlxGame
	{
		public function TimeFly()
		{
			super(896+64,512+64,StTitle,1,60,60,true);
			forceDebugger = Glob.kDebugOn;
		}
		
		override protected function create(FlashEvent:Event):void {
			super.create(FlashEvent);
			stage.removeEventListener(Event.DEACTIVATE,onFocusLost);
			stage.removeEventListener(Event.ACTIVATE,onFocus);
			stage.align = "TOP";
		}
	}
}