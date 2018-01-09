package application 
{
	import application.net.PostData;
	import application.net.PostSystem;
	import application.storage.Settings;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequestMethod;
	import flash.utils.clearInterval;
	import wow.server.Server;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class Application extends EventDispatcher {
		
		public static var app:Application;
		
		private var _stage:Stage;
		private var _postSystem:PostSystem;
		
		public function Application(stage:Stage) {
			
			Application.app = this;
			
			_stage = stage;
			
			initialize();
			
		}
		
		private function initialize():void {
			
			PostData.defaultParams = {
				method:		URLRequestMethod.GET
			}
			
			_postSystem = new PostSystem(this);
			
			Settings.instance.initialize();
			Server.instance.initialize();
			
			//stage.addEventListener(Event.RESIZE, onApplicatioResize);
			
		}
		
		/**
		 * @Stage из корня приложения
		 */
		public function get stage():Stage { return _stage; }
		
		public function get postSystem():PostSystem { return _postSystem; }
		
		//private var applicationResizeInterval:int = 0;
		
		/**
		 * Изменение размера приложения
		 * @param	event
		 */
		/*private function onApplicatioResize(event:Event):void {
			clearApplicationResizeTimer();
			startApplicationReszi
		}
		private function clearApplicationResizeTimer():void {
			clearInterval(applicationResizeInterval);
			applicationResizeInterval = 0;
		}*/
		
	}

}