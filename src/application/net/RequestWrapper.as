package application.net {
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	/**
	 * ...
	 * @author FKSV
	 */
	public class RequestWrapper {
		
		private var _request:URLRequest;
		
		public function RequestWrapper() { super(); }
		
		public function get request():URLRequest {
			if (!_request) _request = new URLRequest();
			return _request;
		}
		
	}

}