package application.utils 
{
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author FKSV
	 */
	public class Log {
		
		// Режим работы 
		private static var _productionMode:Boolean;
		
		// Экземпляр Log для статического доступа
		private static var _instance:Log;
		
		/**
		 * экземпляр @Log
		 * @return
		 */
		public static function get instance():Log {
			if (!_instance) _instance = new Log();
			return _instance;
		}
		
		/**
		 * Лог
		 * @param	... args
		 */
		public static function log(... args):void {
			Log.instance.log(args);
		}
		
		private var _history:String;
		
		public function Log() {
			_history = "";
			_productionMode = Capabilities.playerType != "Desktop";
		}
		
		/**
		 * Вывести лог
		 * @param	array
		 */
		public function log(array:Array):void {
			if (_productionMode) return;
			addHistory(array);
			trace(array);
		}
		
		/**
		 * Добавить данные в историю
		 */
		private function addHistory(array:Array):void {
			
			var concat:String = "";
			for each(var value:* in array) {
				if (concat.length > 0) concat += ", ";
				if (value && value.hasOwnProperty("toString"))
					concat += value.toString();
			}
			
			_history += "\n\n";
		}
		
	}

}