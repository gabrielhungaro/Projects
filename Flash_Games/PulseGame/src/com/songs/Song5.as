package com.songs
{
	import com.Song5Asset;
	
	import flash.display.Sprite;

	public class Song5 extends Song
	{
		
		private var song5Asset:Song5Asset = new Song5Asset();
		
		public function Song5()
		{
			super();
			this.addChild(song5Asset);
			this.x = 771;
			this.y = 260;
			this.setAsset(song5Asset);
		}
		
		override public function init():void{
			super.init();
		}
	}
}