package scenes
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.display.Stage;

	public class SceneManager
	{
		
		private var _listOfScenes:Vector.<Scene>;
		private var _currentScene:Scene;
		private var _currentSceneIndex:int;
		private var _display:Stage;
		
		public function SceneManager()
		{
			_listOfScenes = new Vector.<Scene>();
		}
		
		public function start():void
		{
			
		}
		
		public function addSceme(sceneName:String, scene:Scene):void
		{
			scene.name = sceneName;
			scene.setSceneManager(this);
			_listOfScenes.push(scene);
		}
		
		public function changeScene(sceneName:String):void
		{
			TweenMax.killAll();
			if(_currentScene != null){
				if(sceneName == _currentScene.name){
					return;
				}
			}
			if(_currentScene != null)
				_display.removeChild(_currentScene);
			
			_currentScene = null;
			_currentScene = getSceneByName(sceneName);
			_display.addChild(_currentScene);
			_currentScene.start();
		}
		
		public function changeSceneByIndex(sceneIndex:int):void
		{
			if(sceneIndex == _currentSceneIndex){
				return;
			}else if(_listOfScenes.length < sceneIndex){
				return;
			}else{
				if(_currentScene != null)
					_display.removeChild(_currentScene);
				
				_currentScene = null;
				_currentScene = this.getSceneByIndex(sceneIndex);
				_display.addChild(_currentScene);
				_currentScene.start();
			}
		}
		
		public function nextScene():void
		{
			_currentSceneIndex = getSceneIndexByName(_currentScene.name);
			var nextSceneIndex:int;
			if(_currentSceneIndex != _listOfScenes.length){
				nextSceneIndex = _currentSceneIndex + 1;
				changeSceneByIndex(nextSceneIndex);
			}
		}
		
		public function prevScene():void
		{
			_currentSceneIndex = getSceneIndexByName(_currentScene.name);
			var prevSceneIndex:int;
			if(_currentSceneIndex != 0){
				prevSceneIndex = _currentSceneIndex - 1;
				changeSceneByIndex(prevSceneIndex);
			}
		}
		
		public function getSceneByName(sceneName:String):Scene
		{
			var scene:Scene = null;
			for (var i:int = 0; i < _listOfScenes.length; i++) 
			{
				if(_listOfScenes[i].name == sceneName){
					scene = _listOfScenes[i];
					break;
				}
			}
			
			return scene;
		}
		
		public function getSceneByIndex(sceneIndex:int):Scene
		{
			var scene:Scene = null;
			scene = _listOfScenes[sceneIndex];
			return scene;
		}
		
		public function getSceneIndexByName(sceneName:String):int
		{
			var sceneIndex:int;
			for (var i:int = 0; i < _listOfScenes.length; i++) 
			{
				if(_listOfScenes[i].name == sceneName){
					sceneIndex = i;
					break;
				}
			}
			return sceneIndex;
		}
		
		public function setDisplay(value:Stage):void
		{
			_display = value;
		}
		
		public function getDisplay():Stage
		{
			return _display;
		}
	}
}