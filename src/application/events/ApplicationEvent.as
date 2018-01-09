package application.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class ApplicationEvent extends Event {
		
		public static const START:String = "applicationDestroy";
		public static const INITIALIZED:String = "applicationDestroy";
		public static const CREATED:String = "applicationCreated";
		public static const DESTROY:String = "applicationDestroy";
		
		public var application:IApplication;
		
		public function ApplicationEvent(type:String, application:IApplication) 
		{
			super(type, bubbles, cancelable);
			
			this.application = application;
			
		}
		
	}

}