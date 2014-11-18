package scenes.slides
{
	import scenes.Scene;
	
	public class Slide6 extends Scene
	{
		public function Slide6()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide6Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}