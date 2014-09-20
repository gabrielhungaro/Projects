package com.scene
{
	import com.data.Debug;
	import com.data.QuizDataInfo;
	import com.elements.Button;
	import com.globo.sitio.engine.debug.Debug;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class InitScene extends Scene
	{
		private var startButton:Button;
		
		public function InitScene()
		{
			super();
		}
		
		override public function init():void
		{
			Debug.message(Debug.INFO, "init - INIT_SCENE");
			this.name = ScenesName.INIT_SCENE;
			
			backgroundContainer = new Sprite();
			this.addChild(backgroundContainer);
			
			addLoadingScreen();
			
			addArt();
		}
		
		private function addLoadingScreen():void
		{
			var loadingText:TextField = new TextField();
			loadingText.text  = " LOADING... ";
			this.addChild(loadingText);
		}
		
		private function addArt():void
		{
			var quizNameTextField:TextField = new TextField();
			quizNameTextField.text = quizData.getQuizName();
			quizNameTextField.x = quizData.getAppWidth()/2 - quizNameTextField.width/2;
			quizNameTextField.y = 50;
			this.addChild(quizNameTextField);
			
			startButton = new Button();
			startButton.setUrlButton(quizData.getUrlStartButton());
			startButton.setUrlButtonOver(quizData.getUrlStartButtonOver());
			this.addChild(startButton);
			startButton.x = quizData.getAppWidth()/2 - startButton.width/2;
			startButton.y = quizData.getAppHeight()/2;
			startButton.buttonMode = true;
			startButton.onClick.add(onClickStart);
			startButton.init();
			startButton.load();
			
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("sceneImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(quizData.getUrlStartScreen(), {name:"startScreenImage", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:backgroundContainer}));
			loader.load();
			
		}
		
		private function completeLoadImageHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "[ " +this.name + " ] - completeLoadImageHandler " + event.target.name);
		}
		
		private function completeLoadButtonImageHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "[ " +this.name + " ] - completeLoadImageHandler " + event.target.name);
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			Debug.message(Debug.ERROR, " Erro ao carregar o xml do QUIZ da ErrorID: " +  event.errorID + " || " + event.text);
		}
		
		protected function onClickStart():void
		{
			this.gotoScene(ScenesName.QUESTION_SCENE);
		}
		
		override public function destroy():void
		{
			if(startButton){
				this.removeChild(startButton);
				startButton.destroy();
				startButton = null;
			}
			while(this.numChildren > 0){
				this.removeChild(this.getChildAt(0));
			}
		}
	}
}