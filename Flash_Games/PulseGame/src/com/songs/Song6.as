package com.songs
{
	import com.Song6Asset;
	
	import flash.display.Sprite;

	public class Song6 extends Song
	{
		
		private var song6Asset:Song6Asset = new Song6Asset();
		
		public function Song6()
		{
			super();
			this.addChild(song6Asset);
			this.x = 851;
			this.y = 260;
			this.setAsset(song6Asset);
		}
		
		override public function init():void{
			super.init();
		}
	}
}