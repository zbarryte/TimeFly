package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class ZNode extends FlxSprite
	{
		public function ZNode(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		override public function update():void {
			super.update();
			updateLocation();
			updateVideo();
		}
		
		protected function updateLocation():void {
			FlxG.log(":: updateLocation() :: not yet implemented by " + this);
		}
		
		protected function updateVideo():void {
			FlxG.log(":: updateVideo() :: not yet implemented by " + this);
		}
	}
}