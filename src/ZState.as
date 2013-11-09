package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class ZState extends FlxState
	{
		protected var _isPlaying:Boolean;
		protected var _isControllable:Boolean;
		protected var _overlay:FlxSprite;
		
		public function ZState()
		{
			super();
			
			_isPlaying = true;
			enableControls();
		}
		
		override public function create():void {
			FlxG.bgColor = 0xffffffff;
			createScene();
			addOverlay();
			addDebug();
		}
		
		protected function createScene():void {
			//FlxG.log(":: createScene() :: not yet implemented by " + this);
		}
		
		private function addOverlay():void {
			_overlay = new FlxSprite();
			_overlay.makeGraphic(FlxG.width,FlxG.height);
			hideOverlay();
			add(_overlay);
		}
		
		private function addDebug():void {
			var tmpText:ZText = new ZText(0,0,FlxG.width);
			tmpText.text = "## DEBUG MODE ##";
			tmpText.alignment = "center";
			add(tmpText);
		}
		
		override public function update():void {
			if (_isPlaying) {
				super.update();
				updateAnimations();
				updateMechanics();
				if (_isControllable) {
					updateControls();
				}
			}
			else {
				updatePause();
			}
		}
		
		protected function updateAnimations():void {
			//FlxG.log(":: updateAnimations() :: not yet implemented by " + this);
		}
		
		protected function updateMechanics():void {
			
		}
		
		protected function updateControls():void {
			//FlxG.log(":: updateControls() :: not yet implemented by " + this);
		}
		
		protected function updatePause():void {
			//FlxG.log(":: updatePause() :: not yet implemented by " + this);
		}
		
		protected function tintOverlay(tmpColor:Number):void {
			_overlay.visible = true;
			_overlay.alpha = 0.5;
			_overlay.color = tmpColor;
		}
		
		protected function hideOverlay():void {
			_overlay.visible = false;
			_overlay.alpha = 1.0;
			_overlay.color = 0xffffffff;
		}
		
		protected function hideOverlayPreserveTint():void {
			_overlay.visible = false;
		}
		
		protected function enableControls():void {
			_isControllable = true;
		}
		
		protected function disableControls():void {
			_isControllable = false;
		}
	}
}