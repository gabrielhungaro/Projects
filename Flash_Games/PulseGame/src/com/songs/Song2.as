package com.songs
{
	import com.Song2Asset;
	
	import flash.display.Sprite;

	public class Song2 extends Song
	{
		
		private var song2Asset:Song2Asset = new Song2Asset();
		
		public function Song2()
		{
			super();
			this.addChild(song2Asset);
			this.x = 525;
			this.y = 260;
			this.setAsset(song2Asset);
		}
		
		override public function init():void{
			super.init();
		}
	}
}