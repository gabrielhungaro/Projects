package com.events
{
	import flash.events.Event;
	
	public class ExternalEvents extends Event
	{
		public static const ON_LOAD_MUSIC:String = "onLoadMusic";
		
		public var _music:Object;
		
		public function ExternalEvents(type:String, music:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_music = music;
			super(type, bubbles, cancelable);
		}
	}
}