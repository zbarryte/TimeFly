package
{
	import org.flixel.*;

	public class StPlay extends ZState
	{
		private const kKeysUp:Array = ["W","UP"];
		private const kKeysDown:Array = ["S","DOWN"];
		private const kKeysLeft:Array = ["A","LEFT"];
		private const kKeysRight:Array = ["D","RIGHT"];
		private const kKeysTravelForward:Array = ["E","SPACE"];
		private const kKeysTravelBackward:Array = ["Q","SHIFT"];
		
		private const kSpawnPortal:Array = [2];
		private const kSpawnFly:Array = [3];
		
		private var timeArrow:TimeArrow;
		private var timeRecord:TimeRecord;
		
		private var lvlFunc:FlxTilemap;
		private var flyGroup:FlxGroup;
		
		override protected function createScene():void
		{
			FlxG.bgColor = 0xffcc88ff;
			
			addTimeArrow();
			initTimeRecord();
			addLevel();
			addFlies();
		}
		
		private function addTimeArrow():void {
			timeArrow = new TimeArrow();
			add(timeArrow);
		}
		
		private function initTimeRecord():void {
			timeRecord = new TimeRecord();
		}
		
		private function addLevel():void {
			lvlFunc = GlobLevels.currentFlxTilemapFunctional();
			add(lvlFunc);
		}
		
		private function addFlies():void {
			flyGroup = groupFromSpawn(kSpawnFly,SprFly,lvlFunc,true);
			add(flyGroup);
		}
		
		private function get fly():SprFly {
			var tmpFly:SprFly = flyGroup.members[flyGroup.length-1];
			if (!tmpFly) {FlxG.log(":: NO FLY AT INDEX REQUESTED ::"); return null};
			return tmpFly;
		}
		
		override protected function updateAnimations():void {
			FlxG.collide(lvlFunc,fly);
			
			runEvents();
			recordEvents();
		}
		
		private function runEvents():void {
			timeRecord.runEventOfFrame(timeArrow.frame);
		}
		
		private function recordEvents():void {
			recordFlyPosition();
		}
		
		private function recordFlyPosition():void {

			/*
			var x_:Number = fly.x;
			var y_:Number = fly.y;
			var event_:Function = function():void {
				fly.x = x_;
				fly.y = y_;
			};
			timeRecord.addEventAtFrame(event_,timeArrow.frame);
			*/
			
			// record an event for each fly
			for (var i:uint = 0; i < flyGroup.length; i++) {
				var tmpFly:SprFly = flyGroup.members[i];
				var tmpX:Number = tmpFly.x;
				var tmpY:Number = tmpFly.y;
				var tmpEvent:Function = function():void {
					tmpFly.x = tmpX;
					tmpFly.y = tmpY;
				};
				timeRecord.addEventAtFrame(tmpEvent,timeArrow.frame);
			}
			
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
			if (Glob.pressedAfter(kKeysTravelForward,kKeysTravelBackward)) {
				//timeArrow.goForward();
				travelForward();
			}
			if (Glob.pressedAfter(kKeysTravelBackward,kKeysTravelBackward)) {
				//timeArrow.goBackward();
				travelBackward();
			}
		}
		
		private function travelForward():void {
			spawnNewFly();
			timeArrow.goForward();
		}
		
		private function travelBackward():void {
			spawnNewFly();
			timeArrow.goBackward();
		}
		
		private function spawnNewFly():void {
			var tmpFly:SprFly = new SprFly(fly.x,fly.y);
			flyGroup.add(tmpFly);
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