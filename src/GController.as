package
{
	import flash.events.MouseEvent;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxObject;
	
	public class GController
	{
		public static const kLeft:Array = ["LEFT","A"];
		public static const kRight:Array = ["RIGHT","D"];
		public static const kUp:Array = ["UP","W"];
		public static const kDown:Array = ["DOWN","S"];
		
		public static const kTimeForward:Array = ["E","FOUR"];
		public static const kTimeBackward:Array = ["Q","THREE"];
		
		public static const kPause:Array = ["P","ESCAPE"];
		
		public static const kSelect:Array = ["SPACE","ENTER"];
		public static const kBack:Array = ["ESCAPE"];
		public static const kCurseBackwards:Array = kLeft.concat(kUp);
		public static const kCurseForward:Array = kRight.concat(kDown);
		
		/**
		 * Checks whether or not any of the keys in the array is being pressed. Wraps <code>FlxG.keys.pressed</code>
		 * 
		 * @param	tmpKeys		An array of keys to check
		 * 
		 * @return	Whether any of the keys is being pressed
		 */
		public function pressed(tmpKeys:Array):Boolean {
			for (var i:uint = 0; i < tmpKeys.length; i++) {
				if (FlxG.keys.pressed(tmpKeys[i])) {
					return true;
					
					FlxG.keys.pressed
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the keys in the array were just pressed. Wraps <code>FlxG.kys.justPressed</code>
		 * 
		 * @param	tmpKeys		An array of keys to check
		 * 
		 * @return 	Whether any of the keys were just pressed
		 */
		public function justPressed(tmpKeys:Array):Boolean {
			for (var i:uint = 0; i < tmpKeys.length; i++) {
				if (FlxG.keys.justPressed(tmpKeys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the keys in the array were just released. Wraps <code>FlxG.keys.justReleased</code>
		 * 
		 * @param	tmpKeys		An array of keys to check
		 * 
		 * @return	Whether any of the keys were just released
		 */
		public function justReleased(tmpKeys:Array):Boolean {
			for (var i:uint = 0; i <tmpKeys.length; i++) {
				if (FlxG.keys.justReleased(tmpKeys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the primary keys have priority over the secondary keys. Priority is given to the key last pressed and still held.
		 * 
		 * @param	tmpKeysPrimary		An array of primary keys
		 * @param 	tmpKeysSecondary	An array of secondary keys
		 * 
		 * @return	Whether or not the primary keys have priority over the secondary keys.
		 */
		public function pressedAfter(tmpKeysPrimary:Array,tmpKeysSecondary:Array):Boolean {
			return pressed(tmpKeysPrimary) && (justPressed(tmpKeysPrimary) || !pressed(tmpKeysSecondary));
		}
		
		/**
		 * Checks whether or not the mouse was just left clicked
		 * 
		 * @return	Whether or not the mouse was just left clicked
		 */
		public function justPressedLeftClick():Boolean {
			return FlxG.mouse.justPressed();
		}
		
		/**
		 * Checks whether or not the mouse was left clicked
		 * 
		 * @return	Whether or not the mouse was left clicked
		 */
		public function pressedLeftClick():Boolean {
			return FlxG.mouse.pressed();
		}
		
		/**
		 * Checks whether or not the mouse left click was just released
		 * 
		 * @return	Whether or not the mouse left click was just released
		 */
		public function justReleasedLeftClick():Boolean {
			return FlxG.mouse.justReleased();
		}
		
		/**
		 * @return	The point clicked
		 */
		public function clickPoint():FlxPoint {
			var tmpPoint:FlxPoint = new FlxPoint();
			tmpPoint.x = FlxG.mouse.x;
			tmpPoint.y = FlxG.mouse.y;
			return tmpPoint;
		}
		
		/**
		 * Checks whether ore not the mouse is over a particular object
		 * 
		 * @return	Whether or not the mouse is over a particular object
		 */
		public function mouseOver(tmpNode:FlxObject):Boolean {
			var tmpPoint:FlxPoint = clickPoint();
			return (tmpNode.x <= tmpPoint.x && tmpPoint.x <= tmpNode.x + tmpNode.width
				&& tmpNode.y <= tmpPoint.y && tmpPoint.y <= tmpNode.y + tmpNode.height);
		}
	}
}