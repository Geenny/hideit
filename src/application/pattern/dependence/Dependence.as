package application.pattern.dependence 
{
	import application.Application;
	import application.dispatcher.Dispatcher;
	import application.interfaces.IDestroyable;
	import application.interfaces.IEnabled;
	import flash.events.IEventDispatcher;
	import application.pattern.dependence.events.DependenceEvent;
	import application.pattern.dependence.interfaces.IDependence;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class Dependence extends Dispatcher implements IDependence, IDestroyable, IEnabled 
	{
		
		private var _enabled:Boolean;
		private var _ready:Boolean;
		private var _name:String = "Base";
		private var _forced:Boolean;
		private var _list:Vector.<IDependence> = new Vector.<IDependence>;
		
		public function Dependence(dependenceList:Vector.<IDependence> = null) {
			
			initialize();
			addDependencies(dependenceList);
			
		}
		
		/**
		 * Цель для отправки событий
		 */
		override public function get target():IEventDispatcher { return Application.app; }
		
		/**
		 * Инициализация частей зависимости
		 */
		protected function initialize():void {
			target.addEventListener(DependenceEvent.READY, onSomeDependenceReady);
			target.addEventListener(DependenceEvent.CHANGE, onSomeDependenceChange);
		}
		
		// Какая то зависимость готова
		private function onSomeDependenceReady(event:DependenceEvent):void {
			if (!hasDependence(event.dependence)) return;
			forceReadyCheck();
		}
		
		// Изменение родительской зависимости
		private function onSomeDependenceChange(event:DependenceEvent):void {
			if (!hasDependence(event.dependence)) return;
			ready = false;
			forceReadyCheck();
		}
		
		/**
		 * Добавить список зависимостей
		 * @param	dependenceList
		 */
		protected function addDependencies(dependenceList:Vector.<IDependence>):void {
			if (!dependenceList || dependenceList.length == 0) return;
			for (var i:int = 0; i < dependenceList.length; i++)
				list.push(dependenceList[i]);
		}
		
		
		/* INTERFACE application.interfaces.IEnabled */
		
		public function get enabled():Boolean { return _enabled; }
		public function set enabled(value:Boolean):void { _enabled = value; }
		
		
		/* INTERFACE application.interfaces.IDestroyable */
		
		public function destroy():void {
			
		}
		
		
		/* INTERFACE wow.server.dependence.interfaces.IDependence */
		
		public function get ready():Boolean { return _ready; }
		public function set ready(value:Boolean):void { _ready = value; }
		
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		public function get list():Vector.<IDependence> { return _list; }
		
		public function get hasDependencies():Boolean { return _list.length > 0; }
		
		public function hasDependence(dependence:IDependence):Boolean {
			for each (var value:IDependence in _list) {
				if (value == dependence)
					return true;
			}
			return false;
		}
		
		public function getDependenceByName(name:String):IDependence {
			for each (var value:IDependence in _list) {
				if (value.name == name)
					return value;
			}
			return null;
		}
		
		public function get hasUnreadyDependence():Boolean {
			return Boolean(getFirstUnreadyDependence());
		}
		
		public function getFirstUnreadyDependence():IDependence {
			for each (var dependence:IDependence in _list) {
				if (dependence.ready == false)
					return dependence;
			}
			return null;
		}
		
		/**
		 * Запустить обновление данной зависимости
		 */
		public function forceReadyCheck():void {
			this
			// Форсирование неготовых зависимостей
			if (hasUnreadyDependence) {
				forceAllDependencies();
				return;
			}
			
			if (ready) return;
			
			forceStartCurrentInstance();
			
		}
		
		/**
		 * Вернуть
		 */
		protected function forceAllDependencies():void {
			for each(var dependence:IDependence in _list)
				dependence.forceReadyCheck();
		}
		
		/**
		 * 
		 */
		public function get forced():Boolean { return _forced; }
		public function set forced(value:Boolean):void { _forced = value; }
		
		
		
		//
		//
		//
		
		/**
		 * Форсирование обработки готовности текущей зависимости
		 */
		protected function forceStartCurrentInstance():void {
			ready = true;
			dispatch(new DependenceEvent(DependenceEvent.READY, this));
		}
		
	}

}