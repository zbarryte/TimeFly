package
{
	import org.flixel.FlxTilemap;

	public class LevelsStore
	{
		public static const kTileWidth:uint = 32;
		public static const kTileHeight:uint = 32;
		
		public static function currentFlxTilemapFunctional():FlxTilemap {
			var map:FlxTilemap = new FlxTilemap();
			map.loadMap(new currentCSV,kTilesFunc,widthFunc,heightFunc);
			return map;
		}
		
		private static const widthFunc:uint = 32;
		private static const heightFunc:uint = 32;
		
		[Embed("../assets/tiles_functional.png")] public static const kTilesFunc:Class;
		
		[Embed("../assets/mapCSV_functional_001.csv",mimeType="application/octet-stream")] private static const kFunc001Sheet:Class;
		[Embed("../assets/mapCSV_functional_002.csv",mimeType="application/octet-stream")] private static const kFunc002Sheet:Class;
		[Embed("../assets/mapCSV_functional_003.csv",mimeType="application/octet-stream")] private static const kFunc003Sheet:Class;
		
		private static var _num:uint = 2;
		//private static var _num:uint = 0;
		public static function get num():uint {
			return _num;
		}
		public static function set num(setNum:uint):void {
			_num = (setNum < csvs.length) ? setNum : csvs.length;
		}
		
		private static const csvs:Array = [kFunc001Sheet,kFunc002Sheet,kFunc003Sheet];
		private static function get currentCSV():Class {
			return csvs[num];
		}
	}
}