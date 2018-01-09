package application.net 
{
	import application.dispatcher.IDispatchTarget;
	import application.net.events.PostEvent;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	/**
	 * ...
	 * @author FKSV
	 */
	public class PostSystem {
		
		private static var _instance:PostSystem;
		
		/**
		 * Для Singleton одхода
		 */
		public static function get instance():PostSystem {
			if (!_instance) _instance = new PostSystem();
			return _instance;
		}
		
		// Последовательный список на отправку
		private var _queueToSend:Vector.<PostData> = new Vector.<PostData>;
		
		// Последовательны список ожидания ответа
		private var _queueToResponse:Vector.<PostData> = new Vector.<PostData>;
		
		private var _server:String;
		private var _application:EventDispatcher;
		public var limit:uint = 5;		// Ограничение запросов
		
		public function PostSystem(application:EventDispatcher = null, server:String = null) {
			_server = server;
			_application = application;
			createPosts();
			initializeListeners();
		}
		
		protected function initializeListeners():void {
			_application.addEventListener(PostEvent.RESPONSE, onPostResponce, false, -1000);
		}
		
		protected function onPostResponce(event:PostEvent):void {
			var index:int = _queueToResponse.indexOf(event.postData);
			if (index != -1) _queueToResponse.removeAt(index);
		}
		
		/**
		 * Значение хоста сервера
		 */
		public function get server():String { return _server; }
		public function set server(value:String):void {
			_server = value;
			next();
		}
		
		private function addToQueue(postData:PostData):void {
			_queueToSend.push(postData);
		}
		
		/**
		 * Отправить запрос
		 * @param	postData
		 * @return
		 */
		public function send(postData:PostData):void {
			addToQueue(postData);
			next();
		}
		
		/*public function cancel(post:Post):Boolean {
			return PostSystem.cancel(post);
		}*/
		
		private function next():void {
			
			if (_queueToSend.length == 0) return;
			if (!hasFreePost) return;
			
			var postData:PostData = _queueToSend.shift();
			_queueToResponse.push(postData);
			
			load(postData);
		}
		
		/**
		 * Загрузить данные через @PostData
		 * @param	postData
		 * @return
		 */
		private function load(postData:PostData):Boolean {
			
			if (!postData.request.url)
				postData.request.url = server;
			
			var post:Post = getFreePost();
			if (!post) return false;
			
			post.send(postData);
			return true;
			
		}
		
		
		//
		// POSTS
		//
		
		private var _posts:Vector.<Post> = new Vector.<Post>;
		
		// Создание списка URLLoader'в
		protected function createPosts():void {
			while (limit > _posts.length) {
				var post:Post = new Post();
				post.target = _application;
				_posts.push(post);
			}
		}
		
		/**
		 * Вернуть экземпляр 
		 * @return
		 */
		protected function getFreePost():Post {
			for each(var post:Post in _posts) {
				if (post.isFree)
					return post;
			}
			return null;
		}
		
		/**
		 * Есть доступный @Post для использования
		 */
		protected function get hasFreePost():Boolean {
			for each(var post:Post in _posts) {
				if (post.isFree)
					return true;
			}
			return false;
		}
		
	}

}