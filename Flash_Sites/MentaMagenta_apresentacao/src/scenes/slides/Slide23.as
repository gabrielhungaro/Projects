package scenes.slides
{
	import scenes.Scene;
	
	public class Slide23 extends Scene
	{
		public function Slide23()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide23Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}