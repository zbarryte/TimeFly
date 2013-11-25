package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	
	public class ZSlider extends ZNode
	{
		protected var _marker:ZNode;
		protected var _setLinkedValue:Function;
		protected var _linkedValueMax:Number;
		protected var _tickGroup:FlxGroup;
		protected var _tickDist:Number;
		
		public function ZSlider(tmpX:Number,tmpY:Number,tmpSetLinkedValue:Function,tmpLinkedValueMax:Number,tmpSimpleGraphic:Class,tmpMarker:ZNode/*=null*/)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			
			_setLinkedValue = tmpSetLinkedValue;
			_linkedValueMax = tmpLinkedValueMax;
			
			_marker = tmpMarker;
			//add(_marker);
			_marker.yLocal = -_marker.height/2.0 + height/2.0;
			
			addTicks();
			add(_marker);
		}
		
		/*override protected*/ private function addTicks():void {
			_tickGroup = new FlxGroup();
			for (var i:uint = 0; i <= _linkedValueMax; i++) {
				var tmpTick:ZNode = new ZNode();
				tmpTick.loadGraphic(GSpritinator.kSliderTick);
				tmpTick.xLocal = (width - _marker.width)*(i/_linkedValueMax) + _marker.width/2.0 - tmpTick.width/2.0;
				_tickGroup.add(tmpTick);
				tmpTick.yLocal = height/2.0 - tmpTick.height/2.0;
				add(tmpTick);
			}
			
			_tickDist = (width - _marker.width)/(_linkedValueMax);
		}
		
		public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			if (tmpPoint.x < x - _marker.width || x + width - _marker.width < tmpPoint.x ||
				tmpPoint.y < _marker.y || _marker.y + _marker.height < tmpPoint.y) {				
				return;
			}			
			_marker.xLocal = tmpPoint.x - x;
			updateLinkedValue();
		}
		
		public function snapMarker():void {
			
			var tmpDistSqMin:Number = Number.MAX_VALUE;
			var tmpX:Number;
			
			for (var i:uint = 0; i < _tickGroup.length; i++) {
				var tmpTick:ZNode = _tickGroup.members[i];
				var tmpDistSq:Number = Math.pow(tmpTick.xLocal - _marker.xLocal,2) + Math.pow(tmpTick.yLocal - _marker.yLocal,2);
				if (tmpDistSq < tmpDistSqMin) {
					tmpDistSqMin = tmpDistSq;
					tmpX = tmpTick.xLocal + tmpTick.width/2.0 - _marker.width/2.0;
				}
			}
			
			_marker.xLocal = tmpX;
			
			
			//_marker.xLocal = (width - _marker.width)*(GLeveler.num/GLeveler.numMax);
		}
		
		public function get percentageToCompletion():Number {
			return 1.0 - (width - _marker.xLocal - _marker.width)/(width - _marker.width);
		}
		
		protected function updateLinkedValue():void {
			// implemented by children
			_setLinkedValue(percentageToCompletion*(_linkedValueMax+1));
		}
		
		public function goForward():void {
			_marker.xLocal += _tickDist;
			snapMarker();
		}
		
		public function goBackward():void {
			_marker.xLocal -= _tickDist;
			snapMarker();
		}
	}
}