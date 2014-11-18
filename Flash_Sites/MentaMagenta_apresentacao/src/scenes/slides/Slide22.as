package scenes.slides
{
	import scenes.Scene;
	
	public class Slide22 extends Scene
	{
		public function Slide22()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide22Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
	}
}