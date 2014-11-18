package scenes.slides
{
	import scenes.Scene;
	
	public class Slide13 extends Scene
	{
		public function Slide13()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide13Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}