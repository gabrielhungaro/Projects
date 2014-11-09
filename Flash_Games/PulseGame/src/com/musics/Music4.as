package com.musics
{
	public class Music4 extends Music
	{
		
		private var notas:Array = [[2,3,5,2],[2,4,3,3],[2,3,5,4],[3,3,4,5],[4,5,2,3]];
		
		public function Music4()
		{
			
		}
		
		override public function init():void{
			this.setMusicName("Musica 4");
			this.setNotas(notas);
			super.init();
		}
	}
}