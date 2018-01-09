package application.storage.events 
{
	import application.storage.Settings;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class SettingsEvent extends Event 
	{
		
		public static const READ:String = "storageRead";
		public static const FLUSH:String = "storageFlush";
		public static const STORE:String = "storageStore";
		
		public var storage:Settings;
		public var key:String;
		public var value:*;
		
		public function SettingsEvent(type:String, storage:Settings = null, key:String = null, value:* = null) {
			
			super(type, false, false);
			
			this.storage = storage;
			this.key = key;
			this.value = value;
			
		}
		
	}

}