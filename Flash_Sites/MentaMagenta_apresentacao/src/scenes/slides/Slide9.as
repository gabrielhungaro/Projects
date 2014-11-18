package scenes.slides
{
	import scenes.Scene;
	
	public class Slide9 extends Scene
	{
		public function Slide9()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide9Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}