package scenes.slides
{
	import scenes.Scene;
	
	public class Slide5 extends Scene
	{
		public function Slide5()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide5Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}