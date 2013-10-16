package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{	
		protected var _children:FlxGroup;
		protected var _hasGraphic:Boolean;
		
		public function ZNode(tmpX:Number=0,tmpY:Number=0,tmpSimpleGraphic:Class=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			_children = new FlxGroup();
			_hasGraphic = (tmpSimpleGraphic != null);
		}
		
		override public function loadGraphic(Graphic:Class, Animated:Boolean=false, Reverse:Boolean=false, Width:uint=0, Height:uint=0, Unique:Boolean=false):FlxSprite
		{
			_hasGraphic = (Graphic != null);
			return super.loadGraphic(Graphic,Animated,Reverse,Width,Height,Unique);
		}
		
		public function add(tmpChild:FlxSprite):void {
			_children.add(tmpChild);
		}
		
		override public function update():void {
			super.update();
			updateLocation();
			updateVideo();
			_children.update();
		}
		
		override public function draw():void {
			if ((_hasGraphic && visible) /*|| Glob.kDebugOn*/) {super.draw();}
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:FlxSprite = _children.members[i];
				if (!tmpChild.visible) continue;
				
				var tmpOldX:Number = tmpChild.x;
				var tmpOldY:Number = tmpChild.y;
				
				tmpChild.x = x + width/2.0 + tmpChild.x - tmpChild.width/2.0;
				tmpChild.y = y + height/2.0 + tmpChild.y - tmpChild.height/2.0;
				
				tmpChild.draw();
				
				tmpChild.x = tmpOldX;
				tmpChild.y = tmpOldY;
			}
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			_children.postUpdate();
		}
		
		override public function preUpdate():void {
			super.preUpdate();
			_children.preUpdate();
		}
		
		protected function updateLocation():void {
			//FlxG.log(":: updateLocation() :: not yet implemented by " + this);
		}
		
		protected function updateVideo():void {
			//FlxG.log(":: updateVideo() :: not yet implemented by " + this);
		}
	}
}