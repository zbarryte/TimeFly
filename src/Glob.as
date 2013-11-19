package
{
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	
	public class Glob
	{	
		public static function get elapsed():Number {
			return FlxG.elapsed;
		}
		
		public static const kDebugOn:Boolean = true;
		
		public static const kLeveler:GLeveler = new GLeveler();
		public static const kController:GController = new GController();
		public static const kSpritinator:GSpritinator = new GSpritinator();
		
		public static const kScreenWidth:Number = FlxG.width;
		public static const kScreenHeight:Number = FlxG.height;
		
		public static function log(tmpData:Object):void {
			FlxG.log(tmpData);
		}
		
		public static function getClass(tmpObject:Object):Class {
			return FlxU.getClass(FlxU.getClassName(tmpObject));
		}
		
		public static const timeArrow:TimeArrow = new TimeArrow();
	}
}