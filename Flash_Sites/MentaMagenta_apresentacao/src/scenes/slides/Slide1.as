package scenes.slides
{
	import scenes.Scene;
	
	public class Slide1 extends Scene
	{
		
		public function Slide1()
		{
			
		}
		
		private function start():void
		{
			this.setAsset(new Slide2Asset);
		}
	}
}