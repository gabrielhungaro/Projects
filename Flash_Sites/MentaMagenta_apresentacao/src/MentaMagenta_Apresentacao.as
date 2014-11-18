package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import scenes.SceneManager;
	import scenes.slides.Slide2;
	import scenes.slides.Slide3;
	import scenes.slides.Slide4;
	import scenes.slides.Slide5;
	import scenes.slides.Slide6;
	
	
	[SWF(width = "2048", height="1282")]
	public class MentaMagenta_Apresentacao extends Sprite
	{
		private var _sceneManager:SceneManager;
		
		public function MentaMagenta_Apresentacao()
		{
			
			_sceneManager = new SceneManager();
			_sceneManager.setDisplay(this.stage);
			_sceneManager.addSceme("slide2", new Slide2());
			_sceneManager.addSceme("slide3", new Slide3());
			_sceneManager.addSceme("slide4", new Slide4());
			_sceneManager.addSceme("slide5", new Slide5());
			_sceneManager.addSceme("slide6", new Slide6());
			_sceneManager.changeScene("slide2");
			
			var testeMc:MovieClip = new MovieClip();
			testeMc.graphics.beginFill(0x000000, 1);
			testeMc.graphics.drawRect(10, 10, 100, 100);
			testeMc.graphics.endFill();
			this.addChild(testeMc);
		}
	}
}