package com.scene
{
	import com.data.Alternative;
	import com.data.Debug;
	import com.data.FontEmbeder;
	import com.data.Question;
	import com.elements.Button;
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class QuestionScene extends Scene
	{
		private var mcQuestion:MovieClip;
		private var mcAlternativeContainer:Sprite;
		private var alternative:Alternative;
		private var alternativeTextField:TextField;
		private var questionTextField:TextField;
		private var questionNumberTextField:TextField;
		private var continueButton:Button;
		
		private var currentQuestion:Question;
		private var arrayOfQuestion:Array;
		private var arrayOfAlternatives:Vector.<Alternative>;
		private var questionNumber:int;
		private var numberOfQuestions:int;
		private var numberOfAlternatives:int;
		private var alternativeOverLabel:Boolean;
		private var OUT:String;
		private var OVER:String;
		private var arrayOfAnwsers:Array;
		private var CORRECT:String;
		private var WRONG:String;
		private var numberOfCorrectAnswers:int;
		private var numberOfWrongAnswers:int;
		private var offSetX:Number;
		private var offSetY:Number;
		private var numberOfCols:int;
		private var numberOfLines:int;
		private var _continueButtonAvaliable:Boolean;
		private var _alternativeChoosed:Object;
		private var _alternativeAlreadyChoosed:Boolean;
		private var _navigator:Navigator;
		
		public function QuestionScene()
		{
			super();
		}
		
		override public function init():void
		{
			questionNumber = 1;
			quizData.setActualQuestion(questionNumber);
			numberOfQuestions = 0;
			numberOfAlternatives = 4;
			alternativeOverLabel;
			OUT = "out";
			OVER = "over";
			CORRECT = "correct";
			WRONG = "wrong";
			numberOfCorrectAnswers = 0;
			numberOfWrongAnswers = 0;
			offSetX = 20;
			offSetY = 20;
			numberOfCols = 2;
			numberOfLines = 2;
			
			this.name = ScenesName.QUESTION_SCENE
			arrayOfAlternatives = new Vector.<Alternative>;
			arrayOfAnwsers = [];
			
			numberOfQuestions = quizData.getNumberOfQuestionsToAnswer();
			
			backgroundContainer = new Sprite();
			this.addChild(backgroundContainer);
			
			mcQuestion = new MovieClip();
			mcQuestion.graphics.beginFill(0x606060, 0);
			mcQuestion.graphics.drawRect(0, 0, quizData.getAppWidth() - offSetX*6, quizData.getAppHeight()/8);
			mcQuestion.graphics.endFill();
			//mcQuestion.x = (quizData.getAppWidth() - mcQuestion.width)/2;
			//mcQuestion.y = (quizData.getAppHeight()/8)*2;
			mcQuestion.x = quizData.getQuestionNumberXPos();
			mcQuestion.y = quizData.getQuestionNumberYPos();
			this.addChild(mcQuestion);
			questionTextField = new TextField();
			questionNumberTextField = new TextField();
			
			mcAlternativeContainer = new Sprite();
			mcAlternativeContainer.graphics.beginFill(0x303030, 0);
			//mcAlternativeContainer.graphics.drawRect(0, 0, quizData.getAppWidth() - offSetX*2, quizData.getAppHeight() - (mcQuestion.height + offSetY*2.5));
			//mcAlternativeContainer.graphics.drawRect(0, 0, mcQuestion.width, quizData.getAppHeight() - ((mcQuestion.y + mcQuestion.height) + offSetY*6));
			mcAlternativeContainer.graphics.drawRect(0, 0, mcQuestion.width, quizData.getAlternativeHeight()*2 + offSetY*3);
			mcAlternativeContainer.graphics.endFill();
			//mcAlternativeContainer.x = mcQuestion.x;
			//mcAlternativeContainer.y = mcQuestion.y + mcQuestion.height + offSetY/2;
			//mcAlternativeContainer.y = mcQuestion.y + mcQuestion.height + offSetY/2;
			mcAlternativeContainer.x = quizData.getAlternativeXPos();
			mcAlternativeContainer.y = quizData.getAlternativeYPos();
			this.addChild(mcAlternativeContainer);
			
			if(quizData.getUrlContinueButton() != quizData.getImagePath() && quizData.getUrlContinueButton() != null){
				continueButton = new Button(quizData.getContinueButtonWidth(), quizData.getContinueButtonHeight());
				continueButton.setButtonName("continue");
				continueButton.setUrlButton(quizData.getUrlContinueButton());
				continueButton.setUrlButtonOver(quizData.getUrlContinueButtonOver());
				continueButton.onClick.add(onClickContinue);
				continueButton.init();
				continueButton.load();
				this.addChild(continueButton);
				//continueButton.x = mcQuestion.width - continueButton.width/2;
				//continueButton.y = mcAlternativeContainer.y + mcAlternativeContainer.height + offSetY;
				continueButton.x = quizData.getContinueXPos();
				continueButton.y = quizData.getContinueYPos();
				continueButton.buttonMode = true;
				_continueButtonAvaliable = true;
				turnContinueAvaliableOff();
			}else{
				_continueButtonAvaliable = false;
			}
			
			_navigator = new Navigator();
			this.addChild(_navigator);
			_navigator.init();
			_navigator.x = quizData.getNavigatorXPos();
			_navigator.y = quizData.getNavigatorYPos();
			
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("sceneImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(quizData.getUrlQuestionScreen(), {name:"questionScreenImage", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:backgroundContainer}));
			loader.load();
			
			changeQuestion();
			//fillQuestion();
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function completeLoadImageHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "[ " + this.name + " ] - completeLoadImageHandler " + event.target.name);
		}
		
		private function onClickContinue():void
		{
			if(_alternativeAlreadyChoosed){
				if(quizData.getQuizType() == quizData.TYPE_QUIZ){
					verifyAlternative(_alternativeChoosed);
				}
				removeListeners();
				clearQuestionAndAlternatives();
			}
		}
		
		private function turnContinueAvaliableOff():void
		{
			if(quizData.getUrlContinueButton() != quizData.getImagePath() && quizData.getUrlContinueButton() != null){
				continueButton.mouseChildren = continueButton.mouseEnabled = false;
				continueButton.alpha = .5;
			}
		}
		
		private function turnContinueAvaliableOn():void
		{
			if(quizData.getUrlContinueButton() != quizData.getImagePath() && quizData.getUrlContinueButton() != null){
				continueButton.mouseChildren = continueButton.mouseEnabled = true;
				continueButton.alpha = 1;
			}else{
				removeListeners();
			}
		}
		
		private function fillQuestion():void
		{
			_navigator.updateNavigator();
			arrayOfQuestion = quizData.getArrayOfQuestions();
			
			var randomQuestionNumber:int = Math.floor(Math.random()*arrayOfQuestion.length);
			var question:Question = arrayOfQuestion[randomQuestionNumber];
			
			questionNumberTextField.text = quizData.getQuestionNumberPrefix() + String(questionNumber);
			questionNumberTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(quizData.getQuestionNumberFont(), quizData.getQuestionNumberSize()));
			questionNumberTextField.selectable = false;
			questionNumberTextField.autoSize = "left";
			questionNumberTextField.multiline = true;
			questionNumberTextField.textColor = quizData.getQuestionNumberColor();
			//questionNumberTextField.x = quizData.getQuestionNumberXPos();
			//questionNumberTextField.y = quizData.getQuestionNumberYPos();
			mcQuestion.addChild(questionNumberTextField);
			
			questionTextField.text = question.getQuestion();
			questionTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(quizData.getQuestionFont(), quizData.getQuestionSize()));
			questionTextField.selectable = false;
			questionTextField.autoSize = "left";
			questionTextField.multiline = true;
			questionTextField.textColor = quizData.getQuestionColor();
			questionTextField.width = mcQuestion.width - offSetX;
			//questionTextField.x = questionNumberTextField.x + questionNumberTextField.textWidth + offSetX;
			questionTextField.x = quizData.getQuestionXPos();
			questionTextField.y = quizData.getQuestionYPos();
			mcQuestion.addChild(questionTextField);
			currentQuestion = question;
			arrayOfQuestion.splice(randomQuestionNumber, 1);
			
			var lines:int = 0;
			var cols:int = 0;
			
			for (var j:int = 0; j < numberOfAlternatives; j++) 
			{
				if(arrayOfAlternatives.length < numberOfAlternatives){
					alternative = new Alternative(quizData.getAlternativeWidth(), quizData.getAlternativeHeight());
					arrayOfAlternatives.push(alternative);
					mcAlternativeContainer.addChild(alternative);
					alternative.buttonMode = true;
					alternative.addEventListener(MouseEvent.CLICK, onClickAlternative);
					alternative.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					alternative.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					
					alternative.alternativeText = question.getAlternativeArray()[j];
					alternative.alternativeLetter = question.getAlternativeLettersArray()[j];
					alternative.fillAlternative();
				}
				//alternative.alpha = 0;
				
				arrayOfAlternatives[j].alternativeText = question.getAlternativeArray()[j];
				arrayOfAlternatives[j].alternativeLetter = question.getAlternativeLettersArray()[j];
				arrayOfAlternatives[j].fillAlternative();
				
				//alternative.x = numberOfCols
				
				/*var middleOfAlternativeList:int = (numberOfCols * arrayOfAlternatives[j].width)/2;
				var initialPosX:int = (mcAlternativeContainer.width/2) - middleOfAlternativeList;
				arrayOfAlternatives[j].x = initialPosX + (arrayOfAlternatives[j].width*cols);*/
				
				arrayOfAlternatives[j].x = offSetX*(cols) + (mcAlternativeContainer.width/2*cols);
				arrayOfAlternatives[j].y = offSetY*(lines+1) + (quizData.getAlternativeHeight()*lines);
				if(cols == numberOfCols-1){
					cols = 0;
					lines++;
				}else{
					cols++;
				}
			}
		}
		
		private function onClickAlternative(event:MouseEvent):void
		{
			//removeListeners();
			completeTweenOnQuestion();
			_alternativeAlreadyChoosed = true;
			_alternativeChoosed = event.currentTarget;
			for (var j:int = 0; j < arrayOfAlternatives.length; j++) 
			{
				if(arrayOfAlternatives[j].alternativeLetter == _alternativeChoosed.alternativeLetter){
					event.currentTarget.setIsSelected(true);
				}else{
					arrayOfAlternatives[j].setIsSelected(false);
				}
				arrayOfAlternatives[j].updateAnswerStatus(OUT);
			}
			turnContinueAvaliableOn();
			if(quizData.getQuizType() == quizData.TYPE_QUIZ){
				if(!_continueButtonAvaliable){
					verifyAlternative(event.currentTarget);
				}
			}else{
				verifyResult(event.currentTarget);
			}
		}
		
		private function verifyResult(alternative:Object):void
		{
			//removeListeners();
			var letter:String = alternative.alternativeLetter;
			letter = letter.split(" ")[0];
			alternative.updateAnswerStatus(CORRECT);
			
			for (var j:int = 0; j < arrayOfAlternatives.length; j++) 
			{
				if(arrayOfAlternatives[j].alternativeLetter == alternative.alternativeLetter){
					arrayOfAlternatives[j].updateAnswerStatus(CORRECT);
				}else if(arrayOfAlternatives[j].alternativeLetter != letter){
					arrayOfAlternatives[j].setIsSelected(false);
					arrayOfAlternatives[j].updateAnswerStatus(OUT);
				}
			}
			
			alternative.addChoosedTime();
			//quizData.setAlternativeChoosed(letter);
			if(!_continueButtonAvaliable){
				clearQuestionAndAlternatives();
			}
		}
		
		private function clearQuestionAndAlternatives():void
		{
			for (var j:int = 0; j < arrayOfAlternatives.length; j++) 
			{
				TweenLite.to(arrayOfAlternatives[j], .5, {alpha:0, delay: 2});
			}
			questionNumber += 1;
			quizData.setActualQuestion(questionNumber);
			TweenLite.to(alternative, .5, {alpha:0, delay: 2});
			TweenLite.to(questionTextField, .5, {alpha:0, delay: 2, onComplete:completeTweenOfQuestion});
		}
		
		private function verifyAlternative(alternative:Object):void
		{
			var letter:String = alternative.alternativeLetter;
			letter = letter.split(" ")[0];
			removeListeners();
			
			if(letter == currentQuestion.getCorrectAlternative()){
				alternative.updateAnswerStatus(CORRECT);
				arrayOfAnwsers.push(CORRECT);
				numberOfCorrectAnswers++;
			}else{
				alternative.updateAnswerStatus(WRONG)
				arrayOfAnwsers.push(WRONG);
				numberOfWrongAnswers++;
			}
			
			for (var j:int = 0; j < arrayOfAlternatives.length; j++) 
			{
				if(arrayOfAlternatives[j].alternativeLetter == currentQuestion.getCorrectAlternative()){
					arrayOfAlternatives[j].updateAnswerStatus(CORRECT);
					TweenLite.to(arrayOfAlternatives[j], .5, {alpha:0, delay: 2});
				}else if(arrayOfAlternatives[j].alternativeLetter != letter){
					arrayOfAlternatives[j].updateAnswerStatus(OUT);
					TweenLite.to(arrayOfAlternatives[j], .5, {alpha:0, delay: 2});
				}
			}
			//questionNumber += 1;
			TweenLite.to(alternative, .5, {alpha:0, delay: 2});
			TweenLite.to(questionTextField, .5, {alpha:0, delay: 2, onComplete:completeTweenOfQuestion});
		}
		
		private function addAlternativeListeners():void
		{
			for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
			{
				arrayOfAlternatives[i].buttonMode = true;
				arrayOfAlternatives[i].addEventListener(MouseEvent.CLICK, onClickAlternative);
				arrayOfAlternatives[i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				arrayOfAlternatives[i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		private function removeListeners():void
		{
			turnContinueAvaliableOff();
			for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
			{
				arrayOfAlternatives[i].buttonMode = false;
				arrayOfAlternatives[i].removeEventListener(MouseEvent.CLICK, onClickAlternative);
				arrayOfAlternatives[i].removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				arrayOfAlternatives[i].removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		private function completeTweenOfQuestion():void
		{
			changeQuestion();
		}
		
		private function completeTweenOnQuestion():void
		{
			for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
			{
				TweenLite.killTweensOf(arrayOfAlternatives[i]);
			}
			TweenLite.killTweensOf(questionTextField);
			addAlternativeListeners();
		}
		
		private function changeQuestion():void
		{
			if(questionNumber <= numberOfQuestions){
				for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
				{
					TweenLite.to(arrayOfAlternatives[i], .5, {alpha:1});
				}
				TweenLite.to(questionTextField, .5, {alpha:1, onComplete:completeTweenOnQuestion});
				fillQuestion(/*arrayOfQuestion[questionNumber-1]*/);
			}else{
				//TODO Finish
				finishQuiz();
			}
			/*for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
			{
			TweenLite.to(arrayOfAlternatives[i], .5, {y: questionTextField.y, onComplete:completeTweenAlternatives, onCompleteParams:[i]});
			}*/
		}
		
		private function finishQuiz():void
		{
			quizData.setArrayOfAlternatives(arrayOfAlternatives.concat());
			quizData.setNumberOfCorrectAnswers(numberOfCorrectAnswers)
			quizData.setNumberOfWrongAnswers(numberOfWrongAnswers)
			this.gotoScene(ScenesName.RANKING_SCENE);
			
		}
		
		private function completeTweenAlternatives(alternativeNumber:int):void
		{
			if(alternativeNumber == numberOfAlternatives){
				fillQuestion(/*arrayOfQuestion[questionNumber]*/);
			}
		}
		
		private function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.updateAnswerStatus(OVER);
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.updateAnswerStatus(OUT);
		}
		
		override public function destroy():void
		{
			for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
			{
				if(mcAlternativeContainer.contains(arrayOfAlternatives[i])){
					mcAlternativeContainer.removeChild(arrayOfAlternatives[i]);
					arrayOfAlternatives[i] = null;
				}
			}
			arrayOfQuestion = null;
			arrayOfAlternatives = null;
			if(this.contains(mcQuestion)){
				this.removeChild(mcQuestion);
				mcQuestion = null;
			}
			if(this.contains(mcAlternativeContainer)){
				this.removeChild(mcAlternativeContainer);
				mcAlternativeContainer = null;
			}
			
			currentQuestion = null;
		}
	}
}