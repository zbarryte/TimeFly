package
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	public class ZState extends FlxState
	{
		protected var _isPlaying:Boolean;
		protected var _isControllable:Boolean;
		
		public function ZState()
		{
			super();
			
			_isPlaying = true;
			_isControllable = true;
		}
		
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
			createScene();
		}
		
		protected function createScene():void {
			FlxG.log(":: createScene() :: not yet implemented by " + this);
		}
		
		override public function update():void {
			if (_isPlaying) {
				super.update();
				updateAnimations();
				if (_isControllable) {
					updateControls();
				}
			}
			else {
				updatePause();
			}
		}
		
		protected function updateAnimations():void {
			FlxG.log(":: updateAnimations() :: not yet implemented by " + this);
		}
		
		protected function updateControls():void {
			FlxG.log(":: updateControls() :: not yet implemented by " + this);
		}
		
		protected function updatePause():void {
			FlxG.log(":: updatePause() :: not yet implemented by " + this);
		}
	}
}