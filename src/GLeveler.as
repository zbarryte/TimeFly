package
{
	//import org.flixel.FlxTilemap;

	public class GLeveler
	{
		public static const kTileWidth:uint = 32;
		public static const kTileHeight:uint = 32;
		
		/*
		public static function currentFlxTilemapFunctional():FlxTilemap {
			var map:FlxTilemap = new FlxTilemap();
			map.loadMap(new currentCSV,kTilesFunc,widthFunc,heightFunc);
			return map;
		}
		*/
		
		public static function get lvlFunc():ZTilemap {
			var map:ZTilemap = new ZTilemap();
			map.loadMap(new currentCSV,kTilesFunc,widthFunc,heightFunc);
			return map;
		}
		
		private static const widthFunc:uint = 32;
		private static const heightFunc:uint = 32;
		
		[Embed("../assets/tiles_functional.png")] public static const kTilesFunc:Class;
		
		[Embed("../assets/mapCSV_functional_001.csv",mimeType="application/octet-stream")] private static const kFunc001Sheet:Class;
		[Embed("../assets/mapCSV_functional_002.csv",mimeType="application/octet-stream")] private static const kFunc002Sheet:Class;
		[Embed("../assets/mapCSV_functional_003.csv",mimeType="application/octet-stream")] private static const kFunc003Sheet:Class;
		[Embed("../assets/mapCSV_functional_004.csv",mimeType="application/octet-stream")] private static const kFunc004Sheet:Class;
		[Embed("../assets/mapCSV_functional_005.csv",mimeType="application/octet-stream")] private static const kFunc005Sheet:Class;
		[Embed("../assets/mapCSV_functional_006.csv",mimeType="application/octet-stream")] private static const kFunc006Sheet:Class;

		
		private static var _num:uint = 0;
		public static function get num():uint {
			return _num;
		}
		public static function set num(setNum:uint):void {
			if (setNum >= csvs.length) {return;}
			_num = setNum;
		}
		
		public static function get numMax():uint {
			return csvs.length - 1;
		}
		
		private static const csvs:Array = [kFunc001Sheet,kFunc002Sheet,kFunc003Sheet,kFunc004Sheet,kFunc005Sheet,kFunc006Sheet];
		private static function get currentCSV():Class {
			return csvs[num];
		}
	}
}