package info.knightrcom.state {
    import info.knightrcom.GameSocketProxy;
    import info.knightrcom.util.ListenerBinder;
    
    import mx.states.State;

    public class AbstractStateManager {

        public function AbstractStateManager(socketManager:GameSocketProxy, gameClient:CCGameClient, myState:State):void {
            this.socketProxy = socketManager;
            this.gameClient = gameClient;
            this.myState = myState;
        }

        protected var socketProxy:GameSocketProxy;
        protected var gameClient:CCGameClient;
        protected var myState:State;
        private var initialized:Boolean = false;

        /**
         *
         * @param flag
         *
         */
        protected function setInitialized(flag:Boolean):void {
            initialized = flag;
        }

        /**
         *
         * @return
         *
         */
        protected function isInitialized():Boolean {
            return initialized;
        }
        
        protected function batchBindGameEvent(eventType:uint, eventConfigs:Array):void {
    	    for (var i:int = 0; i < eventConfigs.length; i += 2) {
            	ListenerBinder.gameBind(socketProxy, eventType, eventConfigs[i], eventConfigs[i + 1]);
            }
        }
    }
}
