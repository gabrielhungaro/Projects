package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	[SWF(width="800",height="600")]
	public class LilaNaFazenda extends Sprite
	{
		private var mainMenu:MainMenuAsset;
		private var selectGameScreen:SelectGameAsset;
		private var englishGame:English;
		private var mathGame:Mathematic;
		private var labirintyGame:Labirinty;
		private var creditsScreen:CreditsScreenAsset;
		private var soundManager:SoundManager;
		private var artScreen:ArtScreenAsset;
		private var levelDesignScreen:LevelDesignScreenAsset;
		private var optionsScreen:OptionsScreenAsset;
		private var isMuted:Boolean = false;
		
		public function LilaNaFazenda()
		{
			init();
		}
		
		private function init():void
		{
			SoundManager.getInstance();
			SoundManager.playInit();
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
			mainMenu.btnOptions.buttonMode = true;
			mainMenu.btnOptions.addEventListener(MouseEvent.CLICK, onClickOptions);
			mainMenu.btnOptions.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenu.btnOptions.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			mainMenu.btnExit.visible = false;
			mainMenu.btnExit.alpha = 0;
			
			TweenLite.to(mainMenu.bird1, 8, {scaleX:0, scaleY:0});
			TweenLite.to(mainMenu.bird2, 15, {scaleX:0, scaleY:0});
		}
		
		protected function onClickCredits(event:MouseEvent = null):void
		{
			if(event != null){
				SoundManager.stopAll();
				SoundManager.playCredits();
			}
			creditsScreen = new CreditsScreenAsset();
			this.addChild(creditsScreen);
			creditsScreen.btnBack.buttonMode = true;
			creditsScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			creditsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			creditsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			creditsScreen.btnArt.buttonMode = true;
			creditsScreen.btnArt.addEventListener(MouseEvent.CLICK, onClickArt);
			creditsScreen.btnArt.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			creditsScreen.btnArt.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickArt(event:MouseEvent):void
		{
			destroyCreditsScreen();
			artScreen = new ArtScreenAsset();
			this.addChild(artScreen);
			artScreen.btnBack.buttonMode = true;
			artScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			artScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			artScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			artScreen.btnLevel.buttonMode = true;
			artScreen.btnLevel.addEventListener(MouseEvent.CLICK, onClickLevel);
			artScreen.btnLevel.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			artScreen.btnLevel.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickLevel(event:MouseEvent):void
		{
			destroyArtScreen();
			levelDesignScreen = new LevelDesignScreenAsset();
			this.addChild(levelDesignScreen);
			levelDesignScreen.btnBack.buttonMode = true;
			levelDesignScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			levelDesignScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			levelDesignScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function destroyLevelScreen():void
		{
			if(levelDesignScreen){
				if(this.contains(levelDesignScreen)){
					levelDesignScreen.btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
					levelDesignScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					levelDesignScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					this.removeChild(levelDesignScreen);
					levelDesignScreen = null;
				}
			}
		}
		
		private function destroyArtScreen():void
		{
			if(artScreen){
				if(this.contains(artScreen)){
					artScreen.btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
					artScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					artScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					artScreen.btnLevel.removeEventListener(MouseEvent.CLICK, onClickLevel);
					artScreen.btnLevel.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					artScreen.btnLevel.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					this.removeChild(artScreen);
					artScreen = null;
				}
			}
		}
		
		protected function onClickBack(event:MouseEvent):void
		{
			SoundManager.stopAll();
			SoundManager.playInit();
			destroyCreditsScreen();
			destroyArtScreen();
			destroyLevelScreen();
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
		
		protected function onClickPlay(event:MouseEvent = null):void
		{
			//removeMenu();
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
		
		private function removeGameSelector():void
		{
			if(selectGameScreen){
				if(this.contains(selectGameScreen)){
					this.removeChild(selectGameScreen);
					selectGameScreen = null;
				}
			}
		}
		
		protected function onClickLabirinty(event:MouseEvent):void
		{
			removeGameSelector();
			SoundManager.stopAll();
			labirintyGame = new Labirinty(stage, isMuted);
			labirintyGame.setOnQuitFunction(quitGame);
			this.addChild(labirintyGame);
		}
		
		protected function onClickMath(event:MouseEvent):void
		{
			removeGameSelector();
			SoundManager.stopAll();
			mathGame = new Mathematic(isMuted);
			mathGame.setOnQuitFunction(quitGame);
			this.addChild(mathGame);
		}
		
		protected function onClickEnglish(event:MouseEvent):void
		{
			removeGameSelector();
			SoundManager.stopAll();
			englishGame = new English(isMuted);
			englishGame.setOnQuitFunction(quitGame);
			this.addChild(englishGame);
		}
		
		private function quitGame(goToGames:Boolean = false):void
		{
			SoundManager.playInit();
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
			if(goToGames){
				onClickPlay();
			}
		}
		
		protected function onClickOptions(event:MouseEvent):void
		{
			optionsScreen = new OptionsScreenAsset();
			this.addChild(optionsScreen);
			optionsScreen.btnBack.buttonMode = true;
			optionsScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBackOptions);
			optionsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			optionsScreen.btnOn.buttonMode = true;
			optionsScreen.btnOn.addEventListener(MouseEvent.CLICK, onClickSoundOn);
			optionsScreen.btnOn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnOn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			optionsScreen.btnOff.buttonMode = true;
			optionsScreen.btnOff.addEventListener(MouseEvent.CLICK, onClickSoundOff);
			optionsScreen.btnOff.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnOff.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			if(optionsScreen){
				TweenLite.to(optionsScreen.bird1, 8, {scaleX:0, scaleY:0});
				TweenLite.to(optionsScreen.bird2, 15, {scaleX:0, scaleY:0});
			}
		}
		
		protected function onClickBackOptions(event:MouseEvent):void
		{
			removeOptionsScreen();
		}
		
		private function removeOptionsScreen():void
		{
			TweenLite.killTweensOf(optionsScreen.bird1);
			TweenLite.killTweensOf(optionsScreen.bird2);
			if(optionsScreen){
				if(this.contains(optionsScreen)){
					this.removeChild(optionsScreen);
					optionsScreen = null;
				}
			}
		}
		
		protected function onClickSoundOff(event:MouseEvent):void
		{
			isMuted = true;
			SoundManager.setIsMuted(isMuted);
		}
		
		protected function onClickSoundOn(event:MouseEvent):void
		{
			isMuted = false;
			SoundManager.setIsMuted(isMuted);
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