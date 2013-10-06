package
{
	import org.flixel.FlxText;
	
	public class ZText extends FlxText
	{
		public function ZText(X:Number, Y:Number, Width:uint, Text:String=null, EmbeddedFont:Boolean=true)
		{
			super(X, Y, Width, Text, EmbeddedFont);
			color = 0xff000000;
			alignment = "center";
		}
	}
}