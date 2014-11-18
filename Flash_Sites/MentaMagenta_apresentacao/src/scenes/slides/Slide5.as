package scenes.slides
{
	import scenes.Scene;
	
	public class Slide5 extends Scene
	{
		private var asset:Slide5Asset;
		
		public function Slide5()
		{
			
		}
		
		override public function start():void
		{
			super.start();
			asset = new Slide5Asset();
			this.addChild(asset);
			
			asset.alphaContent.gotoAndStop(1);
		}
	}
}