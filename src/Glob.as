package
{
	import org.flixel.*;
	
	public class Glob
	{	
		public static const kDebugOn:Boolean = true;
		
		public static const timeArrow:TimeArrow = new TimeArrow();
		
		[Embed(source="../assets/spr_wall.png")] public static const kWallSheet:Class;
		[Embed(source="../assets/spr_fly.png")] public static const kFlySheet:Class;
		[Embed(source="../assets/spr_portal.png")] public static const kPortalSheet:Class;
		[Embed(source="../assets/spr_crusher.png")] public static const kCrusherSheet:Class;
		
		// Key Press Macros
		public static function pressed(_keys:Array):Boolean {
			for (var i:uint = 0; i < _keys.length; i++) {
				if (FlxG.keys.pressed(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function justPressed(_keys:Array):Boolean {
			for (var i:uint = 0; i < _keys.length; i++) {
				if (FlxG.keys.justPressed(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function justReleased(_keys:Array):Boolean {
			for (var i:uint = 0; i <_keys.length; i++) {
				if (FlxG.keys.justReleased(_keys[i])) {
					return true;
				}
			}
			return false;
		}
		public static function pressedAfter(_keysPrimary:Array,_keysSecondary:Array):Boolean {
			return pressed(_keysPrimary) && (justPressed(_keysPrimary) || !pressed(_keysSecondary));
		}
	}
}