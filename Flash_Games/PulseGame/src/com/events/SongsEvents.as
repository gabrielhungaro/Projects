package com.events
{
	import com.songs.Song;
	
	import flash.events.Event;
	
	public class SongsEvents extends Event
	{
		
		public static const ON_CORRECT_SONG:String = "onCorrectSong";
		public static const ON_WRONG_SONG:String = "onCorrectSong";
		public static const ON_END_TIMER:String = "onEndTimer";
		public static const ON_OUT_SONG:String = "onOutSong";
		
		public var _song:Song;
		
		public function SongsEvents(type:String, song:Song, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_song = song;
			super(type, bubbles, cancelable);
		}
	}
}