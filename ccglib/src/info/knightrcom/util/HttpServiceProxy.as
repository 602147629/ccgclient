package info.knightrcom.util
{
	import info.knightrcom.service.LocalAbstractService;

	import mx.controls.Alert;
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class HttpServiceProxy
	{
        private static var isProcessing:Boolean = false;

        public function HttpServiceProxy()
		{
		}

        protected function httpFaultHandler(event:FaultEvent):void {
        	Alert.show("数据请求失败!");
        }

        /**
         * 
         * @param localService
         * @param params
         * @param service
         * @param httpResultHandler
         * @param httpFaultHandler
         * @param method
         * 
         */
        public static function send(
        		localService:LocalAbstractService,
        		params:Object = null, 
        		service:HTTPService = null,
        		httpResultHandler:Function = null, 
        		httpFaultHandler:Function = null, 
        		method:String = "POST",
                ignoreConcurrent:Boolean = false
        ):void {
            if (isProcessing && !ignoreConcurrent) {
                Alert.show("请求处理中，请稍候……");
                return;
            }
			if (service == null) {
    			service = new HTTPService();
			}
    		service.useProxy = false;
    		service.resultFormat = "e4x";
    		service.method = method;
    		if (httpResultHandler != null && !service.hasEventListener(ResultEvent.RESULT)) {
    			ListenerBinder.bind(service, ResultEvent.RESULT, httpResultHandler);
    		}
    		if (httpFaultHandler != null && !service.hasEventListener(FaultEvent.FAULT)) {
    			ListenerBinder.bind(service, FaultEvent.FAULT, httpFaultHandler);
    		}
    		ListenerBinder.bind(service, ResultEvent.RESULT, function ():void {CursorManager.removeBusyCursor(); changeProccessingFlag(false, ignoreConcurrent);});
    		ListenerBinder.bind(service, FaultEvent.FAULT, function ():void {CursorManager.removeBusyCursor(); changeProccessingFlag(false, ignoreConcurrent);});
        	// 配置内部参数
        	if (params == null) {
            	params = new Object();
         	}
         	if (localService.process != null) {
            	params.PROCESS = localService.process;
          	}
			// 配置HTTPService
            service.url = localService.remoteServerURI;
            service.method = method;
            // 发送请求
            CursorManager.removeAllCursors();
            CursorManager.setBusyCursor();
        	service.send(params);
            changeProccessingFlag(true, ignoreConcurrent);
        	trace(params);
        }

        /**
         * 
         * @param processing
         * @param ignoreConcurrent
         * 
         */
        private static function changeProccessingFlag(processing:Boolean, ignoreConcurrent:Boolean):void {
            if (ignoreConcurrent) {
                return;
            }
            isProcessing = processing;
        }
	}
}
