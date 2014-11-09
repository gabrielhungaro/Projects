package com.scene
{
	import com.connector.FacebookConnector;
	import com.data.Alternative;
	import com.data.Result;
	import com.elements.Button;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class RankingScene extends Scene
	{
		private var playAgain:Button;
		private var share:Button;
		private var finalResult:Result;
		private var _resultTextField:TextField;
		private var _offSetX:int = 10;
		private var _offSetY:int = 10;
		private var _containerGold:Sprite;
		private var _containerSilver:Sprite;
		private var _containerBronze:Sprite;
		
		public function RankingScene()
		{
			super();
			
			this.addEventListener( MouseEvent.CLICK , onShare );
		}
		
		protected function onShare(event:MouseEvent):void
		{
			trace(finalResult.getName() , quizData.getUrlToShare() , finalResult.getShareImgUrl() , quizData.getDescriptionShare() , quizData.getCaptionShare() );
			//FacebookConnector.getInstance().share( finalResult.getName() , quizData.getUrlToShare() , finalResult.getShareImgUrl() , quizData.getDescriptionShare() , quizData.getCaptionShare() );
		}
		
		override public function init():void
		{
			this.name = ScenesName.RANKING_SCENE;
			
			backgroundContainer = new Sprite();
			this.addChild(backgroundContainer);
			
			_containerGold = new Sprite();
			_containerSilver = new Sprite();
			_containerBronze = new Sprite();
			
			var placeHolder:Sprite = new Sprite();
			placeHolder.graphics.beginFill(0x000000, 0);
			placeHolder.graphics.drawRect(0, 0, quizData.getResultWidth(), quizData.getResultHeight());
			placeHolder.graphics.endFill();
			_containerGold.addChild(placeHolder);
			
			
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("sceneImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(quizData.getUrlRankingScreen(), {name:"rankingScreenImage", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:backgroundContainer}));
			if(quizData.getQuizType() == quizData.TYPE_QUIZ){
				loader.append( new ImageLoader(quizData.getUrlRankingGold(), {name:"goldenRanking", estimatedBytes:5000, container:_containerGold}));
				loader.append( new ImageLoader(quizData.getUrlRankingSilver(), {name:"silverRanking", estimatedBytes:5000, container:_containerSilver}));
				loader.append( new ImageLoader(quizData.getUrlRankingBronze(), {name:"bronzeRanking", estimatedBytes:5000, container:_containerBronze}));
			}
			loader.load();
			
			addButtons();
			addArt();
			//showFinalResult();
		}
		
		private function addArt():void
		{
			var correctAnswers:int = quizData.getNumberOfCorrectAnswers();
			var wrongAnswers:int = quizData.getNumberOfWrongAnswers();
			
			if(quizData.getQuizType() == quizData.TYPE_QUIZ){
				showAnswer();
			}else{
				verifyResult();
			}
		}
		
		private function showAnswer():void
		{
			finalResult = new Result();
			finalResult.calcPontuactionResult();
			this.addChild(finalResult);
			finalResult.x = quizData.getResultXPos();
			finalResult.y = quizData.getResultYPos();
			//finalResult.x = quizData.getAppWidth()/2 - finalResult.width/2;
			//finalResult.y = quizData.getAppHeight()/2 - finalResult.height/2;
			
			/*var totalOfQuestions:int = quizData.getNumberOfQuestionsToAnswer();
			var correctAnswers:int = quizData.getNumberOfCorrectAnswers();
			var finalResult:int = totalOfQuestions/correctAnswers;
			
			if(finalResult >= totalOfQuestions*.6){
				this.addChild(_containerGold);
				_containerGold.x = quizData.getAppWidth()/2 - _containerGold.width/2;
				_containerGold.y = quizData.getAppHeight()/2 - _containerGold.height/2;
			}else if(finalResult >= totalOfQuestions*.3){
				this.addChild(_containerSilver);
				_containerSilver.x = quizData.getAppWidth()/2 - _containerGold.width/2;
				_containerSilver.y = quizData.getAppHeight()/2 - _containerGold.height/2;
			}else{
				this.addChild(_containerBronze);
				_containerBronze.x = quizData.getAppWidth()/2 - _containerGold.width/2;
				_containerBronze.y = quizData.getAppHeight()/2 - _containerGold.height/2;
			}*/
			
		}
		
		private function verifyResult():void
		{
			var numberOfQuestions:int = quizData.getNumberOfQuestionsToAnswer();
			/*var stringOfAlternatives:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			var arrayOfAlternativesLetters:Array = [];
			for (var i:int = 1; i <= quizData.getNumberOfAlternatives(); i++) 
			{
				arrayOfAlternativesLetters.push(stringOfAlternatives.charAt(i-1));
			}*/
			
			var arrayOfAlternatives:Vector.<Alternative> = quizData.getAlternativesChooseds();
			/*for (var k:int = 0; k < arrayOfAlternatives.length; k++) 
			{
				//arrayOfAnswers.push(arrayOfAlternatives[k].getNumberOfChoosedTimes());
				//resultA = arrayOfAlternatives[k].getNumberOfChoosedTimes()
			}*/
			var resultA:int;
			var resultB:int;
			var resultC:int;
			var resultD:int;
			
			if(arrayOfAlternatives.length > 0){
				resultA = arrayOfAlternatives[0].getNumberOfChoosedTimes();
				resultB = arrayOfAlternatives[1].getNumberOfChoosedTimes();
				resultC = arrayOfAlternatives[2].getNumberOfChoosedTimes();
				resultD = arrayOfAlternatives[3].getNumberOfChoosedTimes();
			}else{
				resultA = Math.floor(Math.random() * quizData.getNumberOfQuestionsToAnswer());
				resultB = Math.floor(Math.random() * quizData.getNumberOfQuestionsToAnswer());
				resultC = Math.floor(Math.random() * quizData.getNumberOfQuestionsToAnswer());
				resultD = Math.floor(Math.random() * quizData.getNumberOfQuestionsToAnswer());
			}
			
			if(resultA > resultB && resultA > resultC && resultA > resultD){
				finalResult = quizData.getArrayOfResults()[0];
			}else if(resultB > resultA && resultB > resultC && resultB > resultD){
				finalResult = quizData.getArrayOfResults()[1];
			}else if(resultC > resultA && resultC > resultB && resultC > resultD){
				finalResult = quizData.getArrayOfResults()[2];
			}else if(resultD > resultA && resultD > resultB && resultD > resultC){
				finalResult = quizData.getArrayOfResults()[3];
			}else if(resultA == resultB && resultA != resultC && resultA != resultD){
				finalResult = quizData.getArrayOfResults()[4];
			}else if(resultA == resultC && resultA != resultB && resultA != resultD){
				finalResult = quizData.getArrayOfResults()[5];
			}else if(resultA == resultD && resultA != resultB && resultA != resultC){
				finalResult = quizData.getArrayOfResults()[6];
			}else if(resultB == resultC && resultB != resultA && resultB != resultD){
				finalResult = quizData.getArrayOfResults()[7];
			}else if(resultB == resultD && resultB != resultA && resultB != resultC){
				finalResult = quizData.getArrayOfResults()[8];
			}else if(resultC == resultD && resultC != resultA && resultC != resultB){
				finalResult = quizData.getArrayOfResults()[9];
			}else if(resultA == resultB && resultA != resultD){
				finalResult = quizData.getArrayOfResults()[10];
			}else if(resultA == resultB && resultA != resultC){
				finalResult = quizData.getArrayOfResults()[11];
			}else if(resultA == resultC && resultA != resultD){
				finalResult = quizData.getArrayOfResults()[12];
			}else if(resultB == resultC && resultB != resultA){
				finalResult = quizData.getArrayOfResults()[13];
			}else{
				finalResult = quizData.getArrayOfResults()[Math.random()*quizData.getArrayOfResults().length];
			}
			
			showFinalResult();
		}
		
		private function showFinalResult():void
		{
			//finalResult = quizData.getArrayOfResults()[0];
			finalResult.fillResult();
			finalResult.y = quizData.getAppHeight() - finalResult.height
			this.addChild(finalResult);
		}
		
		private function addButtons():void
		{
			/*playAgain = new Button();
			playAgain.setButtonName("PlayAgain");
			playAgain.setUrlButton(quizData.getUrlPlayAgainButton());
			playAgain.setUrlButtonOver(quizData.getUrlPlayAgainButtonOver());
			this.addChild(playAgain);
			playAgain.buttonMode = true;
			playAgain.onClick.add(onClickPlayAgain);
			playAgain.init();
			playAgain.load();
			playAgain.x = quizData.getAppWidth()/2 - playAgain.width;
			playAgain.y = quizData.getAppHeight()/2;*/
			
			share = new Button();
			share.setButtonName("Share");
			share.setUrlButton(quizData.getUrlShareButton());
			share.setUrlButtonOver(quizData.getUrlShareButtonOver());
			this.addChild(share);
			share.buttonMode = true;
			share.onClick.add(onClickShare);
			share.init();
			share.load();
			share.x = quizData.getShareButtonXPos()
			share.y = quizData.getShareButtonYPos();
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