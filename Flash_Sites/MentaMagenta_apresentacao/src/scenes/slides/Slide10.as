package scenes.slides
{
	import scenes.Scene;
	
	public class Slide10 extends Scene
	{
		public function Slide10()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide10Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}