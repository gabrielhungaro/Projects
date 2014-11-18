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
	import scenes.slides.Slide8;
	import scenes.slides.SlideConstants;
	import scenes.slides.Slide9;
	import scenes.slides.Slide10;
	import scenes.slides.Slide11;
	import scenes.slides.Slide12;
	import scenes.slides.Slide13;
	import scenes.slides.Slide14;
	import scenes.slides.Slide15;
	import scenes.slides.Slide16;
	import scenes.slides.Slide17;
	import scenes.slides.Slide18;
	import scenes.slides.Slide19;
	import scenes.slides.Slide20;
	import scenes.slides.Slide21;
	import scenes.slides.Slide22;
	import scenes.slides.Slide23;
	
	
	[SWF(width = "2048", height="1282")]
	public class MentaMagenta_Apresentacao extends Sprite
	{
		private var _sceneManager:SceneManager;
		
		public function MentaMagenta_Apresentacao()
		{
			
			_sceneManager = new SceneManager();
			_sceneManager.setDisplay(this.stage);
			_sceneManager.start();
			_sceneManager.addSceme(SlideConstants.SLIDE_2, new Slide2());
			_sceneManager.addSceme(SlideConstants.SLIDE_3, new Slide3());
			_sceneManager.addSceme(SlideConstants.SLIDE_4, new Slide4());
			_sceneManager.addSceme(SlideConstants.SLIDE_5, new Slide5());
			_sceneManager.addSceme(SlideConstants.SLIDE_6, new Slide6());
			
			_sceneManager.addSceme(SlideConstants.SLIDE_8, new Slide8());
			_sceneManager.addSceme(SlideConstants.SLIDE_9, new Slide9());
			_sceneManager.addSceme(SlideConstants.SLIDE_10, new Slide10());
			_sceneManager.addSceme(SlideConstants.SLIDE_11, new Slide11());
			_sceneManager.addSceme(SlideConstants.SLIDE_12, new Slide12());
			_sceneManager.addSceme(SlideConstants.SLIDE_13, new Slide13());
			_sceneManager.addSceme(SlideConstants.SLIDE_14, new Slide14());
			_sceneManager.addSceme(SlideConstants.SLIDE_15, new Slide15());
			_sceneManager.addSceme(SlideConstants.SLIDE_16, new Slide16());
			_sceneManager.addSceme(SlideConstants.SLIDE_17, new Slide17());
			_sceneManager.addSceme(SlideConstants.SLIDE_18, new Slide18());
			_sceneManager.addSceme(SlideConstants.SLIDE_19, new Slide19());
			_sceneManager.addSceme(SlideConstants.SLIDE_20, new Slide20());
			_sceneManager.addSceme(SlideConstants.SLIDE_21, new Slide21());
			_sceneManager.addSceme(SlideConstants.SLIDE_22, new Slide22());
			_sceneManager.addSceme(SlideConstants.SLIDE_23, new Slide23());
			
			_sceneManager.changeScene(SlideConstants.SLIDE_2);
		}
	}
}