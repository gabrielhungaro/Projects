package scenes.slides
{
	import scenes.Scene;
	
	public class Slide8 extends Scene
	{
		public function Slide8()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide8Asset();
			this.addChild(asset);	
			super.start(startFrame);
		}
	}
}