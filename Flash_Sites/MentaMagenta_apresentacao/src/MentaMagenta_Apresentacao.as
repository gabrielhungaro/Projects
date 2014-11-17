package
{
	import flash.display.Sprite;
	
	import scenes.SceneManager;
	import scenes.slides.Slide1;
	import scenes.slides.Slide2;
	
	public class MentaMagenta_Apresentacao extends Sprite
	{
		
		private var _sceneManager:SceneManager;
		
		public function MentaMagenta_Apresentacao()
		{
			_sceneManager = new SceneManager();
			_sceneManager.addSceme("slide2", new Slide2());
			_sceneManager.addSceme("slide2", new Slide3());
			_sceneManager.addSceme("slide2", new Slide4());
			_sceneManager.addSceme("slide2", new Slide5());
			_sceneManager.addSceme("slide2", new Slide6());
			
		}
	}
}