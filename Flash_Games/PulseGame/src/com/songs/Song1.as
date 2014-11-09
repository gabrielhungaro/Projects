package com.songs
{
	import com.Song1Asset;
	
	import flash.display.Sprite;

	public class Song1 extends Song
	{
		
		private var song1Asset:Song1Asset = new Song1Asset();
		
		public function Song1()
		{
			super();
			this.addChild(song1Asset);
			this.x = 445;
			this.y = 260;
			this.setAsset(song1Asset);
		}
		
		override public function init():void{
			super.init();
		}
	}
}