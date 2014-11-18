package scenes
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Scene extends Sprite
	{
		public var asset:MovieClip;
		public var _sceneManager:SceneManager;
		public var changeScene:Function;
		
		public function Scene()
		{
			super();
		}
		
		public function start(startFrame:String):void
		{
			//_sceneManager.getDisplay().addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			if(asset.alphaContent){
				var initialFrame:int;
				switch(startFrame){
					case _sceneManager.FIRST_FRAME :
						initialFrame = 1;
						break;
					case _sceneManager.LAST_FRAME :
						initialFrame = asset.alphaContent.totalFrames;
						break;
				}
				asset.alphaContent.gotoAndStop(initialFrame);
			}
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			var keyPressed:uint = event.keyCode;
			if(keyPressed == Keyboard.ENTER || keyPressed == Keyboard.SPACE || keyPressed == Keyboard.RIGHT){
				nextScene();
			}else if(keyPressed == Keyboard.LEFT){
				prevScene();
			}
			
		}
		
		protected function nextScene():void
		{
			if(asset.alphaContent){
				if(asset.alphaContent.currentFrame != asset.alphaContent.totalFrames){
					TweenLite.to(asset.alphaContent, .5, {alpha: 0, onComplete:onCompleteHideContent, onCompleteParams:["next"]});
					return;
				}
			}
			_sceneManager.nextScene();
		}
		
		protected function onCompleteHideContent(goTo:String):void
		{
			switch(goTo){
				case "next":
					asset.alphaContent.nextFrame();
					break;
				case "prev":
					asset.alphaContent.prevFrame();
					break;
			}
			TweenLite.to(asset.alphaContent, .5, {alpha: 1});
		}
		
		protected function prevScene():void
		{
			if(asset.alphaContent){
				if(asset.alphaContent.currentFrame != 1){
					TweenLite.to(asset.alphaContent, .5, {alpha: 0, onComplete:onCompleteHideContent, onCompleteParams:["prev"]});
					return;
				}
			}
			_sceneManager.prevScene();
		}
		
		public function setSceneManager(value:SceneManager):void
		{
			_sceneManager = value;
		}
		
		public function getSceneManager():SceneManager
		{
			return _sceneManager;
		}
	}
}