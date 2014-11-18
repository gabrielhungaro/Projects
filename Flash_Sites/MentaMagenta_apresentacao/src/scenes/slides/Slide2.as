package scenes.slides
{
	import com.greensock.TweenLite;
	
	import scenes.Scene;
	
	public class Slide2 extends Scene
	{
		private var integrantes:IntegrantesAsset;
		
		public function Slide2()
		{
			
		}
		
		override public function start(startFrame:String):void
		{
			asset = new Slide2Asset();
			this.addChild(asset);
			super.start(startFrame);
			
			asset.integrante1.alpha = 0;
			TweenLite.to(asset.integrante1, 1, {alpha:1});
			
			asset.integrante2.alpha = 0;
			TweenLite.to(asset.integrante2, 1, {alpha:1});
			
			asset.integrante3.alpha = 0;
			TweenLite.to(asset.integrante3, 1, {alpha:1});
			
			asset.integrante4.alpha = 0;
			TweenLite.to(asset.integrante4, 1, {alpha:1});
			
			asset.integrante5.alpha = 0;
			TweenLite.to(asset.integrante5, 1, {alpha:1});
			
			asset.integrantes.stop();
			asset.integrantes.alpha = 0;
			
			var initialFrame:int;
			switch(startFrame){
				case _sceneManager.FIRST_FRAME :
					initialFrame = 1;
					break;
				case _sceneManager.LAST_FRAME :
					initialFrame = asset.integrantes.totalFrames;
					break;
			}
			asset.integrantes.gotoAndStop(initialFrame);
		}
		
		override protected function nextScene():void
		{
			if(asset.integrantes){
				if(asset.integrantes.alpha == 0){
					asset.integrantes.alpha = 1;
					return;
				}
				if(asset.integrantes.currentFrame < asset.integrantes.totalFrames){
					asset.integrantes.nextFrame();
					return;
				}
			}
			super.nextScene();
		}
		
		override protected function prevScene():void
		{
			if(asset.integrantes){
				if(asset.integrantes.alpha == 0){
					asset.integrantes.alpha = 1;
					return;
				}
				if(asset.integrantes.currentFrame != 1){
					asset.integrantes.prevFrame();
					return;
				}
			}
			super.prevScene();
		} 
	}
}