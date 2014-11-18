package scenes.slides
{
	import scenes.Scene;
	
	public class Slide3 extends Scene
	{
		//private var asset:Slide3Asset;
		
		public function Slide3()
		{
			
		}
		
		override public function start():void
		{
			super.start();
			asset = new Slide3Asset();
			this.addChild(asset);
			
			asset.alphaContent.gotoAndStop(1);
		}
	}
}