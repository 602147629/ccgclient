package info.knightrcom.service
{
    import mx.core.Application;
    import mx.utils.URLUtil;

	/**
	 *
	 *
	 *
	 */
	public class LocalAbstractService
	{

		private var serviceName:String;

		private var processId:String;

		private var uri:String;

		private static var REMOTE_SERVER_URI:String = "http://" + URLUtil.getServerNameWithPort(Application.application.loaderInfo.url) +  "/f3s/#.f3s";

        public static function set RemoteServerURI(uri:String):void {
            REMOTE_SERVER_URI = "http://" + uri +  "/f3s/#.f3s";
        }

        /**
		 *
		 * @param service
		 * @param processId
		 *
		 */
		public function LocalAbstractService(serviceName:String, processId:String)
		{
			this.serviceName=serviceName;
			this.processId=processId;
		}

		/**
		 *
		 * @return
		 *
		 */
		public function get service():String
		{
			return serviceName;
		}

		/**
		 *
		 * @return
		 *
		 */
		public function get process():String
		{
			return processId;
		}

		/**
		 *
		 * @return
		 *
		 */
		public function get remoteServerURI():String
		{
			return REMOTE_SERVER_URI.replace(/#/, serviceName);
		}

		/**
		 *
		 * @return
		 *
		 */
		public static function getRemoteServerURI(relativePath:String):String
		{
			return REMOTE_SERVER_URI.replace(/#/, relativePath);
		}
	}
}