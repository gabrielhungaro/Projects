package com.scene
{
	import com.elements.Button;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Sprite;
	
	
	public class RankingScene extends Scene
	{
		private var playAgain:Button;
		private var share:Button;
		
		public function RankingScene()
		{
			super();
		}
		
		override public function init():void
		{
			this.name = ScenesName.RANKING_SCENE;
			
			backgroundContainer = new Sprite();
			this.addChild(backgroundContainer);
			
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("sceneImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(quizData.getUrlRankingScreen(), {name:"rankingScreenImage", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:backgroundContainer}));
			loader.load();
			
			addButtons();
		}
		
		private function addButtons():void
		{
			playAgain = new Button();
			playAgain.setUrlButton(quizData.getUrlPlayAgainButton());
			playAgain.setUrlButtonOver(quizData.getUrlPlayAgainButtonOver());
			this.addChild(playAgain);
			playAgain.x = quizData.getAppWidth()/2 - playAgain.width;
			playAgain.y = quizData.getAppHeight()/2;
			playAgain.buttonMode = true;
			playAgain.onClick.add(onClickPlayAgain);
			playAgain.init();
			playAgain.load();
			
			share = new Button();
			share.setUrlButton(quizData.getUrlShareButton());
			share.setUrlButtonOver(quizData.getUrlShareButtonOver());
			this.addChild(share);
			share.x = playAgain.x + playAgain.width + 20;
			share.y = quizData.getAppHeight()/2;
			share.buttonMode = true;
			share.onClick.add(onClickShare);
			share.init();
			share.load();
		}
		
		private function onClickShare():void
		{
			// TODO share in facebook
			
		}
		
		private function onClickPlayAgain():void
		{
			this.gotoScene(ScenesName.QUESTION_SCENE);
		}
		
		private function completeLoadImageHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
	}
}