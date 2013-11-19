package
{
	import org.flixel.FlxText;
	
	public class ZText extends FlxText
	{
		//protected var _flxText:FlxText;
		
		public function ZText(tmpX:Number, tmpY:Number, tmpWidth:uint, tmpText:String=null, tmpEmbeddedFont:Boolean=true)
		{
			//_flxText = new FlxText(tmpX, tmpY, tmpWidth, tmpText, tmpEmbeddedFont);
			super(tmpX, tmpY, tmpWidth, tmpText, tmpEmbeddedFont);
			color = 0xff000000;
			alignment = "center";
		}
		
		/*
		override public function update():void {
			super.update();
			_flxText.x = xScreen;
			_flxText.y = yScreen;
			_flxText.color = color;
			_flxText.update();
		}
		
		override public function draw():void {
			super.draw();
			_flxText.draw();
		}
		
		public function set alignment(tmpAlignment:String):void {
			_flxText.alignment = tmpAlignment;
		}
		
		public function set text(tmpText:String):void {
			_flxText.text = tmpText;
		}
		
		public function set size(tmpSize:Number):void {
			_flxText.size = tmpSize;
		}
		*/
	}
}