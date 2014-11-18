package scenes.slides
{
	import scenes.Scene;
	
	public class Slide17 extends Scene
	{
		public function Slide17()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide17Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}