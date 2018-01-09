package application.dispatcher 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class Dispatcher extends EventDispatcher implements IDispatchTarget {
		
		private var _target:IEventDispatcher;
		
		public function Dispatcher() {
			
			super();
			
		}
		
		// 
		// INTERFACE
		//
		
		/**
		 * Объект для рассылки событий
		 */
		public function get target():IEventDispatcher { return _target; }
		public function set target(value:IEventDispatcher):void { _target = value; }
		
		/**
		 * Разослать события в @target или в @this
		 * @param	event
		 */
		public function dispatch(event:Event):void {
			if (!target) {
				this.dispatchEvent(event);
			}else{
				target.dispatchEvent(event);
			}
		}
		
	}

}