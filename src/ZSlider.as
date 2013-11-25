package
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxGroup;
	
	public class ZSlider extends ZNode
	{
		protected var _marker:ZNode;
		
		public function ZSlider(tmpX:Number, tmpY:Number, tmpSimpleGraphic:Class, tmpMarker:ZNode/*=null*/)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			
			_marker = tmpMarker;
			//if (_marker) {
				add(_marker);
				_marker.yLocal = -_marker.height/2.0 + height/2.0;
			//}
		}
		
		public function placeMarkerAtPoint(tmpPoint:FlxPoint):void {
			if (tmpPoint.x < x - _marker.width || x + width - _marker.width < tmpPoint.x ||
				tmpPoint.y < _marker.y || _marker.y + _marker.height < tmpPoint.y) {				
				return;
			}			
			_marker.xLocal = tmpPoint.x - x;
		}
		
		public function snapMarker():void {
			// implemented by children
		}
		
		public function get percentageToCompletion():Number {
			return 1.0 - (width - _marker.xLocal - _marker.width)/(width - _marker.width);
		}
	}
}