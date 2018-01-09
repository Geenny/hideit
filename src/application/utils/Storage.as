package application.utils 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author FKSV
	 */
	public class Storage {
		
		private static const STORAGE_NAME:String = "so";
		private static const STORAGE_PATH:String = "/";
		
		public function Storage() { }
		
		public static function store(key:String, value:*):void {
			
			var sharedObject:SharedObject = SharedObject.getLocal(STORAGE_NAME, STORAGE_PATH);
			sharedObject.data[key] = value;
			sharedObject.flush();
			
		}
		
		public static function read(key:String, defaults:* = null):Object {
			
			var sharedObject:SharedObject = SharedObject.getLocal(STORAGE_NAME, STORAGE_PATH);
			if (!sharedObject.data[key]) {
				return sharedObject.data[key];
			}
			return defaults;
			
		}
		
	}

}