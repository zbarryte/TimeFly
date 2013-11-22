package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class ZNode extends FlxSprite
	{
		public var xLocal:Number;
		public var yLocal:Number;
		
		protected var _children:FlxGroup;
		protected var _parent:ZNode;
		
		public function set parent(tmpParent:ZNode):void {
			_parent = tmpParent;
		}
		
		protected var _graphic:Class;
		
		/*
		public function get xScreen():Number {
			//if (!_parent) {return x;}
			//return _parent.xScreen + x;
			return x;
		}
		
		public function get yScreen():Number {
			//if (!_parent) {return y;}
			//return _parent.yScreen + y;
			return y;
		}
		*/
		
		public function ZNode(tmpX:Number=0,tmpY:Number=0,tmpSimpleGraphic:Class=null)
		{
			super(tmpX,tmpY,tmpSimpleGraphic);
			
			xLocal = 0;
			yLocal = 0;
						
			_children = new FlxGroup();
			_graphic = tmpSimpleGraphic;
		}
		
		override public function loadGraphic(Graphic:Class, Animated:Boolean=false, Reverse:Boolean=false, Width:uint=0, Height:uint=0, Unique:Boolean=false):FlxSprite {
			_graphic = Graphic;
			return super.loadGraphic(Graphic,Animated,Reverse,Width,Height,Unique);
		}
		
		/**
		 * Add a child (a FlxSprite of some kind) to the node.
		 * It will be displayed relative to the node, though it will be physically located at the offset.
		 * 
		 * @param	tmpSpr	The sprite to be displayed
		 * 
		 */
		public function add(tmpNode:ZNode):void {
		//public function add(tmpSpr:FlxSprite):void {
			tmpNode.parent = this;
			_children.add(tmpNode);
			//var tmpNode:ZNode = tmpSpr as ZNode;
			//if (tmpNode) {
				//tmpNode.parent = this;
			//}
		}
		
		/**
		 * Draws node and its children.
		 * Temporarily moves children into place, and then resets their values to their originals.
		 */
		/*
		override public function draw():void {
			if (visible && (_graphic != null)) {super.draw();}
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:FlxSprite = _children.members[i];
				// store original values
				var tmpX:Number = tmpChild.x;
				var tmpY:Number = tmpChild.y;
				//var tmpColor:uint = tmpChild.color;
				// offset child values
				tmpChild.x = x + tmpChild.x;
				tmpChild.y = y + tmpChild.y;
				//tmpChild.color = color;
				// draw child
				tmpChild.draw();
				// reset child's offset values to original values
				tmpChild.x = tmpX;
				tmpChild.y = tmpY;
				//tmpChild.color = tmpColor;
			}
		}
		*/
		override public function draw():void {
			if (visible && _graphic != null) {super.draw();}
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:ZNode = _children.members[i];
				tmpChild.draw();
			}
		}
		
		override public function update():void {
			super.update();
			updateMechanics();
			updateAV();
			
			/*
			x = xLocal + (parent ? parent.x : 0);
			y = yLocal + (parent ? parent.y : 0);
			*/
			
			
			if (_parent) {
				x = xLocal + _parent.x;
				y = yLocal + _parent.y;
			}
			
			
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:FlxSprite = _children.members[i];
				tmpChild.update();
			}
		}
		
		protected function updateMechanics():void {
			// implemented by children
		}
		
		protected function updateAV():void {
			// implemented by children
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			for (var i:uint = 0; i < _children.length; i++) {
				var tmpChild:FlxSprite = _children.members[i];
				tmpChild.postUpdate();
			}
		}
		
		public function placeBelowSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x;
			y = tmpSpr.y + tmpSpr.height + tmpMargin;
		}
		
		public function placeAboveSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x;
			y = tmpSpr.y - height - tmpMargin;
		}
		
		public function placeRightOfSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x + tmpSpr.width + tmpMargin;
			y = tmpSpr.y;
		}
		
		public function placeLeftOfSprite(tmpSpr:FlxSprite,tmpMargin:int=0):void {
			x = tmpSpr.x - width - tmpMargin;
			y = tmpSpr.y;
		}
		
		public function placeAtScreenXPercentage(tmpPercentage:Number):void {
			x = FlxG.width*tmpPercentage - width/2.0;
		}
		
		public function placeAtScreenYPercentage(tmpPercentage:Number):void {
			y = FlxG.height*tmpPercentage - height/2.0;
		}
		
		public function centerX():void {
			placeAtScreenXPercentage(0.5);
		}
		
		public function centerY():void {
			placeAtScreenYPercentage(0.5);
		}
		
		public function centerXY():void {
			centerX();
			centerY();
		}
		
		public function placeFarLeft():void {
			x = 0;
		}
		
		public function placeFarRight():void {
			x = FlxG.width - width;
		}
		
		public function placeFarTop():void {
			y = 0;
		}
		
		public function placeFarBottom():void {
			y = FlxG.height - height;
		}
		
		/*
		public function isPointInBoundingBox(tmpPoint:FlxPoint):Boolean {
			return !(tmpPoint.x < xScreen || xScreen + width < tmpPoint.x ||
					 tmpPoint.y < yScreen || yScreen + height < tmpPoint.y);
		}
		*/
		
		public function isPointInBoundingBox(tmpPoint:FlxPoint):Boolean {
			return !(tmpPoint.x < x || x + width < tmpPoint.x ||
				tmpPoint.y < y || y + height < tmpPoint.y);
		}
	}
}