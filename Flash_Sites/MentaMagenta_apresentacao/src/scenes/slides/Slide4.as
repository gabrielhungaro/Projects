package scenes.slides
{
	import scenes.Scene;
	
	public class Slide4 extends Scene
	{
		private var asset:Slide4Asset;
		
		public function Slide4()
		{
			
		}
		
		override public function start():void
		{
			super.start();
			asset = new Slide4Asset();
			this.addChild(asset);
			
			asset.alphaContent.gotoAndStop(1);
		}
	}
}