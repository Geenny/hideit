package application.storage 
{
	import application.dispatcher.Dispatcher;
	import application.storage.events.SettingsEvent;
	import application.utils.Storage;
	import application.utils.Util;
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class Settings extends Dispatcher {
		
		private static var _instance:Settings;
		
		public static function get instance():Settings {
			if (!_instance) _instance = new Settings();
			return _instance;
		}
		
		private var _timeout:int;
		private var _version:String = "1";
		private var _saved:Boolean;				// Производилось сохранение данных или нет
		private var _storage:Object;
		private var _defaultParams:Object;
		
		/**
		 * 
		 * @param	data	Данные в простов формате ключ значение
		 */
		public function Settings(defaultParams:Object = null) {
			_defaultParams = defaultParams;
		}
		
		public function initialize(defaultParams:Object = null):void {
			
			if (defaultParams) _defaultParams = defaultParams;
			if (!_defaultParams) _defaultParams = {};
			
			_storage = Storage.read("settings");
			
			if (!_storage)
				_storage = Util.concatObjects(_defaultParams, _storage);
		}
		
		
		
		/**
		 * Данные хранилища
		 */
		public function get storage():Object { return _storage; }
		
		/**
		 * Сохранялись данные
		 */
		public function get saved():Boolean { return _saved; }
		
		/**
		 * Версия
		 */
		public function get version():String { return _version; }
		
		/**
		 * Добавить в хранилище
		 * @param	key
		 * @param	value
		 * @param	timeout
		 */
		public function store(key:String, value:*, timeout:uint = 3000):void {
			_storage[key] = value;
			flush(timeout);
			dispatch(new SettingsEvent(SettingsEvent.STORE, this, key, value));
		}
		
		/**
		 * Прочитать из хранилища
		 * @param	key
		 * @return
		 */
		public function read(key:String):* {
			dispatch(new SettingsEvent(SettingsEvent.READ, this, key, storage[key]));
			return storage[key];
		}
		
		/**
		 * Запись в хранилище данных
		 * @param	timeout
		 */
		private function flush(timeout:uint = 0):void {
			_saved = false;
			if (_timeout) flushClearTimeout();
			if (timeout > 0) {
				_timeout = setTimeout(flush, timeout)
			}else{
				_saved = true;
				_timeout = 0;
				flushClearTimeout();
				Storage.store("settings", storage);
				dispatch(new SettingsEvent(SettingsEvent.FLUSH, this));
			}
		}
		private function flushClearTimeout():void {
			clearTimeout(_timeout);
		}
		
	}

}