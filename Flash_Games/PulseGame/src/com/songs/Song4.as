package com.songs
{
	import com.Song4Asset;
	
	import flash.display.Sprite;

	public class Song4 extends Song
	{
		
		private var song4Asset:Song4Asset = new Song4Asset();
		
		public function Song4()
		{
			super();
			this.addChild(song4Asset);
			this.x = 691;
			this.y = 260;
			this.setAsset(song4Asset);
		}
		
		override public function init():void{
			super.init();
		}
	}
}