package scenes.slides
{
	import scenes.Scene;
	
	public class Slide21 extends Scene
	{
		public function Slide21()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide21Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}