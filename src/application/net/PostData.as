package application.net 
{
	import application.interfaces.IEnabled;
	import application.utils.Util;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class PostData {
		
		/**
		 * Объект, который при назнечении с самого начала сперва модифицирует запрос до таких настроек
		 * и уже потом до настроек переданных через параметр @params онструктора @postData
		 */
		public static var defaultParams:Object;
		
		private var _data:Object;						// Данные для отправки { key:value }
		private var _target:IEnabled;
		private var _request:URLRequest;
		private var _response:Object;
		
		public function PostData(data:Object, target:IEnabled = null, params:Object = null) {
			
			_target = target;
			_data = data;
			
			_request = new URLRequest();
			
			Util.concatToTypecalInstance(_request, PostData.defaultParams);
			Util.concatToTypecalInstance(_request, params);
			
		}
		
		public function get data():Object { return _data; }
		public function get target():IEnabled { return _target; }
		public function get request():URLRequest { return _request; }
		
		// Объект ответ от сервера
		public function get response():Object { return _response; }
		public function set response(value:Object):void { _response = value; }
		
	}

}