package
{
	import flash.events.Event;
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	
	[SWF(width="896", height="512", backgroundColor="#000000")]
	
	public class TimeFly extends FlxGame
	{
		public function TimeFly()
		{
			super(896,512,StPlay,1,60,60,true);
			
			FlxG.debug = Glob.kDebugOn;
		}
		
		override protected function create(FlashEvent:Event):void {
			super.create(FlashEvent);
			stage.removeEventListener(Event.DEACTIVATE,onFocusLost);
			stage.removeEventListener(Event.ACTIVATE,onFocus);
			stage.align = "TOP";
		}
	}
}