package scenes.slides
{
	import scenes.Scene;
	
	public class Slide16 extends Scene
	{
		public function Slide16()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide16Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}