package scenes.slides
{
	import com.greensock.TweenLite;
	
	import scenes.Scene;
	
	public class Slide4 extends Scene
	{
		public function Slide4()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide4Asset();
			this.addChild(asset);
			super.start(startFrame);
		}
		
	}
}