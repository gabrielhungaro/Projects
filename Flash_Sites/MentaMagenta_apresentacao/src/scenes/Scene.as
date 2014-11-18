package scenes
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Scene extends Sprite
	{
		protected var asset:MovieClip;
		private var _sceneManager:SceneManager;
		public var changeScene:Function;
		
		public function Scene()
		{
			super();
		}
		
		public function start():void
		{
			//asset = new MovieClip();
			//this.addChild(asset);
			_sceneManager.getDisplay().addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			var keyPressed:uint = event.keyCode;
			if(keyPressed == Keyboard.ENTER || keyPressed == Keyboard.SPACE){
				nextScene();
			}else if(keyPressed == Keyboard.LEFT){
				prevScene();
			}
		}
		
		protected function nextScene():void
		{
			_sceneManager.nextScene();
		}
		
		protected function prevScene():void
		{
			_sceneManager.prevScene();
		}
		
		protected function setAsset(value:MovieClip):void
		{
			asset = value;
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