package scenes.slides
{
	import scenes.Scene;
	
	public class Slide11 extends Scene
	{
		public function Slide11()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide11Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}