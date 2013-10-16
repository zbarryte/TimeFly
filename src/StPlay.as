package
{
	import org.flixel.*;

	public class StPlay extends ZState
	{
		private const kKeysUp:Array = ["W","UP"];
		private const kKeysDown:Array = ["S","DOWN"];
		private const kKeysLeft:Array = ["A","LEFT"];
		private const kKeysRight:Array = ["D","RIGHT"];
		private const kKeysTravelForward:Array = ["FOUR"];
		private const kKeysTravelBackward:Array = ["THREE"];
		
		private const kSpawnWall:Array = [1,18,19,20,21,22,23,24,25,26];
		private const kSpawnPortal:Array = [2];
		private const kSpawnFly:Array = [3];
		//private const kSpawnCrusher:Array = [4,5,6,7];
		private const kSpawnCrusherUp:Array = [6];
		private const kSpawnCrusherDown:Array = [7];
		private const kSpawnCrusherLeft:Array = [4];
		private const kSpawnCrusherRight:Array = [5];
		//private const kSpawnTrack:Array = [8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26];
		private const kSpawnTrackNS:Array = [6,7,8,18,12,22];
		private const kSpawnTrackEW:Array = [4,5,9,19,12,22];
		
		private var timeArrow:TimeArrow;
		private var timeRecord:TimeRecord;
		
		private var lvlFunc:FlxTilemap;
		
		private var wallGroup:FlxGroup;
		private var trackGroup:FlxGroup;
		private var portalGroup:FlxGroup;
		private var crusherGroup:FlxGroup;
		private var flyGroup:FlxGroup;
		
		private const kForwardTintColor:Number = 0x00ff00;
		private const kBackwardTintColor:Number = 0xff0000;
		
		private var canControlFly:Boolean;
		
		override protected function createScene():void
		{
			FlxG.bgColor = 0xffcc88ff;
			
			addTimeArrow();
			//initTimeRecord();
			addLevel();
			addWalls();
			addTracks();
			addPortals();
			addCrushers();
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
			lvlFunc = LevelsStore.currentFlxTilemapFunctional();
			if (Glob.kDebugOn) {add(lvlFunc);}
		}
		
		private function addWalls():void {
			wallGroup = groupFromSpawn(kSpawnWall,SprWall,lvlFunc,true);
			add(wallGroup);
		}
		
		private function addTracks():void {
			
			trackGroup = new FlxGroup();
			
			var i:uint;
			var tmpTrack:SprTrack;
			
			var tmpTrackNSGroup:FlxGroup = groupFromSpawn(kSpawnTrackNS,SprTrack,lvlFunc,true);
			for (i = 0; i < tmpTrackNSGroup.length; i++) {
				tmpTrack = tmpTrackNSGroup.members[i];
				tmpTrack.mapNS();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackNSGroup);
			
			var tmpTrackEWGroup:FlxGroup = groupFromSpawn(kSpawnTrackEW,SprTrack,lvlFunc,true);
			for (i = 0; i < tmpTrackEWGroup.length; i++) {
				tmpTrack = tmpTrackEWGroup.members[i];
				tmpTrack.mapEW();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackEWGroup);
			
			add(trackGroup);
		}
		
		private function addCrushers():void {
			
			crusherGroup = new FlxGroup();
			
			var tmpCrusherLeftGroup:FlxGroup = groupFromSpawn(kSpawnCrusherLeft,SprCrusherLeft,lvlFunc,true);
			addGroupMembersToGroup(crusherGroup,tmpCrusherLeftGroup);
			
			var tmpCrusherRightGroup:FlxGroup = groupFromSpawn(kSpawnCrusherRight,SprCrusherRight,lvlFunc,true);
			addGroupMembersToGroup(crusherGroup,tmpCrusherRightGroup);
			
			var tmpCrusherUpGroup:FlxGroup = groupFromSpawn(kSpawnCrusherUp,SprCrusherUp,lvlFunc,true);
			addGroupMembersToGroup(crusherGroup,tmpCrusherUpGroup);
			
			var tmpCrusherDownGroup:FlxGroup = groupFromSpawn(kSpawnCrusherDown,SprCrusherDown,lvlFunc,true);
			addGroupMembersToGroup(crusherGroup,tmpCrusherDownGroup);
			
			add(crusherGroup);
		}
		
		private function addGroupMembersToGroup(tmpToGroup:FlxGroup,tmpFromGroup:FlxGroup):void {
			for (var i:uint = 0; i < tmpFromGroup.length; i++) {
				tmpToGroup.add(tmpFromGroup.members[i]);
			}
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
			FlxG.collide(wallGroup,flyGroup);
			//FlxG.collide(lvlFunc,flyGroup);
			//FlxG.collide(crusherGroup,flyGroup);
			//FlxG.collide(crusherGroup,crusherGroup,crusherHitsObjectCallback);
			//FlxG.collide(lvlFunc,crusherGroup,crusherHitsObjectCallback);
			checkForDangerousFlyAndCrusherCollision();
			checkForFlyInPortal();
			//checkForCrusherGoingThroughWalls();
			checkForFlyCloneParadox();
			checkForFlyCrush();
			guideCrushersAlongTracks();
			
		}
		
		private function checkForDangerousFlyAndCrusherCollision():void {
			for (var i:uint = 0; i < flyGroup.length; i++) {
				var tmpFly:SprFly = flyGroup.members[i];
				if (!tmpFly.isDangerous()) {continue;}
				for (var j:uint = 0; j < crusherGroup.length; j++) {
					var tmpCrusher:SprCrusher = crusherGroup.members[j];
					if (tmpCrusher.overlaps(tmpFly)) {
						secondChance();
					}
				}
			}
		}
		
		private function checkForFlyInPortal():void {
			for (var i:uint = 0; i < portalGroup.length; i++) {
				var tmpPortal:SprPortal = portalGroup.members[i];
				for (var j:uint = 0; j < flyGroup.length; j++) {
					var tmpFly:SprFly = flyGroup.members[j];
					if (tmpFly.overlaps(tmpPortal)) {
						win();
					}
				}
			}
		}
		
		/*
		private function checkForCrusherGoingThroughWalls():void {
			for (var i:uint = 0; i < crusherGroup.length; i++) {
				var tmpCrusher:SprCrusher = crusherGroup.members[i];
				//if (tmpCrusher.overlaps(lvlFunc)) {
				if (tmpCrusher.overlaps(wallGroup)) {
					tmpCrusher.reverseDirection();
				}
			}
		}
		*/
		
		private function checkForFlyCloneParadox():void {
			// does the fly overlap one of its past selves?
			if (flyOverlapsClone()) {
				// oh no! this is a paradox! quickly, it's a second chance!
				secondChance();
			}
		}
		
		private function checkForFlyCrush():void {
			// has the fly being pressed on by two parallel surfaces?
			if (fly.isTouching(FlxObject.LEFT) && fly.isTouching(FlxObject.RIGHT) ||
				fly.isTouching(FlxObject.UP) && fly.isTouching(FlxObject.DOWN)) {
				// oh no! it has been crushed! quickly, it's a second chance!
				secondChance();
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
			fly.startTimeTraveling();
			//fly.disableRecording();
			/*
			fly.hideInPortal();
			fly.isTraveling = true;
			*/
			timeArrow.goFastForward();
			tintOverlay(kForwardTintColor);
		}
		
		private function travelBackward():void {
			canControlFly = false;
			spawnNewFly();
			fly.startTimeTraveling();
			//fly.disableRecording();
			/*
			fly.hideInPortal();
			fly.isTraveling = true;
			*/
			timeArrow.goFastBackward();
			tintOverlay(kBackwardTintColor);
		}
		
		private function endTimeTravel():void {
			if (!canControlFly) {
				canControlFly = true;
				fly.stopTimeTraveling();
				//fly.enableRecording();
				/*
				fly.showFromPortal();
				fly.isTraveling = false;
				fly.startRecordingAtThisFrame();
				*/
				timeArrow.goNormalForward();
				hideOverlay();
			}
		}
		
		private function spawnNewFly():void {
			/*
			fly.color = kCloneColor;
			fly.stopRecordingAtThisFrame();
			*/
			fly.clonify();
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
		
		private function groupFromSpawn(tmpSpawn:Array,tmpClass:Class,tmpLvl:FlxTilemap,tmpHide:Boolean=true):FlxGroup {
			var tmpGroup:FlxGroup = new FlxGroup();
			for (var i:uint = 0; i < tmpSpawn.length; i++) {
				var tmpArray:Array = tmpLvl.getTileInstances(tmpSpawn[i]);
				if (tmpArray) {
					for (var j:uint = 0; j < tmpArray.length; j++) {
						var _point:FlxPoint = pointForTile(tmpArray[j],tmpLvl);
						var _object:FlxObject = new tmpClass(_point.x,_point.y);
						_object.x += (tmpLvl.width/tmpLvl.widthInTiles)/2.0 - _object.width/2.0;
						_object.y += (tmpLvl.width/tmpLvl.widthInTiles)/2.0 - _object.height/2.0;
						tmpGroup.add(_object);
						if (tmpHide) {
							//tmpLvl.setTileByIndex(tmpArray[j],0);
						}
					}
				}
			}
			return tmpGroup;
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
		
		private function win():void {
			FlxG.log("you win!");
		}
		
		private function secondChance():void {
			FlxG.log("quickly, it's a second chance!");
		}
		
		/*
		private function crusherHitsObjectCallback(tmpObject:FlxObject,tmpCrusher:SprCrusher):void {
			tmpCrusher.reverseDirection();
		}
		*/
		
		private function guideCrushersAlongTracks():void {
			for (var i:uint = 0; i < crusherGroup.length; i++) {
				var tmpCrusher:SprCrusher = crusherGroup.members[i];
				var tmpTrack:SprTrack = overlappedTrackForCrusher(tmpCrusher);
				
				if (tmpTrack == null) {continue;}
				
				var tmpNextTrack:SprTrack = nextTrackAfterCrusher(tmpTrack,tmpCrusher);
				
				if (tmpNextTrack == null) {
					tmpCrusher.reverseDirection();
				}
			}
		}
		
		
		private function overlappedTrackForCrusher(tmpCrusher:SprCrusher):SprTrack {
			var tmpReturnTrack:SprTrack;
			
			for (var i:uint = 0; i < trackGroup.length; i++) {
				var tmpTrack:SprTrack = trackGroup.members[i];
								
				if (tmpTrack.overlaps(tmpCrusher) && ((tmpCrusher.isLeft && tmpTrack.canEnterW()) ||
													  (tmpCrusher.isRight && tmpTrack.canEnterE()) ||
													  (tmpCrusher.isUp && tmpTrack.canEnterS()) ||
													  (tmpCrusher.isDown && tmpTrack.canEnterN()))) {
					if (tmpReturnTrack == null) {
						tmpReturnTrack = tmpTrack;
					} else if (tmpCrusher.isLeft && tmpTrack.x > tmpReturnTrack.x ||
					           tmpCrusher.isRight && tmpTrack.x < tmpReturnTrack.x ||
							   tmpCrusher.isUp && tmpTrack.y > tmpReturnTrack.y ||
							   tmpCrusher.isDown && tmpTrack.y < tmpReturnTrack.y) {
						tmpReturnTrack = tmpTrack;
					}
				}
			}
			
			return tmpReturnTrack;
		}
		
		private function nextTrackAfterCrusher(tmpTrack:SprTrack,tmpCrusher:SprCrusher):SprTrack {
			
			if (tmpTrack == null) {return tmpTrack;}
			
			var tmpGuessPoint:FlxPoint = new FlxPoint(tmpTrack.x + tmpTrack.width/2.0,tmpTrack.y + tmpTrack.height/2.0);
			var tmpDelta:Number = tmpTrack.width;
			
			if (tmpCrusher.isLeft) {
				tmpGuessPoint.x -= tmpDelta;
			}
			else if (tmpCrusher.isRight) {
				tmpGuessPoint.x += tmpDelta;
			}
			else if (tmpCrusher.isUp) {
				tmpGuessPoint.y -= tmpDelta;
			}
			else if (tmpCrusher.isDown) {
				tmpGuessPoint.y += tmpDelta;
			}
			
			var tmpTrackAtPoint:SprTrack = trackAtPoint(tmpGuessPoint);
			if (tmpTrackAtPoint == null) {return tmpTrackAtPoint;}
			
			else if (tmpCrusher.isLeft && tmpTrackAtPoint.canEnterW()) {
				return tmpTrackAtPoint;
			}
			else if (tmpCrusher.isRight && tmpTrackAtPoint.canEnterE()) {
				return tmpTrackAtPoint;
			}
			else if (tmpCrusher.isUp && tmpTrackAtPoint.canEnterS()) {
				return tmpTrackAtPoint;
			}
			else if (tmpCrusher.isDown && tmpTrackAtPoint.canEnterN()) {
				return tmpTrackAtPoint;
			}
			
			return tmpTrackAtPoint;
		}
		
		private function trackAtPoint(tmpPoint:FlxPoint):SprTrack {
			var tmpOverlapTrack:SprTrack;
			
			for (var i:uint = 0; i < trackGroup.length; i++) {
				var tmpTrack:SprTrack = trackGroup.members[i];
				if (tmpTrack.overlapsPoint(tmpPoint)) {
					tmpOverlapTrack = tmpTrack;
					break;
				}
					
			}
			
			return tmpOverlapTrack;
		}
	}
}