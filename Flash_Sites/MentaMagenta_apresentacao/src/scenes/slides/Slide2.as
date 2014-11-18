package scenes.slides
{
	import scenes.Scene;
	
	public class Slide2 extends Scene
	{
		private var asset:Slide2Asset;
		
		public function Slide2()
		{
			
		}
		
		override public function start():void
		{
			super.start();
			
			asset = new Slide2Asset();
			this.addChild(asset);			
		}
	}
}