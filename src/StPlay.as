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
		private var portalGroup:FlxGroup;
		
		private const kCloneColor:Number = 0xff0000;
		private const kForwardTintColor:Number = 0x00ff00;
		private const kBackwardTintColor:Number = 0xff0000;
		
		private var canControlFly:Boolean;
		
		override protected function createScene():void
		{
			FlxG.bgColor = 0xffcc88ff;
			
			addTimeArrow();
			//initTimeRecord();
			addLevel();
			addPortals();
			addFlies();
		}
		
		private function addTimeArrow():void {
			timeArrow = Glob.timeArrow;
			timeArrow.reset();
			add(timeArrow);
		}
		
		/*
		private function initTimeRecord():void {
			timeRecord = new TimeRecord();
		}
		*/
		
		private function addLevel():void {
			lvlFunc = GlobLevels.currentFlxTilemapFunctional();
			add(lvlFunc);
		}
		
		private function addPortals():void {
			portalGroup = groupFromSpawn(kSpawnPortal,SprPortal,lvlFunc,true);
			add(portalGroup);
		}
		
		private function addFlies():void {
			flyGroup = groupFromSpawn(kSpawnFly,SprFly,lvlFunc,true);
			add(flyGroup);
		}
		
		private function get fly():SprFly {
			var tmpFly:SprFly = flyGroup.members[flyGroup.length-1];
			if (!tmpFly) {FlxG.log("ERROR :: NO FLY AT INDEX REQUESTED ::"); return null};
			return tmpFly;
		}
		
		override protected function updateAnimations():void {
			/*
			runEvents();
			recordEvents();
			*/
		}
		
		override protected function updateMechanics():void {
			FlxG.collide(lvlFunc,flyGroup);
			checkForFlyCloneParadox();
			checkForFlyCrush();
			
		}
		
		private function checkForFlyCloneParadox():void {
			// does the fly overlap one of its past selves?
			if (flyOverlapsClone()) {
				// oh no! this is a paradox! quickly, it's a second chance!
				FlxG.log("checkForFlyCloneParadox :: incomplete ::");
			}
		}
		
		private function checkForFlyCrush():void {
			// has the fly being pressed on by two parallel surfaces?
			if (fly.isTouching(FlxObject.LEFT) && fly.isTouching(FlxObject.RIGHT) ||
				fly.isTouching(FlxObject.UP) && fly.isTouching(FlxObject.DOWN)) {
				// oh no! it has been crushed! quickly, it's a second chance!
				FlxG.log("checkForFlyCrush :: incomplete ::");
			}
		}
		
		/*
		private function runEvents():void {
			timeRecord.runEventOfFrame(timeArrow.frame);
		}
		
		
		private function recordEvents():void {
			recordFlyPosition();
		}
		*/
		
		
		//private function recordFlyPosition():void {

			/*
			var x_:Number = fly.x;
			var y_:Number = fly.y;
			var event_:Function = function():void {
				fly.x = x_;
				fly.y = y_;
			};
			timeRecord.addEventAtFrame(event_,timeArrow.frame);
			
			
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
			*/
		//}
		
		override protected function updateControls():void {
			
			if (canControlFly) {
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
			
			/*
			if (Glob.pressedAfter(kKeysTravelForward,kKeysTravelBackward)) {
				//timeArrow.goForward();
				travelForward();
			}
			if (Glob.pressedAfter(kKeysTravelBackward,kKeysTravelBackward)) {
				//timeArrow.goBackward();
				travelBackward();
			}*/
			
			if (Glob.justPressed(kKeysTravelForward)) {
				travelForward();
			}
			else if (Glob.justPressed(kKeysTravelBackward)) {
				travelBackward();
			}
			
			if (!Glob.pressed(kKeysTravelForward) && !Glob.pressed(kKeysTravelBackward)) {
				endTimeTravel();
			}
		}
		
		private function travelForward():void {
			canControlFly = false;
			spawnNewFly();
			//fly.disableRecording();
			fly.hideInPortal();
			timeArrow.goFastForward();
			tintOverlay(kForwardTintColor);
		}
		
		private function travelBackward():void {
			canControlFly = false;
			spawnNewFly();
			//fly.disableRecording();
			fly.hideInPortal();
			timeArrow.goFastBackward();
			tintOverlay(kBackwardTintColor);
		}
		
		private function endTimeTravel():void {
			if (!canControlFly) {
				canControlFly = true;
				//fly.enableRecording();
				fly.showFromPortal();
				fly.startRecordingAtThisFrame();
				timeArrow.goNormalForward();
				hideOverlay();
			}
		}
		
		private function spawnNewFly():void {
			fly.color = kCloneColor;
			fly.stopRecordingAtThisFrame();
			var tmpFly:SprFly = new SprFly(fly.x,fly.y);
			flyGroup.add(tmpFly);
		}
		
		override protected function updatePause():void {
			//
		}
		
		private function flyOverlapsClone():Boolean {
			
			if (!fly.isDangerous()) {return false;}
			
			for (var i:uint = 0; i < flyGroup.length-1; i++) {
				var tmpFly:SprFly = flyGroup.members[i];
				if (fly.overlaps(tmpFly) && tmpFly.isDangerous()) {
					return true;
				}
			}
			return false;
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