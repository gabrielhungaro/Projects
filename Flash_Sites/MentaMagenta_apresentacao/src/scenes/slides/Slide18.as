package scenes.slides
{
	import scenes.Scene;
	
	public class Slide18 extends Scene
	{
		public function Slide18()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide18Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}