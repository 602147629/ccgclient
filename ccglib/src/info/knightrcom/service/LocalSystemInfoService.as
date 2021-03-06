package info.knightrcom.service
{
	public class LocalSystemInfoService extends LocalAbstractService
	{
		public static const LOAD_GAME_RECORD:LocalAbstractService = new LocalSystemInfoService("SystemInfoService", "LOAD_GAME_RECORD");

		public static const READ_GAME_INFO:LocalAbstractService = new LocalSystemInfoService("SystemInfoService", "READ_GAME_INFO");
		
		public static const PLAY_GAME_VEDIO:LocalAbstractService = new LocalSystemInfoService("SystemInfoService", "PLAY_GAME_VEDIO");
		
		public static const GAME_ID_VALIDATE:LocalAbstractService = new LocalSystemInfoService("SystemInfoService", "GAME_ID_VALIDATE");

		public static const RETRIEVE_GAME_RUNTIME_INFO:LocalAbstractService = new LocalSystemInfoService("SystemInfoService", "RETRIEVE_GAME_RUNTIME_INFO");

		public function LocalSystemInfoService(service:String, processId:String = null)
		{
			super(service, processId);
		}
	}
}
