package scenes.slides
{
	import scenes.Scene;
	
	public class Slide14 extends Scene
	{
		public function Slide14()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide14Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}