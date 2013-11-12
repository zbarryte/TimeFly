package
{
	import org.flixel.FlxText;
	
	public class ZText extends FlxText
	{
		public function ZText(tmpX:Number, tmpY:Number, tmpWidth:uint, tmpText:String=null, tmpEmbeddedFont:Boolean=true)
		{
			super(tmpX, tmpY, tmpWidth, tmpText, tmpEmbeddedFont);
			color = 0xff000000;
			alignment = "center";
		}
	}
}