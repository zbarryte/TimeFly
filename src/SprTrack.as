package
{
	import flash.utils.Dictionary;

	public class SprTrack extends ZNode
	{
		private const kNorth:uint = 0;
		private const kSouth:uint = 2;
		private const kEast:uint = 1;
		private const kWest:uint = 3;
		
		protected var _map:Dictionary;
		
		public function SprTrack(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{
			super(tmpX, tmpY);
			
			width = LevelsStore.kTileWidth;
			height = LevelsStore.kTileHeight;
			
			_map = new Dictionary();
		}
		
		private function doubleMap(tmpFrom:uint,tmpTo:uint):void {
			_map[tmpFrom] = tmpTo;
			_map[tmpTo] = tmpFrom;
		}
		
		public function mapNE():void {
			doubleMap(kNorth,kEast);
		}
		
		public function mapNS():void {
			doubleMap(kNorth,kSouth);
		}
		
		public function mapNW():void {
			doubleMap(kNorth,kWest);
		}
		
		public function mapES():void {
			doubleMap(kEast,kSouth);
		}
		
		public function mapEW():void {
			doubleMap(kEast,kWest);
		}
		
		public function mapSW():void {
			doubleMap(kSouth,kWest);
		}
		
		public function mapNEandSW():void {
			mapNE();
			mapSW();
		}
		
		public function mapNSandEW():void {
			mapNS();
			mapEW();
		}
		
		public function mapNWandES():void {
			mapNW();
			mapES();
		}
		
		private function mapContains(tmpCardinal:uint):Boolean {
			return (_map[tmpCardinal] != null);
		}
		
		public function canEnterN():Boolean {
			return mapContains(kNorth);
		}
		
		public function canEnterE():Boolean {
			return mapContains(kEast);
		}
		
		public function canEnterS():Boolean {
			return mapContains(kSouth);
		}
		
		public function canEnterW():Boolean {
			return mapContains(kWest);
		}
		
		public function canExitN():Boolean {
			return mapContains(kNorth);
		}
		
		public function canExitE():Boolean {
			return mapContains(kEast);
		}
		
		public function canExitS():Boolean {
			return mapContains(kSouth);
		}
		
		public function canExitW():Boolean {
			return mapContains(kWest);
		}
		
		private function doesMap(tmpTo:uint,tmpFrom:uint):Boolean {
			return (_map[tmpTo] == tmpFrom);// || _map[tmpFrom] == tmpTo);
		}
		
		public function get isNE():Boolean {
			return doesMap(kNorth,kEast);
		}
		
		public function get isNS():Boolean {
			return doesMap(kNorth,kSouth);
		}
		
		public function get isNW():Boolean {
			return doesMap(kNorth,kWest);
		}
		
		public function get isES():Boolean {
			return doesMap(kEast,kSouth);
		}
		
		public function get isEW():Boolean {
			return doesMap(kEast,kWest);
		}
		
		public function get isSW():Boolean {
			return doesMap(kSouth,kWest);
		}
	}
}