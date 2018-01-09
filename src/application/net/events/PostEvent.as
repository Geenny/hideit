package application.net.events 
{
	import application.net.PostData;
	import flash.events.Event;
	import flash.net.URLLoader;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class PostEvent extends Event {
		
		public static const RESPONSE:String = "postResponse";
		public static const ERROR:String = "postError";
		
		public var postData:PostData;
		public var loader:URLLoader;
		
		public function PostEvent(type:String, postData:PostData, loader:URLLoader ) {
			
			super(type, false, false);
			
			this.postData = postData;
			this.loader = loader;
			
		}
		
	}

}