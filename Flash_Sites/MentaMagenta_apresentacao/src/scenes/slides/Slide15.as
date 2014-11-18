package scenes.slides
{
	import scenes.Scene;
	
	public class Slide15 extends Scene
	{
		public function Slide15()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide15Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}