package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	[SWF(width="800",height="600")]
	public class LilaNaFazendaAir extends Sprite
	{
		private var mainMenu:MainMenuAsset;
		private var selectGameScreen:SelectGameAsset;
		private var englishGame:English;
		private var mathGame:Mathematic;
		private var labirintyGame:Labirinty;
		private var creditsScreen:CreditsScreenAsset;
		
		public function LilaNaFazendaAir()
		{
			init();
		}
		
		private function init():void
		{
			mainMenu = new MainMenuAsset();
			this.addChild(mainMenu);
			mainMenu.btnPlay.buttonMode = true;
			mainMenu.btnPlay.addEventListener(MouseEvent.CLICK, onClickPlay);
			mainMenu.btnPlay.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenu.btnPlay.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mainMenu.btnCredits.buttonMode = true;
			mainMenu.btnCredits.addEventListener(MouseEvent.CLICK, onClickCredits);
			mainMenu.btnCredits.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenu.btnCredits.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickCredits(event:MouseEvent):void
		{
			creditsScreen = new CreditsScreenAsset();
			this.addChild(creditsScreen);
			creditsScreen.btnBack.buttonMode = true;
			creditsScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			creditsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			creditsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickBack(event:MouseEvent):void
		{
			destroyCreditsScreen();
		}
		
		private function destroyCreditsScreen():void
		{
			if(creditsScreen){
				if(this.contains(creditsScreen)){
					creditsScreen.btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
					creditsScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					creditsScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					this.removeChild(creditsScreen);
					creditsScreen = null;
				}
			}
		}
		
		protected function onClickPlay(event:MouseEvent):void
		{
			removeMenu();
			createGameSelector();
		}
		
		private function removeMenu():void
		{
			if(mainMenu){
				if(this.contains(mainMenu)){
					this.removeChild(mainMenu);
					mainMenu = null;
				}
			}
		}
		
		private function createGameSelector():void
		{
			selectGameScreen = new SelectGameAsset();
			this.addChild(selectGameScreen);
			selectGameScreen.btnEnglish.buttonMode = true;
			selectGameScreen.btnEnglish.addEventListener(MouseEvent.CLICK, onClickEnglish);
			selectGameScreen.btnEnglish.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			selectGameScreen.btnEnglish.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			selectGameScreen.btnMath.buttonMode = true;
			selectGameScreen.btnMath.addEventListener(MouseEvent.CLICK, onClickMath);
			selectGameScreen.btnMath.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			selectGameScreen.btnMath.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			selectGameScreen.btnLabirinto.buttonMode = true;
			selectGameScreen.btnLabirinto.addEventListener(MouseEvent.CLICK, onClickLabirinty);
			selectGameScreen.btnLabirinto.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			selectGameScreen.btnLabirinto.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickLabirinty(event:MouseEvent):void
		{
			labirintyGame = new Labirinty(stage);
			labirintyGame.setOnQuitFunction(quitGame);
			this.addChild(labirintyGame);
		}
		
		protected function onClickMath(event:MouseEvent):void
		{
			mathGame = new Mathematic();
			mathGame.setOnQuitFunction(quitGame);
			this.addChild(mathGame);
		}
		
		protected function onClickEnglish(event:MouseEvent):void
		{
			englishGame = new English();
			englishGame.setOnQuitFunction(quitGame);
			this.addChild(englishGame);
		}
		
		private function quitGame():void
		{
			if(englishGame){
				if(this.contains(englishGame)){
					this.removeChild(englishGame);
					englishGame = null;
				}
			}
			if(mathGame){
				if(this.contains(mathGame)){
					this.removeChild(mathGame);
					mathGame = null;
				}
			}
			if(labirintyGame){
				if(this.contains(labirintyGame)){
					this.removeChild(labirintyGame);
					labirintyGame = null;
				}
			}
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 0; 
			glow.blurY = 0; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			Sprite(event.currentTarget).filters = [glow];
			//event.currentTarget.scaleX = event.currentTarget.scaleY -= .1; 
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0xffffff; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			Sprite(event.currentTarget).filters = [glow];
			//event.currentTarget.scaleX = event.currentTarget.scaleY += .1; 
		}
	}
}