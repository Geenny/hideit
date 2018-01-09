package application.net 
{
	import application.dispatcher.Dispatcher;
	import application.interfaces.IDestroyable;
	import application.interfaces.IEnabled;
	import application.net.events.PostEvent;
	import application.utils.Log;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class Post extends Dispatcher implements IDestroyable {
		
		private var _status:uint = PostStatus.DEFAULT;
		private var _postData:PostData;
		private var _loader:URLLoader;
		private var _progress:Number = 0;
		
		public function Post() {
			createLoader();
		}
		
		/**
		 * Статус отправки запроса
		 */
		public function get status():uint { return _status; }
		
		/**
		 * Данные отправлены
		 */
		public function get sended():Boolean { return _status != PostStatus.DEFAULT && _status != PostStatus.ERROR; }
		
		/**
		 * 
		 */
		public function get request():URLRequest { return _postData.request; }
		
		/**
		 * Объект ожидающий запрос
		 */
		public function get source():IEnabled { return _postData.target; }
		
		/**
		 * Значение прогресса
		 */
		public function get progress():Number { return _progress; }
		
		/**
		 * 
		 */
		public function get postData():PostData { return _postData; }
		
		/**
		 * 
		 */
		public function get isFree():Boolean { return status == PostStatus.DEFAULT; }
		
		/**
		 * Отправить запрос
		 * @return
		 */
		public function send(postData:PostData):Boolean {
			if (sended) return false;
			_status = PostStatus.SENDING;
			_postData = postData;
			
			sendRequest();
			
			return true;
			
		}
		
		private function createLoader():void {
			_loader = new URLLoader();
			_loader.addEventListener(Event.OPEN, onConnectionOpen);
			_loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHTTPStatusResponse);
			_loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.addEventListener(Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onConnectionOpen(event:Event):void {
			_status = PostStatus.SENDED;
		}
		
		private function onHTTPStatusResponse(event:HTTPStatusEvent):void {
			_status = PostStatus.LOADING;
		}
		
		private function onProgress(event:ProgressEvent):void {
			_progress = event.bytesLoaded / event.bytesTotal;
			if (isNaN(_progress)) _progress = 0;
			if (_progress > 1) _progress = 1;
		}
		
		private function onComplete(event:Event):void {
			_status = PostStatus.LOADED;
			
			postData.response = event.target.data;
			
			dispatch(new PostEvent(PostEvent.RESPONSE, postData, event.target as URLLoader));
			
			reset();
		}
		
		private function onIOError(event:IOErrorEvent):void {
			_status = PostStatus.ERROR;
			dispatch(new PostEvent(PostEvent.ERROR, postData, event.target as URLLoader));
			reset();
		}
		
		private function onSecurityError(event:SecurityErrorEvent):void {
			_status = PostStatus.ERROR;
			dispatch(new PostEvent(PostEvent.RESPONSE, postData, event.target as URLLoader));
			reset();
		}
		
		private function reset():void {
			_status = PostStatus.DEFAULT;
		}	
		
		
		//
		private function sendRequest():void {
			_loader.load(_postData.request);
		}
		
		
		// Уничтожить загрузчик
		private function destroyLoader():void {
			if (!_loader) return;
			_loader.removeEventListener(Event.OPEN, onConnectionOpen);
			_loader.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHTTPStatusResponse);
			_loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.removeEventListener(Event.COMPLETE, onComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		//
		// INTERFACE
		//
		
		public function destroy():void {
			destroyLoader();
			dispatch(new Event(Event.DEACTIVATE));
		}
		
	}

}