package application.dispatcher 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public interface IDispatchTarget {
		
		/**
		 * Назначение цели @target разсылки событий
		 */
		function get target():IEventDispatcher;
		function set target(value:IEventDispatcher):void;
		
		/**
		 * Разослать событие на @target или на самого себя
		 * @param	event
		 */
		function dispatch(event:Event):void;
		
	}
	
}