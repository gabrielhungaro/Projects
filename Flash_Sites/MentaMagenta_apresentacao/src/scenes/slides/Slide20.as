package scenes.slides
{
	import scenes.Scene;
	
	public class Slide20 extends Scene
	{
		public function Slide20()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide20Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}