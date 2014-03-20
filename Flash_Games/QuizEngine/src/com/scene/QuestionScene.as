package com.scene
{
	import com.data.Alternative;
	import com.data.Debug;
	import com.data.Question;
	import com.globo.sitio.engine.debug.Debug;
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
		
		public function QuestionScene()
		{
			super();
		}
		
		override public function init():void
		{
			questionNumber = 1;
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
			mcQuestion.graphics.beginFill(0x606060, 1);
			mcQuestion.graphics.drawRect(0, 0, quizData.getAppWidth() - offSetX*2, quizData.getAppHeight()/3 - offSetY*2);
			mcQuestion.graphics.endFill();
			mcQuestion.x = (quizData.getAppWidth() - mcQuestion.width)/2;
			mcQuestion.y = offSetY;
			this.addChild(mcQuestion);
			questionTextField = new TextField();
			
			mcAlternativeContainer = new Sprite();
			mcAlternativeContainer.graphics.beginFill(0x303030, 1);
			mcAlternativeContainer.graphics.drawRect(0, 0, quizData.getAppWidth() - offSetX*2, quizData.getAppHeight() - (mcQuestion.height + offSetY*2.5));
			mcAlternativeContainer.graphics.endFill();
			mcAlternativeContainer.x = offSetX;
			mcAlternativeContainer.y = mcQuestion.x + mcQuestion.height + offSetY/2;
			this.addChild(mcAlternativeContainer);
			
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
			
			fillQuestion();
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
		
		private function fillQuestion():void
		{
			arrayOfQuestion = quizData.getArrayOfQuestions();
			
			var randomQuestionNumber:int = Math.floor(Math.random()*arrayOfQuestion.length);
			var question:Question = arrayOfQuestion[randomQuestionNumber];
			questionTextField.text = question.getQuestion();
			questionTextField.selectable = false;
			questionTextField.autoSize = "left";
			questionTextField.multiline = true;
			questionTextField.width = mcQuestion.width - offSetX;
			mcQuestion.addChild(questionTextField);
			currentQuestion = question;
			arrayOfQuestion.splice(randomQuestionNumber, 1);
			
			var lines:int = 0;
			var cols:int = 0;
			
			for (var j:int = 0; j < numberOfAlternatives; j++) 
			{
				if(arrayOfAlternatives.length < numberOfAlternatives){
					alternative = new Alternative();
					arrayOfAlternatives.push(alternative);
					mcAlternativeContainer.addChild(alternative);
				}
				//alternative.alpha = 0;
				
				arrayOfAlternatives[j].buttonMode = true;
				arrayOfAlternatives[j].addEventListener(MouseEvent.CLICK, onClickAlternative);
				arrayOfAlternatives[j].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				arrayOfAlternatives[j].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				
				arrayOfAlternatives[j].alternativeText = question.getAlternativeArray()[j];
				arrayOfAlternatives[j].alternativeLetter = question.getAlternativeLettersArray()[j];
				arrayOfAlternatives[j].fillAlternative();
				
				//alternative.x = numberOfCols
				arrayOfAlternatives[j].x = offSetX*(cols+1) + (arrayOfAlternatives[j].width*cols);
				arrayOfAlternatives[j].y = offSetY*(lines+1) + (arrayOfAlternatives[j].height*lines);
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
			/*if(alternativerOverLabel){
			actualText = event.currentTarget.alternativeText.text;
			event.currentTarget.gotoAndStop(SELECTED);
			event.currentTarget.alternativeText.text = actualText;
			}*/
			
			verifyAlternative(event.currentTarget);
		}
		
		private function verifyAlternative(alternative:Object):void
		{
			var letter:String = alternative.alternativeLetter;
			letter = letter.split(" ")[0];
			for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
			{
				arrayOfAlternatives[i].buttonMode = false;
				arrayOfAlternatives[i].removeEventListener(MouseEvent.CLICK, onClickAlternative);
				arrayOfAlternatives[i].removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				arrayOfAlternatives[i].removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			if(letter == currentQuestion.getCorrectAlternative()){
				alternative.updateAnswerStatus(CORRECT)
				arrayOfAnwsers.push(CORRECT);
				/*actualText = alternative.alternativeText.text;
				actualLetter = alternative.letter.text;
				alternative.gotoAndStop(CORRECT);
				alternative.alternativeText.text = actualText;
				alternative.letter.text = actualLetter;*/
				numberOfCorrectAnswers++;
			}else{
				alternative.updateAnswerStatus(WRONG)
				arrayOfAnwsers.push(WRONG);
				numberOfWrongAnswers++;
				/*actualText = alternative.alternativeText.text;
				actualLetter = alternative.letter.text;
				alternative.gotoAndStop(WRONG);
				alternative.alternativeText.text = actualText;
				alternative.letter.text = actualLetter;*/
			}
			
			for (var j:int = 0; j < arrayOfAlternatives.length; j++) 
			{
				if(arrayOfAlternatives[j].alternativeLetter == currentQuestion.getCorrectAlternative()){
					arrayOfAlternatives[j].updateAnswerStatus(CORRECT);
					/*actualText = arrayOfAlternatives[j].alternativeText.text;
					actualLetter = arrayOfAlternatives[j].letter.text;
					arrayOfAlternatives[j].gotoAndStop(CORRECT);
					arrayOfAlternatives[j].alternativeText.text = actualText;
					arrayOfAlternatives[j].letter.text = actualLetter;*/
					TweenLite.to(arrayOfAlternatives[j], .5, {alpha:0, delay: 2});
				}else if(arrayOfAlternatives[j].alternativeLetter != letter){
					arrayOfAlternatives[j].updateAnswerStatus(OUT);
					/*actualText = arrayOfAlternatives[j].alternativeText.text;
					actualLetter = arrayOfAlternatives[j].letter.text;
					arrayOfAlternatives[j].gotoAndStop(NOTCHOOSED);
					arrayOfAlternatives[j].alternativeText.text = actualText;
					arrayOfAlternatives[j].letter.text = actualLetter;*/
					TweenLite.to(arrayOfAlternatives[j], .5, {alpha:0, delay: 2});
				}
			}
			questionNumber += 1;
			TweenLite.to(alternative, .5, {alpha:0, delay: 2});
			TweenLite.to(questionTextField, .5, {alpha:0, delay: 2, onComplete:completeTweenOfQuestion});
			
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
			
		}
		
		private function changeQuestion():void
		{
			if(questionNumber <= numberOfQuestions){
				fillQuestion(/*arrayOfQuestion[questionNumber-1]*/);
				for (var i:int = 0; i < arrayOfAlternatives.length; i++) 
				{
					TweenLite.to(arrayOfAlternatives[i], .5, {alpha:1});
				}
				TweenLite.to(questionTextField, .5, {alpha:1, onComplete:completeTweenOnQuestion});
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
			quizData.setNumberOfCorrectAnswers(numberOfCorrectAnswers)
			quizData.setNumberOfWrongAnswers(numberOfWrongAnswers)
			this.gotoScene(ScenesName.RANKING_SCENE);
			
		}
		
		private function completeTweenAlternatives(alternativeNumber:int):void
		{
			arrayOfAlternatives
			if(alternativeNumber == numberOfAlternatives){
				fillQuestion(/*arrayOfQuestion[questionNumber]*/);
			}
		}
		
		private function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.updateAnswerStatus(OVER);
			/*if(alternativerOverLabel){
				actualText = event.currentTarget.alternativeText.text;
				actualLetter = event.currentTarget.letter.text;
				event.currentTarget.gotoAndStop(OVER);
				event.currentTarget.alternativeText.text = actualText;
				event.currentTarget.letter.text = actualLetter;
			}else{
				event.currentTarget.scaleX = event.currentTarget.scaleY += .1;
			}*/
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.updateAnswerStatus(OUT);
			/*if(alternativerOverLabel){
				actualText = event.currentTarget.alternativeText.text;
				actualLetter = event.currentTarget.letter.text;
				event.currentTarget.gotoAndStop(OUT);
				event.currentTarget.alternativeText.text = actualText;
				event.currentTarget.letter.text = actualLetter;
			}else{
				event.currentTarget.scaleX = event.currentTarget.scaleY -= .1;
			}*/
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