package
{
	import org.flixel.*;

	public class StPlay extends ZState
	{	
		private const kSpawnWall:Array = [1,18,19,20,21,22,23,24,25,26];
		private const kSpawnPortal:Array = [2];
		private const kSpawnFly:Array = [3];
		//private const kSpawnCrusher:Array = [4,5,6,7];
		private const kSpawnCrusherUp:Array = [6];
		private const kSpawnCrusherDown:Array = [7];
		private const kSpawnCrusherLeft:Array = [4];
		private const kSpawnCrusherRight:Array = [5];
		//private const kSpawnTrack:Array = [8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26];
		
		private const kSpawnTrackNE:Array = [11,21,14,24];
		//private const kSpawnTrackNE:Array = [14,24];
		private const kSpawnTrackNS:Array = [6,7,8,18,12,22];
		private const kSpawnTrackNW:Array = [10,20,15,25];
		private const kSpawnTrackES:Array = [10,20,16,26];
		//private const kSpawnTrackNW:Array = [15,25];
		//private const kSpawnTrackES:Array = [16,26];
		private const kSpawnTrackEW:Array = [4,5,9,19,12,22];
		private const kSpawnTrackSW:Array = [11,21,13,23];
		//private const kSpawnTrackSW:Array = [13,23];
		private const kSpawnTrackNEandSW:Array = [];
		private const kSpawnTrackNWandES:Array = [];
		//private const kSpawnTrackNEandSW:Array = [11,21];
		//private const kSpawnTrackNWandES:Array = [10,20];
		
		private const kSpawnSpider:Array = [27];
		
		
		private var timeArrow:TimeArrow;
		private var timeRecord:TimeRecord;
		
		private var lvlFunc:ZTilemap;
		
		private var wallGroup:FlxGroup;
		private var trackGroup:FlxGroup;
		private var portalGroup:FlxGroup;
		private var crusherGroup:FlxGroup;
		private var flyGroup:FlxGroup;
		private var timeMeter:SprTimeMeter;
		private var spiderGroup:FlxGroup;
		
		private const kForwardTintColor:Number = 0x00ff00;
		private const kBackwardTintColor:Number = 0xff0000;
		
		private var canControlFly:Boolean;
		
		private var isPaused:Boolean;
		private var mnuPause:ZMenu;
		
		private var isDead:Boolean;
		private var mnuDead:ZMenu;
		
		private var overlay:FlxSprite;
		
		override protected function createScene():void
		{
			FlxG.bgColor = 0xff402040;
			
			addTimeArrow();
			addLevel();
			addWalls();
			addTracks();
			addPortals();
			addCrushers();
			addFlies();
			addSpiders();
			addOverlay();
			addFrame();
			addTimeMeter();
			addPauseMenu();
		}
		
		private function addTimeArrow():void {
			timeArrow = Glob.timeArrow;
			timeArrow.reset();
			add(timeArrow);
		}
		
		private function addLevel():void {
			lvlFunc = GLeveler.lvlFunc
			//if (Glob.kDebugOn) {add(lvlFunc);}
			lvlFunc.centerXY();
		}
		
		private function addWalls():void {
			wallGroup = groupFromSpawn(kSpawnWall,SprWall,lvlFunc);
			add(wallGroup);
		}
		
		private function addTracks():void {
			
			trackGroup = new FlxGroup();
			
			var i:uint;
			var tmpTrack:SprTrack;
			
			var tmpTrackNEGroup:FlxGroup = groupFromSpawn(kSpawnTrackNE,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackNEGroup.length; i++) {
				tmpTrack = tmpTrackNEGroup.members[i];
				tmpTrack.mapNE();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackNEGroup);
			
			var tmpTrackNSGroup:FlxGroup = groupFromSpawn(kSpawnTrackNS,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackNSGroup.length; i++) {
				tmpTrack = tmpTrackNSGroup.members[i];
				tmpTrack.mapNS();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackNSGroup);
			
			var tmpTrackNWGroup:FlxGroup = groupFromSpawn(kSpawnTrackNW,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackNWGroup.length; i++) {
				tmpTrack = tmpTrackNWGroup.members[i];
				tmpTrack.mapNW();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackNWGroup);
			
			var tmpTrackESGroup:FlxGroup = groupFromSpawn(kSpawnTrackES,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackESGroup.length; i++) {
				tmpTrack = tmpTrackESGroup.members[i];
				tmpTrack.mapES();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackESGroup);
			
			var tmpTrackEWGroup:FlxGroup = groupFromSpawn(kSpawnTrackEW,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackEWGroup.length; i++) {
				tmpTrack = tmpTrackEWGroup.members[i];
				tmpTrack.mapEW();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackEWGroup);
			
			var tmpTrackSWGroup:FlxGroup = groupFromSpawn(kSpawnTrackSW,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackSWGroup.length; i++) {
				tmpTrack = tmpTrackSWGroup.members[i];
				tmpTrack.mapSW();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackSWGroup);
			
			var tmpTrackNEandSWGroup:FlxGroup = groupFromSpawn(kSpawnTrackNEandSW,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackNEandSWGroup.length; i++) {
				tmpTrack = tmpTrackNEandSWGroup.members[i];
				tmpTrack.mapNE();
				tmpTrack.mapSW();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackNEandSWGroup);
			
			var tmpTrackNWandESGroup:FlxGroup = groupFromSpawn(kSpawnTrackNWandES,SprTrack,lvlFunc);
			for (i = 0; i < tmpTrackNWandESGroup.length; i++) {
				tmpTrack = tmpTrackNWandESGroup.members[i];
				tmpTrack.mapNW();
				tmpTrack.mapES();
			}
			addGroupMembersToGroup(trackGroup,tmpTrackNWandESGroup);
			
			add(trackGroup);
		}
		
		private function addCrushers():void {
			
			crusherGroup = new FlxGroup();
			/* don't add crushers*/ return;
			
			var tmpCrusherLeftGroup:FlxGroup = groupFromSpawn(kSpawnCrusherLeft,SprCrusherLeft,lvlFunc);
			addGroupMembersToGroup(crusherGroup,tmpCrusherLeftGroup);
			
			var tmpCrusherRightGroup:FlxGroup = groupFromSpawn(kSpawnCrusherRight,SprCrusherRight,lvlFunc);
			addGroupMembersToGroup(crusherGroup,tmpCrusherRightGroup);
			
			var tmpCrusherUpGroup:FlxGroup = groupFromSpawn(kSpawnCrusherUp,SprCrusherUp,lvlFunc);
			addGroupMembersToGroup(crusherGroup,tmpCrusherUpGroup);
			
			var tmpCrusherDownGroup:FlxGroup = groupFromSpawn(kSpawnCrusherDown,SprCrusherDown,lvlFunc);
			addGroupMembersToGroup(crusherGroup,tmpCrusherDownGroup);
			
			add(crusherGroup);
		}
		
		private function addGroupMembersToGroup(tmpToGroup:FlxGroup,tmpFromGroup:FlxGroup):void {
			for (var i:uint = 0; i < tmpFromGroup.length; i++) {
				tmpToGroup.add(tmpFromGroup.members[i]);
			}
		}
		
		private function addPortals():void {
			portalGroup = groupFromSpawn(kSpawnPortal,SprPortal,lvlFunc);
			add(portalGroup);
		}
		
		private function addFlies():void {
			flyGroup = groupFromSpawn(kSpawnFly,SprFly,lvlFunc);
			add(flyGroup);
		}
		
		private function get fly():SprFly {
			var tmpFly:SprFly = flyGroup.members[flyGroup.length-1];
			if (!tmpFly) {FlxG.log("ERROR :: NO FLY AT INDEX REQUESTED ::"); return null};
			return tmpFly;
		}
		
		private function addSpiders():void {
			spiderGroup = groupFromSpawn(kSpawnSpider,SprSpider,lvlFunc);
			add(spiderGroup);
		}
		
		private function addOverlay():void {
			overlay = new FlxSprite();
			overlay.makeGraphic(FlxG.width,FlxG.height);
			hideOverlay();
			add(overlay);
		}
		
		private function addFrame():void {
			var tmpFrame:ZNode = new ZNode();
			tmpFrame.loadGraphic(GSpritinator.kPlayFrame);
			add(tmpFrame);
		}
		
		private function addPauseMenu():void {
			mnuPause = new ZMenu(true);
			
			var tmpMargin:uint = 22;
			
			// CONTINUE
			var tmpCallbackContinue:Function = function():void {
				resume();
			};
			var tmpTextContinue:String = "CONTINUE";
			var tmpBtnContinue:BtnBasic = new BtnBasic(tmpCallbackContinue,tmpTextContinue);
			mnuPause.add(tmpBtnContinue);
			tmpBtnContinue.centerX();
			tmpBtnContinue.placeAtScreenYPercentage(0.22);
			
			// EXIT
			var tmpCallbackExit:Function = function():void {
				switchState(StLoad);
			};
			var tmpTextExit:String = "EXIT";
			var tmpBtnExit:BtnBasic = new BtnBasic(tmpCallbackExit,tmpTextExit);
			mnuPause.add(tmpBtnExit);
			tmpBtnExit.placeBelowSprite(tmpBtnContinue,tmpMargin);
			
			add(mnuPause);
			mnuPause.hide();
		}
		
		private function addTimeMeter():void {
			timeMeter = new SprTimeMeter();
			timeMeter.x = 16;
			timeMeter.y = 32*3;
			add(timeMeter);
		}
		
		override public function update():void {
			if (isPaused) {updatePause(); return;}
			super.update();
		}
		
		private function updatePause():void {
			if (Glob.kController.justPressed(GController.kPause)) {
				resume();
			}
			
			if (Glob.kController.justPressed(GController.kCurseForward)) {
				mnuPause.curseForward();
			}
			if (Glob.kController.justPressed(GController.kCurseBackwards)) {
				mnuPause.curseBackwards();
			}
			if (Glob.kController.justPressed(GController.kSelect)) {
				mnuPause.select();
			}
		}
		
		override protected function updateScene():void {
			updateSceneAlways();
			if (Glob.timeArrow.isFast()) {
				if (Glob.timeArrow.isForward()) {
					updateSceneFastForward();
				}
				else if (Glob.timeArrow.isBackward()) {
					updateSceneFastBackward();
				}
			}
			else if (Glob.timeArrow.isNormal() && Glob.timeArrow.isForward()) {
				updateSceneNormal();
			}
		}
			
		private function updateSceneAlways():void {
			FlxG.collide(wallGroup,flyGroup);
			checkForFlyCloneParadox();
			checkForSpiderEatingFly();
		}
		
		private function updateSceneFastForward():void {
			stopSpiders();
		}
		
		private function updateSceneFastBackward():void {
			stopSpiders();
		}
		
		private function updateSceneNormal():void {
			checkForDangerousFlyAndCrusherCollision();
			checkForFlyInPortal();
			checkForFlyCrush();
			checkForFlyNearSpider();
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
		
		override protected function updateControls():void {
			
			if (Glob.kController.justPressed(GController.kPause)) {
				pause();
			}
			
			if (canControlFly) {
				if (Glob.kController.pressed(GController.kSpeedBoost)) {
					fly.speedBoost();
				}
				
				if (Glob.kController.pressedAfter(GController.kUp,GController.kDown)) {
					fly.moveUp();
				}
				else if (Glob.kController.pressedAfter(GController.kDown,GController.kUp)) {
					fly.moveDown();
				}
				
				if (Glob.kController.pressedAfter(GController.kLeft,GController.kRight)) {
					fly.moveLeft();
				}
				else if (Glob.kController.pressedAfter(GController.kRight,GController.kLeft)) {
					fly.moveRight();
				}
			}
			
			if (Glob.kController.justPressed(GController.kTimeForward)) {
				travelForward();
			}
			else if (Glob.kController.justPressed(GController.kTimeBackward)) {
				travelBackward();
			}
			
			if (
			(!Glob.kController.pressed(GController.kTimeForward) && !Glob.kController.pressed(GController.kTimeBackward)) ||
			(Glob.timeArrow.isFast() && Glob.timeArrow.isForward() && !timeMeter.canTravelForward()) ||
			(Glob.timeArrow.isFast() && Glob.timeArrow.isBackward() && !timeMeter.canTravelBackward())) {
				endTimeTravel();
			}
		}
		
		private function travelForward():void {
			if (!timeMeter.canTravelForward()) {return;}
			canControlFly = false;
			spawnNewFly();
			fly.startTimeTraveling();
			timeArrow.goFastForward();
			tintOverlay(kForwardTintColor);
		}
		
		private function travelBackward():void {
			if (!timeMeter.canTravelBackward()) {return;}
			canControlFly = false;
			spawnNewFly();
			fly.startTimeTraveling();
			timeArrow.goFastBackward();
			tintOverlay(kBackwardTintColor);
		}
		
		private function endTimeTravel():void {
			if (!canControlFly) {
				canControlFly = true;
				fly.stopTimeTraveling();
				timeArrow.goNormalForward();
				hideOverlay();
			}
		}
		
		private function spawnNewFly():void {
			fly.clonify();
			var tmpFly:SprFly = new SprFly(fly.x,fly.y);
			flyGroup.add(tmpFly);
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
		
		private function groupFromSpawn(tmpSpawn:Array,tmpClass:Class,tmpLvl:ZTilemap):FlxGroup {
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
					}
				}
			}
			return tmpGroup;
		}
		
		private function setCallbackFromSpawn(_spawn:Array,_callback:Function,_map:ZTilemap,_hide:Boolean=true):void {
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
		
		private function pointForTile(_tile:uint,_map:ZTilemap):FlxPoint {
			var _x:Number = _map.x + (_map.width/_map.widthInTiles)*(int)(_tile%_map.widthInTiles);
			var _y:Number = _map.y + (_map.width/_map.widthInTiles)*(int)(_tile/_map.widthInTiles);
			var _point:FlxPoint = new FlxPoint(_x,_y);
			return _point;
		}
		
		private function win():void {
			isPaused = true;
			//FlxG.log("you win!");
			var tmpCallback:Function = function():void {
				GLeveler.num ++;
				switchState(StPlay);
				//FlxG.switchState(new StPlay());
			}
			FlxG.camera.fade(0xffffffff,0.22,tmpCallback);
		}
		
		private function secondChance():void {
			isPaused = true;
			var tmpCallback:Function = function():void {
				FlxG.switchState(new StPlay());
			}
			FlxG.camera.fade(0xff000000,0.22,tmpCallback);
			//FlxG.log("quickly, it's a second chance!");
		}
		
		private function pause():void {
			mnuPause.show();
			isPaused = true;
		}
		
		private function resume():void {
			mnuPause.hide();
			isPaused = false;
		}
		
		private function guideCrushersAlongTracks():void {
			for (var i:uint = 0; i < crusherGroup.length; i++) {
				var tmpCrusher:SprCrusher = crusherGroup.members[i];
				var tmpTrack:SprTrack = overlappedTrackForCrusher(tmpCrusher);
				
				if (tmpTrack == null) {continue;}
				
				var tmpNextTrack:SprTrack = nextTrackAfterCrusher(tmpTrack,tmpCrusher);
				
				if (tmpNextTrack == null) {

					tmpCrusher.x = tmpTrack.x;
					tmpCrusher.y = tmpTrack.y;
					
					changeCrusherVelocityBasedOnTrackCurve(tmpTrack,tmpCrusher);
				}
			}
		}
		
		
		private function overlappedTrackForCrusher(tmpCrusher:SprCrusher):SprTrack {
			var tmpReturnTrack:SprTrack;
			
			for (var i:uint = 0; i < trackGroup.length; i++) {
				var tmpTrack:SprTrack = trackGroup.members[i];
								
				if (tmpTrack.overlaps(tmpCrusher) && ((tmpCrusher.isLeft && tmpTrack.canEnterE()) ||
													  (tmpCrusher.isRight && tmpTrack.canEnterW()) ||
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
			
			if (tmpTrack == null) {return null;}
			
			if ((tmpCrusher.isLeft && !tmpTrack.canExitW()) ||
				(tmpCrusher.isRight && !tmpTrack.canExitE()) ||
				(tmpCrusher.isUp && !tmpTrack.canExitN()) ||
				(tmpCrusher.isDown && !tmpTrack.canExitS())) {
				return null;
			}
			
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
			
			for (var i:uint = 0; i < trackGroup.length; i++) {
				var tmpTrackAtPoint:SprTrack = trackGroup.members[i];
				if (tmpTrackAtPoint.overlapsPoint(tmpGuessPoint)) {
						
					if (tmpCrusher.isLeft && tmpTrackAtPoint.canEnterE()) {
						return tmpTrackAtPoint;
					}
					else if (tmpCrusher.isRight && tmpTrackAtPoint.canEnterW()) {
						return tmpTrackAtPoint;
					}
					else if (tmpCrusher.isUp && tmpTrackAtPoint.canEnterS()) {
						return tmpTrackAtPoint;
					}
					else if (tmpCrusher.isDown && tmpTrackAtPoint.canEnterN()) {
						return tmpTrackAtPoint;
					}
				}
			}
			
			return null;
		}
		
		private function changeCrusherVelocityBasedOnTrackCurve(tmpTrack:SprTrack,tmpCrusher:SprCrusher):void {
			
			var tmpDelta:Number = 5.0;
			
			if ((tmpTrack.x < tmpCrusher.x + tmpDelta && tmpCrusher.x - tmpDelta < tmpTrack.x) &&
				(tmpTrack.y < tmpCrusher.y + tmpDelta && tmpCrusher.y - tmpDelta < tmpTrack.y)) {
				
				if (tmpCrusher.isDown) {
					if (tmpTrack.isNE) {
						tmpCrusher.goRight();
					}
					else if (tmpTrack.isNS) {
						// do nothing, keep going
						tmpCrusher.reverseDirection();
					}
					else if (tmpTrack.isNW) {
						tmpCrusher.goLeft();
					}
				}
				else if (tmpCrusher.isUp) {
					if (tmpTrack.isNS) {
						// do nothing, keep going
						tmpCrusher.reverseDirection();
					}
					else if (tmpTrack.isES) {
						tmpCrusher.goRight();
					}
					else if (tmpTrack.isSW) {
						tmpCrusher.goLeft();
					}
				}
				else if (tmpCrusher.isLeft) {
					if (tmpTrack.isNE) {
						tmpCrusher.goUp();
					}
					else if (tmpTrack.isES) {
						tmpCrusher.goDown();
					}
					else if (tmpTrack.isEW) {
						// do nothing, keep going
						tmpCrusher.reverseDirection();
					}
				}
				else if (tmpCrusher.isRight) {
					if (tmpTrack.isNW) {
						tmpCrusher.goUp();
					}
					else if (tmpTrack.isEW) {
						// do nothing, keep going
						tmpCrusher.reverseDirection();
					}
					else if (tmpTrack.isSW) {
						tmpCrusher.goDown();
					}
				}
			
			}
		}
		
		private function checkForFlyNearSpider():void {
			for (var i:uint = 0; i < spiderGroup.length; i++) {
				var tmpSpider:SprSpider = spiderGroup.members[i];
				//tmpSpider.moveTowards(fly);
				var tmpFly:SprFly = flyClosestToSpider(tmpSpider);
				if (tmpFly != null) {
					tmpSpider.moveTowards(tmpFly);
				}/* else {
					tmpSpider.velocity.x = 0;
					tmpSpider.velocity.y = 0;
				}*/
			}
		}
		
		private function stopSpiders():void {
			for (var i:uint = 0; i < spiderGroup.length; i++) {
				var $spider:SprSpider = spiderGroup.members[i];
				$spider.velocity.x = 0;
				$spider.velocity.y = 0;
			}
		}
		
		private function flyClosestToSpider(tmpSpider:SprSpider):SprFly {
			var tmpReturnFly:SprFly;
			var tmpDistSqMin:Number = Number.MAX_VALUE;
			for (var i:uint = 0; i < flyGroup.length; i++) {
				var tmpFly:SprFly = flyGroup.members[i];
				if (!tmpFly.isDangerous()) {continue;}
				var tmpDistSq:Number = Math.pow(tmpSpider.x - tmpFly.x,2) + Math.pow(tmpSpider.y - tmpFly.y,2);
				if (tmpDistSq < tmpDistSqMin) {
					tmpDistSqMin = tmpDistSq;
					tmpReturnFly = tmpFly;
				}
			}
			return tmpReturnFly;
		}
		
		private function tintOverlay(tmpColor:Number):void {
			overlay.visible = true;
			overlay.alpha = 0.5;
			overlay.color = tmpColor;
		}
		
		private function hideOverlay():void {
			overlay.visible = false;
			overlay.alpha = 1.0;
			overlay.color = 0xffffffff;
		}
		
		private function hideOverlayPreserveTint():void {
			overlay.visible = false;
		}
		
		private function checkForSpiderEatingFly():void {
			for (var i:uint = 0; i < spiderGroup.length; i++) {
				var $spider:SprSpider = spiderGroup.members[i];
				for (var j:uint = 0; j < flyGroup.length; j++) {
					var $fly:SprFly = flyGroup.members[j];
					if ($fly.isDangerous() && $fly.overlaps($spider)) {
						secondChance();
					}
				}
			}
		}
	}
}