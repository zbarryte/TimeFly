package
{
	import org.flixel.*;

	public class StPlay extends ZState
	{
		private const kKeysUp:Array = ["W","UP"];
		private const kKeysDown:Array = ["S","DOWN"];
		private const kKeysLeft:Array = ["A","LEFT"];
		private const kKeysRight:Array = ["D","RIGHT"];
		
		private const kSpawnPortal:Array = [2];
		private const kSpawnFly:Array = [3];
		
		private var lvlFunc:FlxTilemap;
		private var fly:SprFly;
		
		
		override protected function createScene():void
		{
			FlxG.bgColor = 0xffcc88ff;
			lvlFunc = GlobLevels.currentFlxTilemapFunctional();
			add(lvlFunc);
			
			fly = groupFromSpawn(kSpawnFly,SprFly,lvlFunc,true).members[0];
			add(fly);
		}
		
		override protected function updateAnimations():void {
			FlxG.collide(lvlFunc,fly);
		}
		
		override protected function updateControls():void {
			if (Glob.pressedAfter(kKeysUp,kKeysDown)) {
				fly.moveUp();
			}
			if (Glob.pressedAfter(kKeysDown,kKeysUp)) {
				fly.moveDown();
			}
			
			if (Glob.pressedAfter(kKeysLeft,kKeysRight)) {
				fly.moveLeft();
			}
			if (Glob.pressedAfter(kKeysRight,kKeysLeft)) {
				fly.moveRight();
			}
		}
		
		override protected function updatePause():void {
			//
		}
		
		private function groupFromSpawn(_spawn:Array,_class:Class,_map:FlxTilemap,_hide:Boolean=true):FlxGroup {
			var _group:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i <_spawn.length; i++) {
				var _array:Array = _map.getTileInstances(_spawn[i]);
				if (_array) {
					for (var j:uint = 0; j < _array.length; j++) {
						var _point:FlxPoint = pointForTile(_array[j],_map);
						_group.add(new _class(_point.x,_point.y));
						if (_hide) {
							_map.setTileByIndex(_array[j],0);
						}
					}
				}
			}
			return _group;
		}
		
		private function setCallbackFromSpawn(_spawn:Array,_callback:Function,_map:FlxTilemap,_hide:Boolean=true):void {
			for (var i:uint = 0; i <_spawn.length; i++) {
				_map.setTileProperties(_spawn[i],FlxObject.ANY,_callback);
				var _array:Array = _map.getTileInstances(_spawn[i]);
				if (_array && _hide) {
					for (var j:uint = 0; j < _array.length; j++) {
						_map.setTileByIndex(_array[j],0);
					}
				}
			}
		}
		
		private function pointForTile(_tile:uint,_map:FlxTilemap):FlxPoint {
			var _x:Number = (_map.width/_map.widthInTiles)*(int)(_tile%_map.widthInTiles);
			var _y:Number = (_map.width/_map.widthInTiles)*(int)(_tile/_map.widthInTiles);
			var _point:FlxPoint = new FlxPoint(_x,_y);
			return _point;
		}
		
	}
}