package application.pattern.dependence.events 
{
	
	import flash.events.Event;
	import application.pattern.dependence.interfaces.IDependence;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class DependenceEvent extends Event {
		
		public static const UNREADY:String = "dependenceUnready";
		public static const READY:String = "dependenceReady";
		public static const CHANGE:String = "dependenceChange";
		
		public var dependence:IDependence;
		
		public function DependenceEvent(type:String, dependence:IDependence) {
			
			super(type, false, false);
			
			this.dependence = dependence;
			
		}
		
	}

}