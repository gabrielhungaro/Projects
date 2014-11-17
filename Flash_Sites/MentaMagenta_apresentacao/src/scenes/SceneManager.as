package scenes
{

	public class SceneManager
	{
		
		private var _listOfScenes:Vector.<Scene>;
		private var _currentScene:Scene;
		
		public function SceneManager()
		{
			_listOfScenes = new Vector.<Scene>();
			
		}
		
		public function addSceme(sceneName:String, scene:Scene):void
		{
			scene.name = sceneName;
			_listOfScenes.push(scene);
		}
		
		public function changeScene(sceneName:String):void
		{
			if(sceneName == _currentScene.name){
				return;
			}else{
				
			}
		}
	}
}