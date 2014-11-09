package com.songs
{
	import flash.display.Sprite;
	import com.Song3Asset;

	public class Song3 extends Song
	{
		
		private var song3Asset:Song3Asset = new Song3Asset();
		
		public function Song3()
		{
			super();
			this.addChild(song3Asset);
			this.x = 610;
			this.y = 260;
			this.setAsset(song3Asset);
		}
		
		override public function init():void{
			super.init();
		}
	}
}