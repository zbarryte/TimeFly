package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class ZState extends FlxState
	{
		protected var _isControllable:Boolean;
		//protected var _overlay:FlxSprite;
		
		public function ZState()
		{
			super();
			
			enableControls();
		}
		
		/**
		 * Overridden <code>create</code> method.
		 * If you override this, you'll lose the debug stuff, unless you call <code>super.create()</code>
		 */
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
			createScene();
			//addOverlay();
			addDebug();
		}
		
		/**
		 * Creates the scene.
		 * Override this instead of overriding <code>create</code>
		 */
		protected function createScene():void {
			// implemented by children
		}
		/*
		private function addOverlay():void {
			_overlay = new FlxSprite();
			_overlay.makeGraphic(FlxG.width,FlxG.height);
			hideOverlay();
			add(_overlay);
		}
		*/
		private function addDebug():void {
			var tmpText:ZText = new ZText(0,0,FlxG.width);
			tmpText.text = "## DEBUG MODE ##";
			tmpText.alignment = "center";
			add(tmpText);
		}
		
		/**
		 * Overridden <code>update</code> method.
		 * Overriding again will obviate calls to sub-updates, unless <code>super.update()</code> is called
		 * 
		 * Calls <code>updateScene</code>.
		 * Calls <code>updateControls</code> if isControllable
		 */
		override public function update():void {
			super.update();
			updateScene();
			if (_isControllable) {
				updateControls();
			}
		}
		
		/**
		 * Updates the scene.
		 * Override this to specify what goes on in the scene.
		 */
		protected function updateScene():void {
			// implemented by children
		}
		
		/**
		 * Updates the controls
		 * Override this to specify the controls
		 */
		protected function updateControls():void {
			// implemented by children
		}
		
		protected function enableControls():void {
			_isControllable = true;
		}
		
		protected function disableControls():void {
			_isControllable = false;
		}
		
		public function switchState(tmpClass:Class):void {
			var tmpState:ZState = new tmpClass();
			// anythng to init it properly could go here
			FlxG.switchState(tmpState); // this could also be something with a timer, a fade, who knows, whatever
		}
	}
}