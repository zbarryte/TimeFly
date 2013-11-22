package
{
	import org.flixel.FlxText;
	
	public class ZText extends ZNode
	{
		protected var _flxText:FlxText;
		
		public function ZText(tmpX:Number,tmpY:Number,tmpWidth:uint,tmpText:String=null,tmpEmbeddedFont:Boolean=true)
		{
			super(tmpX,tmpY);
			_flxText = new FlxText(tmpX,tmpY,tmpWidth,tmpText,tmpEmbeddedFont);
			height = _flxText.height;
			width = _flxText.width;
			//add(_flxText);
			//super(tmpX, tmpY, tmpWidth, tmpText, tmpEmbeddedFont);
			color = 0xff000000;
			alignment = "center";
		}
		
		override public function update():void {
			super.update();
			_flxText.x = x;
			_flxText.y = y;
			_flxText.color = color;
			//Glob.log(_flxText.x);
			//_flxText.update();
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
	}
}