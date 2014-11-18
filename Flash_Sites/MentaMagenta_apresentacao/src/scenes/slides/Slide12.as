package scenes.slides
{
	import scenes.Scene;
	
	public class Slide12 extends Scene
	{
		public function Slide12()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide12Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}