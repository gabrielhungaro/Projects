package com.musics
{
	import com.MusicAsset;
	
	import flash.display.Sprite;

	public class Music extends Sprite
	{
		private var musicName:String;
		private var notas:Array = new Array();
		private var musicAsset:MusicAsset = new MusicAsset();
		
		public function Music()
		{
			this.addChild(musicAsset);
		}
		
		public function init():void
		{
			musicAsset.musicName.text = musicName;
		}

		public function getNotas():Array
		{
			return notas;
		}

		public function setNotas(value:Array):void
		{
			notas = value;
		}

		public function getMusicName():String
		{
			return musicName;
		}

		public function setMusicName(value:String):void
		{
			musicName = value;
		}

	}
}