package
{
	import org.flixel.FlxPoint;
	
	public class ZSlider extends ZNode
	{
		protected var _marker:ZNode;
		
		public function ZSlider(tmpX:Number, tmpY:Number, tmpSimpleGraphic:Class, tmpMarker:ZNode=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			
			_marker = tmpMarker;
			if (_marker) {
				add(_marker);
				_marker.y = -_marker.height/2.0 + height/2.0;
			}
		}

		
		public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			if (tmpPoint.x < x || x + width - _marker.width < tmpPoint.x ||
				tmpPoint.y < _marker.yScreen || _marker.yScreen + _marker.height < tmpPoint.y) {				
				return;
			}			
			_marker.x = tmpPoint.x - x;
		}
		
		public function get percentageToCompletion():Number {
			return 1.0 - (x + width - _marker.xScreen - _marker.width)/(width);
		}
	}
}