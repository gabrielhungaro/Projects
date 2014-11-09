package com.data
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;

	public class QuizDataInfo
	{
		private static var instance:QuizDataInfo = null;
		private static var okToCreate:Boolean = true;
		
		private var quizInfo:String = "quizInfos.xml";
		private var testInfo:String = "testInfos.xml";
		
		private var urlXML:String = testInfo;
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader;
		public const TYPE_QUIZ:String = "quiz";
		public const TYPE_POLL:String = "poll";
		
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
		private var _arrayOfResults:Vector.<Result>;
		private var _arrayOfAlternatives:Vector.<Alternative>;
		private var _numberOfResults:int;
		private var _arrayOfChooseds:Array;
		private var _questionActualNumber:int;
		
		private var _urlStartScreen:String;
		private var _urlQuestionScreen:String;
		private var _urlRankingScreen:String;
		
		private var _urlNavigator:String;
		private var _urlNavigatorIndicator:String;
		private var _urlNavigatorIndicatorActual:String;
		private var _navigatorType:String;
		private var _navigatorXPos:int;
		private var _navigatorYPos:int;
		private var _navigatorFont:String;
		private var _navigatorFontSize:int;
		private var _navigatorFontColor:uint;
		
		private var _questionXPos:int;
		private var _questionYPos:int;
		private var _questionFont:String;
		private var _questionSize:int;
		private var _questionColor:uint;
		
		private var _questionNumberXPos:int;
		private var _questionNumberYPos:int;
		private var _questionNumberPrefix:String;
		private var _questionNumberFont:String;
		private var _questionNumberSize:int;
		private var _questionNumberColor:uint;
		
		private var _urlStartButton:String;
		private var _urlStartButtonOver:String;
		private var _startButtonWidth:int;
		private var _startButtonHeight:int;
		private var _startButtonXPos:int;
		private var _startButtonYPos:int;
		
		private var _urlContinueButton:String;
		private var _urlContinueButtonOver:String;
		private var _continueButtonWidth:int;
		private var _continueButtonHeight:int;
		private var _continueXPos:int;
		private var _continueYPos:int;
		
		private var _urlAlternative:String;
		private var _urlAlternativeOver:String;
		private var _urlAlternativeCorrect:String;
		private var _urlAlternativeWrong:String;
		private var _alternativeWidth:int;
		private var _alternativeHeight:int;
		private var _alternativeXPos:int;
		private var _alternativeYPos:int;
		private var _alternativeFont:String;
		private var _alternativeSize:int;
		private var _alternativeColor:uint;
		private var _alternativeLetterVisibility:Boolean;
		
		private var _urlPlayAgainButton:String;
		private var _urlPlayAgainButtonOver:String;
		private var _playAgainButtonWidth:int;
		private var _playAgainButtonHeight:int;
		
		private var _urlShareButton:String;
		private var _urlShareButtonOver:String;
		private var _urlShareImgDefault:Object;
		private var _shareButtonWidth:int;
		private var _shareButtonHeight:int;
		private var _shareButtonXPos:int;
		private var _shareButtonYPos:int;
		
		private var _urlRankingGold:String;
		private var _urlRankingSilver:String;
		private var _urlRankingBronze:String;
		private var _resultWidth:int;
		private var _resultHeight:int;
		private var _resultXPos:int;
		private var _resultYPos:int;
		
		private var _urlToShare:String;
		private var _descriptionShare:String;
		private var _captionShare:String;
		
		private var _imagePath:String;
		
		
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
			_arrayOfChooseds = [];
			_arrayOfResults = new Vector.<Result>;
			_arrayOfAlternatives = new Vector.<Alternative>;
			var xml:XML = new XML(event.target.data);
			_quizName = xml.quiz.@name;
			_quizType = xml.quiz.@type;
			
			_imagePath = xml.quiz.@urlPath;
			
			_urlStartScreen = _imagePath + xml.startScreen.@img;
			_urlQuestionScreen = _imagePath + xml.questionScreen.@img;
			_urlRankingScreen = _imagePath + xml.rankingScreen.@img;
			
			_urlToShare = xml.quiz.@urlToShare;
			_descriptionShare = xml.quiz.@description;
			_captionShare = xml.quiz.@caption;
			
			_startButtonXPos = xml.startScreen.@startButtonXPos;
			_startButtonYPos = xml.startScreen.@startButtonYPos;
			
			_questionXPos = xml.questionScreen.@questionXPos;
			_questionYPos = xml.questionScreen.@questionYPos;
			_questionFont = xml.questionScreen.@questionFont;
			_questionSize = xml.questionScreen.@questionSize;
			_questionColor = xml.questionScreen.@questionColor;
			
			_questionNumberXPos = xml.questionScreen.@questionNumberXPos;
			_questionNumberYPos = xml.questionScreen.@questionNumberYPos;
			_questionNumberPrefix = xml.questionScreen.@questionNumberPrefix;
			_questionNumberFont = xml.questionScreen.@questionNumberFont;
			_questionNumberSize = xml.questionScreen.@questionNumberSize;
			_questionNumberColor = xml.questionScreen.@questionNumberColor;
			
			_urlNavigator = _imagePath + xml.navigatorPanelImgs.@navigatorImg;
			_urlNavigatorIndicator = _imagePath + xml.navigatorPanelImgs.@navigatorIndicatorImg;
			_urlNavigatorIndicatorActual = _imagePath + xml.navigatorPanelImgs.@navigatorIndicatorActualImg;
			_navigatorFont = xml.navigatorPanelImgs.@font;
			_navigatorFontSize = xml.navigatorPanelImgs.@fontSize;
			_navigatorFontColor = xml.navigatorPanelImgs.@fontColor;
			_navigatorType = xml.navigatorPanelImgs.@type;
			_navigatorXPos = xml.navigatorPanelImgs.@xPos;
			_navigatorYPos = xml.navigatorPanelImgs.@yPos;
			
			_urlStartButton = _imagePath + xml.startButtonImgs.@startButtonImg;
			_urlStartButtonOver = _imagePath + xml.startButtonImgs.@startButtonOverImg;
			_startButtonWidth = xml.startButtonImgs.@width;
			_startButtonHeight = xml.startButtonImgs.@height;
			
			_urlContinueButton = _imagePath + xml.continueButtonImgs.@continueButtonImg;
			_urlContinueButtonOver = _imagePath + xml.continueButtonImgs.@continueButtonOverImg;
			_continueButtonWidth = xml.continueButtonImgs.@width;
			_continueButtonHeight = xml.continueButtonImgs.@height;
			_continueXPos = xml.continueButtonImgs.@xPos;
			_continueYPos = xml.continueButtonImgs.@yPos;
			
			_urlAlternative = _imagePath + xml.alternativeImgs.@alternativeImg;
			_urlAlternativeCorrect = _imagePath + xml.alternativeImgs.@alternativeCorrectImg; 
			_urlAlternativeWrong = _imagePath + xml.alternativeImgs.@alternativeWrongImg; 
			_urlAlternativeOver = _imagePath + xml.alternativeImgs.@alternativeOverImg; 
			_alternativeWidth = xml.alternativeImgs.@width;
			_alternativeHeight = xml.alternativeImgs.@height;
			_alternativeXPos = xml.alternativeImgs.@xPos;
			_alternativeYPos = xml.alternativeImgs.@yPos;
			_alternativeFont = xml.alternativeImgs.@font;
			_alternativeSize = xml.alternativeImgs.@size;
			_alternativeColor = xml.alternativeImgs.@color;
			_alternativeLetterVisibility = Boolean(int(xml.alternativeImgs.@letterVisibility));
			
			_urlPlayAgainButton = _imagePath + xml.playAgainButtonImgs.@playAgainButtonImg;
			_urlPlayAgainButtonOver = _imagePath + xml.playAgainButtonImgs.@playAgainButtonOverImg;
			_playAgainButtonWidth = xml.alternativeImgs.@width;
			_playAgainButtonHeight = xml.alternativeImgs.@height;
			
			_urlShareButton = _imagePath + xml.shareButtonImgs.@shareButtonImg;
			_urlShareButtonOver = _imagePath + xml.shareButtonImgs.@shareButtonOverImg;
			_urlShareImgDefault = _imagePath + xml.shareButtonImgs.@defaultImg;
			_shareButtonWidth = xml.alternativeImgs.@width;
			_shareButtonHeight = xml.alternativeImgs.@height;
			_shareButtonXPos = xml.shareButtonImgs.@xPos;
			_shareButtonYPos = xml.shareButtonImgs.@yPos;
			//_continueDynamicText = xml.buttonImgs.@continueDynamicText;
			
			
			
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
				_numberOfResults = xml.results.result.length();
				for (var k:int = 0; k < _numberOfResults; k++) 
				{
					var result:Result = new Result();
					result.setName(xml.results.*[k]);
					result.setType(xml.results.*[k].@type);
					result.setImagePath(_imagePath);
					result.setShareImgUrl(_imagePath + xml.results.*[k].@shareImgUrl);
					result.setPhotoUrl(_imagePath + xml.results.*[k].@photoUrl);
					_resultXPos = xml.results.@xPos;
					_resultYPos = xml.results.@yPos;
					_arrayOfResults.push(result);
				}
			}else{
				/*_numberOfResults = xml.results.result.length();
				for (var l:int = 0; l < _numberOfResults; l++) 
				{
					var result:Result = new Result();
					result.setShareImgUrl(_imagePath + xml.results.*[l].@shareImgUrl);
					result.setPhotoUrl(_imagePath + xml.results.*[k]);
					_arrayOfResults.push(result);
				}*/
				_urlRankingGold = _imagePath + xml.results.*[0];
				_urlRankingSilver = _imagePath + xml.results.*[1];
				_urlRankingBronze = _imagePath + xml.results.*[2];
				_resultWidth = xml.results.@width;
				_resultHeight = xml.results.@height;
				_resultXPos = xml.results.@xPos;
				_resultYPos = xml.results.@yPos;
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
		
		public function setAlternativeChoosed(letter:String):void
		{
			_arrayOfChooseds.push(letter);
			trace(_arrayOfChooseds);
			for (var i:int = 0; i < _arrayOfAlternatives.length; i++) 
			{
				if(_arrayOfAlternatives[i].alternativeLetter == letter){
					_arrayOfAlternatives[i].addChoosedTime();
				}
			}
		}
		
		public function getAlternativesChooseds():Vector.<Alternative>
		{
			return _arrayOfAlternatives;
		}
		
		public function setArrayOfAlternatives(value:Vector.<Alternative>):void
		{
			_arrayOfAlternatives = value;
		}

		public function getArrayOfResults():Vector.<Result>
		{
			return _arrayOfResults;
		}

		public function setArrayOfResults(value:Vector.<Result>):void
		{
			_arrayOfResults = value;
		}

		public function getUrlContinueButton():String
		{
			return _urlContinueButton;
		}

		public function setUrlContinueButton(value:String):void
		{
			_urlContinueButton = value;
		}

		public function getUrlContinueButtonOver():String
		{
			return _urlContinueButtonOver;
		}

		public function setUrlContinueButtonOver(value:String):void
		{
			_urlContinueButtonOver = value;
		}

		public function getImagePath():String
		{
			return _imagePath;
		}

		public function setImagePath(value:String):void
		{
			_imagePath = value;
		}

		public function getStartButtonWidth():int
		{
			return _startButtonWidth;
		}

		public function setStartButtonWidth(value:int):void
		{
			_startButtonWidth = value;
		}

		public function getStartButtonHeight():int
		{
			return _startButtonHeight;
		}

		public function setStartButtonHeight(value:int):void
		{
			_startButtonHeight = value;
		}

		public function getContinueButtonWidth():int
		{
			return _continueButtonWidth;
		}

		public function setContinueButtonWidth(value:int):void
		{
			_continueButtonWidth = value;
		}

		public function getContinueButtonHeight():int
		{
			return _continueButtonHeight;
		}

		public function setContinueButtonHeight(value:int):void
		{
			_continueButtonHeight = value;
		}

		public function getAlternativeWidth():int
		{
			return _alternativeWidth;
		}

		public function setAlternativeWidth(value:int):void
		{
			_alternativeWidth = value;
		}

		public function getAlternativeHeight():int
		{
			return _alternativeHeight;
		}

		public function setAlternativeHeight(value:int):void
		{
			_alternativeHeight = value;
		}

		public function getPlayAgainButtonWidth():int
		{
			return _playAgainButtonWidth;
		}

		public function setPlayAgainButtonWidth(value:int):void
		{
			_playAgainButtonWidth = value;
		}

		public function getPlayAgainButtonHeight():int
		{
			return _playAgainButtonHeight;
		}

		public function setPlayAgainButtonHeight(value:int):void
		{
			_playAgainButtonHeight = value;
		}

		public function getShareButtonWidth():int
		{
			return _shareButtonWidth;
		}

		public function setShareButtonWidth(value:int):void
		{
			_shareButtonWidth = value;
		}

		public function getShareButtonHeight():int
		{
			return _shareButtonHeight;
		}

		public function setShareButtonHeight(value:int):void
		{
			_shareButtonHeight = value;
		}

		public function getQuestionXPos():int
		{
			return _questionXPos;
		}

		public function setQuestionXPos(value:int):void
		{
			_questionXPos = value;
		}

		public function getQuestionYPos():int
		{
			return _questionYPos;
		}

		public function setQuestionYPos(value:int):void
		{
			_questionYPos = value;
		}

		public function getQuestionNumberXPos():int
		{
			return _questionNumberXPos;
		}

		public function setQuestionNumberXPos(value:int):void
		{
			_questionNumberXPos = value;
		}

		public function getQuestionNumberYPos():int
		{
			return _questionNumberYPos;
		}

		public function setQuestionNumberYPos(value:int):void
		{
			_questionNumberYPos = value;
		}

		public function getStartButtonXPos():int
		{
			return _startButtonXPos;
		}

		public function setStartButtonXPos(value:int):void
		{
			_startButtonXPos = value;
		}

		public function getStartButtonYPos():int
		{
			return _startButtonYPos;
		}

		public function setStartButtonYPos(value:int):void
		{
			_startButtonYPos = value;
		}

		public function getAlternativeXPos():int
		{
			return _alternativeXPos;
		}

		public function setAlternativeXPos(value:int):void
		{
			_alternativeXPos = value;
		}

		public function getAlternativeYPos():int
		{
			return _alternativeYPos;
		}

		public function setAlternativeYPos(value:int):void
		{
			_alternativeYPos = value;
		}

		public function getQuestionNumberPrefix():String
		{
			return _questionNumberPrefix;
		}

		public function setQuestionNumberPrefix(value:String):void
		{
			_questionNumberPrefix = value;
		}

		public function getUrlRankingGold():String
		{
			return _urlRankingGold;
		}

		public function setUrlRankingGold(value:String):void
		{
			_urlRankingGold = value;
		}

		public function getUrlRankingSilver():String
		{
			return _urlRankingSilver;
		}

		public function setUrlRankingSilver(value:String):void
		{
			_urlRankingSilver = value;
		}

		public function getUrlRankingBronze():String
		{
			return _urlRankingBronze;
		}

		public function setUrlRankingBronze(value:String):void
		{
			_urlRankingBronze = value;
		}

		public function getResultWidth():int
		{
			return _resultWidth;
		}

		public function setResultWidth(value:int):void
		{
			_resultWidth = value;
		}

		public function getResultHeight():int
		{
			return _resultHeight;
		}

		public function setResultHeight(value:int):void
		{
			_resultHeight = value;
		}

		public function getQuestionNumberFont():String
		{
			return _questionNumberFont;
		}

		public function setQuestionNumberFont(value:String):void
		{
			_questionNumberFont = value;
		}

		public function getQuestionNumberSize():int
		{
			return _questionNumberSize;
		}

		public function setQuestionNumberSize(value:int):void
		{
			_questionNumberSize = value;
		}

		public function getQuestionNumberColor():uint
		{
			return _questionNumberColor;
		}

		public function setQuestionNumberColor(value:uint):void
		{
			_questionNumberColor = value;
		}

		public function getQuestionFont():String
		{
			return _questionFont;
		}

		public function setQuestionFont(value:String):void
		{
			_questionFont = value;
		}

		public function getQuestionSize():int
		{
			return _questionSize;
		}

		public function setQuestionSize(value:int):void
		{
			_questionSize = value;
		}

		public function getQuestionColor():uint
		{
			return _questionColor;
		}

		public function setQuestionColor(value:uint):void
		{
			_questionColor = value;
		}

		public function getAlternativeFont():String
		{
			return _alternativeFont;
		}

		public function setAlternativeFont(value:String):void
		{
			_alternativeFont = value;
		}

		public function getAlternativeSize():int
		{
			return _alternativeSize;
		}

		public function setAlternativeSize(value:int):void
		{
			_alternativeSize = value;
		}

		public function getAlternativeColor():uint
		{
			return _alternativeColor;
		}

		public function setAlternativeColor(value:uint):void
		{
			_alternativeColor = value;
		}

		public function getUrlNavigator():String
		{
			return _urlNavigator;
		}

		public function setUrlNavigator(value:String):void
		{
			_urlNavigator = value;
		}

		public function getUrlNavigatorIndicator():String
		{
			return _urlNavigatorIndicator;
		}

		public function setUrlNavigatorIndicator(value:String):void
		{
			_urlNavigatorIndicator = value;
		}

		public function getUrlNavigatorIndicatorActual():String
		{
			return _urlNavigatorIndicatorActual;
		}

		public function setUrlNavigatorIndicatorActual(value:String):void
		{
			_urlNavigatorIndicatorActual = value;
		}

		public function getNavigatorType():String
		{
			return _navigatorType;
		}

		public function setNavigatorType(value:String):void
		{
			_navigatorType = value;
		}

		public function getNavigatorXPos():int
		{
			return _navigatorXPos;
		}

		public function setNavigatorXPos(value:int):void
		{
			_navigatorXPos = value;
		}

		public function getNavigatorYPos():int
		{
			return _navigatorYPos;
		}

		public function setNavigatorYPos(value:int):void
		{
			_navigatorYPos = value;
		}

		public function setActualQuestion(value:int):void
		{
			_questionActualNumber = value;
		}

		public function getActualQuestion():int
		{
			return _questionActualNumber;
		}

		public function getNavigatorFont():String
		{
			return _navigatorFont;
		}

		public function setNavigatorFont(value:String):void
		{
			_navigatorFont = value;
		}

		public function getNavigatorFontSize():int
		{
			return _navigatorFontSize;
		}

		public function setNavigatorFontSize(value:int):void
		{
			_navigatorFontSize = value;
		}

		public function getNavigatorFontColor():uint
		{
			return _navigatorFontColor;
		}

		public function setNavigatorFontColor(value:uint):void
		{
			_navigatorFontColor = value;
		}

		public function getContinueXPos():int
		{
			return _continueXPos;
		}

		public function setContinueXPos(value:int):void
		{
			_continueXPos = value;
		}

		public function getContinueYPos():int
		{
			return _continueYPos;
		}

		public function setContinueYPos(value:int):void
		{
			_continueYPos = value;
		}

		public function getAlternativeLetterVisibility():Boolean
		{
			return _alternativeLetterVisibility;
		}

		public function setAlternativeLetterVisibility(value:Boolean):void
		{
			_alternativeLetterVisibility = value;
		}

		public function getShareButtonXPos():int
		{
			return _shareButtonXPos;
		}

		public function setShareButtonXPos(value:int):void
		{
			_shareButtonXPos = value;
		}

		public function getShareButtonYPos():int
		{
			return _shareButtonYPos;
		}

		public function setShareButtonYPos(value:int):void
		{
			_shareButtonYPos = value;
		}

		public function getResultXPos():int
		{
			return _resultXPos;
		}

		public function setResultXPos(value:int):void
		{
			_resultXPos = value;
		}

		public function getResultYPos():int
		{
			return _resultYPos;
		}

		public function setResultYPos(value:int):void
		{
			_resultYPos = value;
		}

		public function getUrlToShare():String
		{
			return _urlToShare;
		}

		public function setUrlToShare(value:String):void
		{
			_urlToShare = value;
		}

		public function getDescriptionShare():String
		{
			return _descriptionShare;
		}

		public function setDescriptionShare(value:String):void
		{
			_descriptionShare = value;
		}

		public function getCaptionShare():String
		{
			return _captionShare;
		}

		public function setCaptionShare(value:String):void
		{
			_captionShare = value;
		}


	}
}