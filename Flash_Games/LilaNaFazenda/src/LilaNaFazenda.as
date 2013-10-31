package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="800",height="600")]
	public class LilaNaFazenda extends Sprite
	{
		private var mainMenu:MainMenuAsset;
		private var selectGameScreen:SelectGameAsset;
		private var englishGame:English;
		
		public function LilaNaFazenda()
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
		}
		
		protected function onClickPlay(event:MouseEvent):void
		{
			if(mainMenu){
				if(this.contains(mainMenu)){
					this.removeChild(mainMenu);
					mainMenu = null;
				}
			}
			createGameSelector();
		}
		
		private function createGameSelector():void
		{
			selectGameScreen = new SelectGameAsset();
			this.addChild(selectGameScreen);
			selectGameScreen.btnEnglish.buttonMode = true;
			selectGameScreen.btnEnglish.addEventListener(MouseEvent.CLICK, onClickEnglish);
			selectGameScreen.btnEnglish.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			selectGameScreen.btnEnglish.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickEnglish(event:MouseEvent):void
		{
			englishGame = new English();
			this.addChild(englishGame);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}