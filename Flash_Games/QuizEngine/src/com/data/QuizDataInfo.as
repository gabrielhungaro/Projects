package com.data
{
	import com.globo.sitio.engine.debug.Debug;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;

	public class QuizDataInfo
	{
		private static var instance:QuizDataInfo = null;
		private static var okToCreate:Boolean = true;
		
		private var urlXML:String = "quizInfos.xml";
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader;
		private const TYPE_QUIZ:String = "quiz";
		private const TYPE_POLL:String = "poll";
		
		private var _appHeight:int;
		private var _appWidth:int;
		private var _quizName:String;
		private var _quizType:String;
		private var _arrayOfQuestion:Array;
		private var _arrayOfAllQuestion:Array;
		private var _numberOfAlternatives:int;
		private var _numberOfQuestionsToAnswer:int;
		private var _numberOfCorrectAnswers:int;
		private var _numberOfWrongAnswers:int;
		private var _arrayOfResults:Array;
		private var _numberOfResults:int;
		
		private var _urlStartScreen:String;
		private var _urlQuestionScreen:String;
		private var _urlRankingScreen:String;
		private var _urlStartButton:String;
		private var _urlStartButtonOver:String;
		private var _urlPlayAgainButton:String;
		private var _urlPlayAgainButtonOver:String;
		private var _urlShareButton:String;
		private var _urlShareButtonOver:String;
		private var _urlAlternative:String;
		private var _urlAlternativeOver:String;
		private var _urlAlternativeCorrect:String;
		private var _urlAlternativeWrong:String;
		private var imagePath:String = "../assets/";
		
		
		public var loadXMLComplete:Signal = new Signal();
		
		public function QuizDataInfo()
		{
			//loadXMLComplete = new Signal();
		}
		
		public static function getInstance():QuizDataInfo
		{
			if(!instance){
				okToCreate = true;
				instance = new QuizDataInfo();
				okToCreate = false;
			}
			return instance;
		}
		
		public function initLoad():void
		{
			xmlRequest = new URLRequest(urlXML);
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, completeLoadXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.load(xmlRequest);
		}
		
		protected function completeLoadXML(event:Event):void
		{
			_arrayOfQuestion = [];
			_arrayOfAllQuestion = [];
			_arrayOfResults = [];
			var xml:XML = new XML(event.target.data);
			_quizName = xml.quiz.@name;
			_quizType = xml.quiz.@type;
			
			_urlStartScreen = imagePath + xml.quiz.@startScreenImg;
			_urlQuestionScreen = imagePath + xml.quiz.@questionScreenImg;
			_urlRankingScreen = imagePath + xml.quiz.@rankingScreenImg;
			_urlAlternative = imagePath + xml.quiz.@alternativeImg;
			_urlAlternativeCorrect = imagePath + xml.quiz.@alternativeCorrectImg; 
			_urlAlternativeWrong = imagePath + xml.quiz.@alternativeWrongImg; 
			_urlAlternativeOver = imagePath + xml.quiz.@alternativeOverImg; 
			_urlStartButton = imagePath + xml.buttonImgs.@startButtonImg;
			_urlStartButtonOver = imagePath + xml.buttonImgs.@startButtonOverImg;
			_urlPlayAgainButton = imagePath + xml.buttonImgs.@playAgainButtonImg;
			_urlPlayAgainButtonOver = imagePath + xml.buttonImgs.@playAgainButtonOverImg;
			_urlShareButton = imagePath + xml.buttonImgs.@shareButtonImg;
			_urlShareButtonOver = imagePath + xml.buttonImgs.@shareButtonOverImg;
			
			_numberOfQuestionsToAnswer = xml.questions.@questionsToAnswer;
			var numberOfQuestionsInXML:int = xml.questions.question.length();
			_numberOfAlternatives = xml.alternatives.*[0].alternative.length();
			
			for (var i:int = 0; i < numberOfQuestionsInXML; i++) 
			{
				var question:Question = new Question();
				question.setNumberOfAlternatives( _numberOfAlternatives );
				question.init();
				question.setQuestion(xml.questions.*[i].@question);
				question.setCorrectAlternative(xml.alternatives.*[i].@correctAnswer);
				for (var j:int = 0; j < _numberOfAlternatives; j++) 
				{
					question.setAlternative( j, xml.alternatives.*[i].*[j].@answer );
				}
				_arrayOfAllQuestion.push(question);
			}
			
			if(_quizType == TYPE_POLL){
				_numberOfResults = xml.results.result.lenght();
				for (var k:int = 0; k < _numberOfResults; k++) 
				{
					var result:Result = new Result();
					_arrayOfResults.push();
				}
			}
			
			_arrayOfQuestion = _arrayOfAllQuestion;
			loadXMLComplete.dispatch();
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			Debug.message(Debug.ERROR, " Erro ao carregar o xml do QUIZ da ErrorID: " +  event.errorID + " || " + event.text);
		}
		
		public function getAppWidth():int
		{
			return _appWidth;
		}
		
		public function setAppWidth(value:int):void
		{
			_appWidth = value;
		}
		
		public function getAppHeight():int
		{
			return _appHeight;
		}
		
		public function setAppHeight(value:int):void
		{
			_appHeight = value;
		}

		
		public function setArrayOfQuestions(value:Array):void
		{
			_arrayOfQuestion = value;
		}
		
		public function getArrayOfQuestions():Array
		{
			return _arrayOfQuestion;
		}
		
		public function setArrayOfAllQuestions(value:Array):void
		{
			_arrayOfAllQuestion = value;
		}
		
		public function getArrayOfAllQuestions():Array
		{
			return _arrayOfAllQuestion;
		}
		
		public function setQuizName(value:String):void
		{
			_quizName = value;
		}
		
		public function getQuizName():String
		{
			return _quizName;
		}
		
		public function setQuizType(value:String):void
		{
			_quizType = value;
		}
		
		public function getQuizType():String
		{
			return _quizType;
		}
		
		public function setNumberOfAlternatives(value:int):void
		{
			_numberOfAlternatives = value;
		}
		
		public function getNumberOfAlternatives():int
		{
			return _numberOfAlternatives;
		}
		
		public function setNumberOfQuestionsToAnswer(value:int):void
		{
			_numberOfQuestionsToAnswer = value;
		}
		
		public function getNumberOfQuestionsToAnswer():int
		{
			return _numberOfQuestionsToAnswer;
		}
		
		public function setNumberOfCorrectAnswers(value:int):void
		{
			_numberOfCorrectAnswers = value;
		}
		
		public function getNumberOfCorrectAnswers():int
		{
			return _numberOfCorrectAnswers;
		}
		
		public function setNumberOfWrongAnswers(value:int):void
		{
			_numberOfWrongAnswers = value;
		}
		
		public function getNumberOfWrongAnswers():int
		{
			return _numberOfWrongAnswers;
		}

		public function getUrlStartScreen():String
		{
			return _urlStartScreen;
		}

		public function setUrlStartScreen(value:String):void
		{
			_urlStartScreen = value;
		}

		public function getUrlQuestionScreen():String
		{
			return _urlQuestionScreen;
		}

		public function setUrlQuestionScreen(value:String):void
		{
			_urlQuestionScreen = value;
		}

		public function getUrlRankingScreen():String
		{
			return _urlRankingScreen;
		}

		public function setUrlRankingScreen(value:String):void
		{
			_urlRankingScreen = value;
		}

		public function getUrlAlternative():String
		{
			return _urlAlternative;
		}

		public function setUrlAlternative(value:String):void
		{
			_urlAlternative = value;
		}

		public function getUrlAlternativeCorrect():String
		{
			return _urlAlternativeCorrect;
		}

		public function setUrlAlternativeCorrect(value:String):void
		{
			_urlAlternativeCorrect = value;
		}

		public function getUrlAlternativeWrong():String
		{
			return _urlAlternativeWrong;
		}

		public function setUrlAlternativeWrong(value:String):void
		{
			_urlAlternativeWrong = value;
		}

		public function getUrlAlternativeOver():String
		{
			return _urlAlternativeOver;
		}

		public function setUrlAlternativeOver(value:String):void
		{
			_urlAlternativeOver = value;
		}

		public function getUrlStartButton():String
		{
			return _urlStartButton;
		}

		public function setUrlStartButton(value:String):void
		{
			_urlStartButton = value;
		}

		public function getUrlStartButtonOver():String
		{
			return _urlStartButtonOver;
		}

		public function setUrlStartButtonOver(value:String):void
		{
			_urlStartButtonOver = value;
		}

		public function getUrlPlayAgainButton():String
		{
			return _urlPlayAgainButton;
		}

		public function setUrlPlayAgainButton(value:String):void
		{
			_urlPlayAgainButton = value;
		}

		public function getUrlPlayAgainButtonOver():String
		{
			return _urlPlayAgainButtonOver;
		}

		public function setUrlPlayAgainButtonOver(value:String):void
		{
			_urlPlayAgainButtonOver = value;
		}

		public function getUrlShareButton():String
		{
			return _urlShareButton;
		}

		public function setUrlShareButton(value:String):void
		{
			_urlShareButton = value;
		}

		public function getUrlShareButtonOver():String
		{
			return _urlShareButtonOver;
		}

		public function setUrlShareButtonOver(value:String):void
		{
			_urlShareButtonOver = value;
		}
	}
}