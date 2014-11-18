package scenes.slides
{
	import scenes.Scene;
	
	public class Slide19 extends Scene
	{
		public function Slide19()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide19Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}