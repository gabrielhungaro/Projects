package scenes.slides
{
	import scenes.Scene;
	
	public class Slide6 extends Scene
	{
		private var asset:Slide6Asset;
		
		public function Slide6()
		{
			
		}
		
		override public function start():void
		{
			super.start();
			asset = new Slide6Asset();
			this.addChild(asset);
			
			asset.alphaContent.gotoAndStop(1);
		}
	}
}