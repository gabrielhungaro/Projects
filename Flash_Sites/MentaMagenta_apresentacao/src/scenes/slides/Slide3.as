package scenes.slides
{
	import scenes.Scene;
	
	public class Slide3 extends Scene
	{
		public function Slide3()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide3Asset();
			this.addChild(asset);
			super.start(startFrame);
			
			//asset.alphaContent.gotoAndStop(startFrame);
		}
	}
}