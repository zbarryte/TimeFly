package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{	
		protected var _children:FlxGroup;
		
		public function ZNode(tmpX:Number=0,tmpY:Number=0,tmpSimpleGraphic:Class=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			_children = new FlxGroup();
		}
		
		public function add(tmpSpr:FlxSprite):void {
			_children.add(tmpSpr);
		}
		
		override public function update():void {
			super.update();
			updateLocation();
			updateVideo();
			_children.update();
		}
		
		protected function updateLocation():void {
			FlxG.log(":: updateLocation() :: not yet implemented by " + this);
		}
		
		protected function updateVideo():void {
			FlxG.log(":: updateVideo() :: not yet implemented by " + this);
		}
	}
}