package com.data
{
	public class Debug
	{
		public static var instance:Debug;
		public static var okToCreate:Boolean;
		
		public static var debugMode:Boolean = false;
		public static var ERROR:String = " [ ERROR ] - ";
		public static var INFO:String = " [ INFO ] - ";
		public static var WARNING:String = " [ WARNING ] - ";
		
		public function Debug()
		{
			if(okToCreate == false){
				trace("Debug não pode ter mais de duas instâncias");
			}
		}
		
		public static function getInstance():Debug
		{
			if(instance == null){
				okToCreate = true;
				instance = new Debug();
				okToCreate = false;
			}
			return instance;
		}
		
		public static function message(local:String, message:*):void
		{
			if(debugMode){
				trace("[ " + local +  " ] - " + String(message));
			}
		}
	}
}