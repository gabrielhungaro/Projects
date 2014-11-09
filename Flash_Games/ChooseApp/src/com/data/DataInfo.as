package com.data
{
	import com.elements.ObjectToChoose;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.osflash.signals.Signal;

	public class DataInfo
	{
		private static var instance:DataInfo = null;
		private static var okToCreate:Boolean = true;
		
		
		private var urlXML:String = "infoChoose.xml";
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader;
		private var _appHeight:int;
		private var _appWidth:int;
		private var _appName:String;
		private var _arrayOfObjectsToChoose:Vector.<ObjectToChoose>;
		private var _arrayOfAllObjectsToChoose:Vector.<ObjectToChoose>;
		private var _arrayOfObjs:Vector.<ObjectToChoose>;
		private var _arrayOfRankingObjs:Vector.<ObjectToChoose>;
		private var _numberOfObjectToChoose:int;
		private var _totalOfVotes:int = 0;
		
		private var _urlStartScreen:String;
		private var _urlStartButton:String;
		private var _urlStartButtonOver:String;
		private var _urlPlayAgainButton:String;
		private var _urlPlayAgainButtonOver:String;
		private var _urlShareButton:String;
		private var _urlShareButtonOver:String;
		private var _urlPhotoThumb1:String;
		private var _urlPhotoThumb2:String;
		private var _urlPhotoOver:String;
		private var _urlVs:String;
		private var _vsXPos:int;
		private var _vsYPos:int;
		private var imagePath:String;
		private var fontPath:String;
		private var photoPath:String = "personalities/";
		private var thumbsPath:String = "thumbs/";
		
		public var loadXMLComplete:Signal = new Signal();
		private var  _arrayOfVotes:Array;
		
		public function DataInfo()
		{
			//loadXMLComplete = new Signal();
		}
		
		public static function getInstance():DataInfo
		{
			if(!instance){
				okToCreate = true;
				instance = new DataInfo();
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
			_arrayOfObjectsToChoose = new Vector.<ObjectToChoose>();
			_arrayOfAllObjectsToChoose = new Vector.<ObjectToChoose>();
			var xml:XML = new XML(event.target.data);
			_appName = xml.app.@name;
			
			imagePath = xml.app.@urlAssets;
			fontPath = imagePath + "fonts/";
			_urlStartScreen = imagePath + xml.app.@startScreenImg;
			_urlPhotoThumb1 = imagePath + xml.buttonImgs.@photoUrlThumb1;
			_urlPhotoThumb2 = imagePath + xml.buttonImgs.@photoUrlThumb2;
			_urlPhotoOver = imagePath + xml.buttonImgs.@photoUrlOver; 
			_urlStartButton = imagePath + xml.buttonImgs.@startButtonImg;
			_urlStartButtonOver = imagePath + xml.buttonImgs.@startButtonOverImg;
			_urlPlayAgainButton = imagePath + xml.buttonImgs.@playAgainButtonImg;
			_urlPlayAgainButtonOver = imagePath + xml.buttonImgs.@playAgainButtonOverImg;
			_urlShareButton = imagePath + xml.buttonImgs.@shareButtonImg;
			_urlShareButtonOver = imagePath + xml.buttonImgs.@shareButtonOverImg;
			_urlVs = imagePath + xml.buttonImgs.@vsUrl;
			_vsXPos = xml.buttonImgs.@vsXPos;
			_vsYPos = xml.buttonImgs.@vsYPos;
			
			var numberOfObjectsXML:int = xml.objects.object.length();
			
			for (var i:int = 0; i < numberOfObjectsXML; i++) 
			{
				var urlPhoto:String = imagePath + photoPath + xml.objects.*[i].photoUrl;
				var urlThumb:String = imagePath + photoPath + thumbsPath + xml.objects.*[i].photoUrl;
				var votes:int = xml.objects.*[i].votes;
				_totalOfVotes += votes;
				var objectToChoose:ObjectToChoose = new ObjectToChoose();
				objectToChoose.setName( xml.objects.*[i].name );
				objectToChoose.setInfo( xml.objects.*[i].info );
				objectToChoose.setUrlPhoto( urlPhoto );
				objectToChoose.setUrlThumb( urlThumb );
				objectToChoose.setNumberOfVotes( votes );
				objectToChoose.init();
				_arrayOfAllObjectsToChoose.push(objectToChoose);
			}
			_arrayOfObjectsToChoose = _arrayOfAllObjectsToChoose;
			loadXMLComplete.dispatch();
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			Debug.message(Debug.ERROR, " Erro ao carregar o xml do QUIZ da ErrorID: " +  event.errorID + " || " + event.text);
		}
		
		public function getRankingTopByCount(numberOfPositions:int):Vector.<ObjectToChoose>
		{
			var arrayOfRanking:Vector.<ObjectToChoose> = new Vector.<ObjectToChoose>();
			if(!_arrayOfRankingObjs){
				this.getRankingObjects();
			}
			for (var i:int = 0; i < numberOfPositions; i++) 
			{
				if(i < _arrayOfRankingObjs.length){
					arrayOfRanking.push(_arrayOfRankingObjs[i]);
				}else{
					arrayOfRanking.push(null);
				}
			}
			_arrayOfRankingObjs = null;
			return arrayOfRanking;
		}
		
		public function getRankingObjects():Vector.<ObjectToChoose>
		{
			_arrayOfRankingObjs = new Vector.<ObjectToChoose>();
			if(!_arrayOfVotes){
				this.getRankingVotes();
			}
			for (var i:int = 0; i < _arrayOfVotes.length; i++) 
			{
				_arrayOfRankingObjs.push(this.getObjectByVotes(_arrayOfVotes[i]));
			}
			_arrayOfVotes = null;
			return _arrayOfRankingObjs;
		}
		
		public function getRankingVotes():Array
		{
			_arrayOfObjs = _arrayOfAllObjectsToChoose.concat();
			_arrayOfVotes = [];
			var arrayOfRanking:Array = [];
			for (var i:int = 0; i < _arrayOfObjs.length; i++) 
			{
				var vote:int = int(Math.max.apply(null, getVotesArray(_arrayOfObjs)));
				_arrayOfVotes.push(vote);
				_totalOfVotes += vote;
				//_arrayOfObjs[_arrayOfObjs.indexOf(this.getObjectByVotes(vote))] = null;
				arrayOfRanking.push(this.getObjectByVotes(vote));
			}
			_arrayOfObjs = _arrayOfAllObjectsToChoose.concat();
			return _arrayOfVotes;
		}
		
		private function getVotesArray(array:Vector.<ObjectToChoose>):Array
		{
			var votesArray:Array = [];
			for (var i:int = 0; i < array.length; i++) 
			{
				if(array[i]){
					votesArray[i] = array[i].getNumberOfVotes();
				}else{
					votesArray[i] = null;
				}
			}
			return votesArray;
		}
		
		public function getObjectByVotes(votes:int):ObjectToChoose
		{
			var obj:ObjectToChoose;
			for (var i:int = 0; i < _arrayOfObjs.length; i++) 
			{
				obj = _arrayOfObjs[i];
				if(obj){
					if(obj.getNumberOfVotes() == votes){
						_arrayOfObjs[i] = null;
						return obj;
					}
				}
			}
			Debug.message(Debug.ERROR, "Objeto com " + votes + " votos não encontrado");
			return obj;
		}
		
		public function getObjectByName(name:String):ObjectToChoose
		{
			var obj:ObjectToChoose;
			for (var i:int = 0; i < _arrayOfAllObjectsToChoose.length; i++) 
			{
				obj = _arrayOfAllObjectsToChoose[i];
				if(obj.getName() == name){
					return obj;
				}
			}
			Debug.message(Debug.ERROR, "Objeto " + name + " não encontrado");
			return obj;
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

		
		public function setArrayOfObjectsToChoose(value:Vector.<ObjectToChoose>):void
		{
			_arrayOfObjectsToChoose = value;
		}
		
		public function getArrayOfObjectsToChoose():Vector.<ObjectToChoose>
		{
			return _arrayOfObjectsToChoose;
		}
		
		public function setArrayOfAllObjectsToChoose(value:Vector.<ObjectToChoose>):void
		{
			_arrayOfAllObjectsToChoose = value;
		}
		
		public function getArrayOfAllObjectsToChoose():Vector.<ObjectToChoose>
		{
			return _arrayOfAllObjectsToChoose;
		}
		
		public function setAppName(value:String):void
		{
			_appName = value;
		}
		
		public function getAppName():String
		{
			return _appName;
		}

		public function getUrlStartScreen():String
		{
			return _urlStartScreen;
		}

		public function setUrlStartScreen(value:String):void
		{
			_urlStartScreen = value;
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

		public function getUrlPhotoThumb1():String
		{
			return _urlPhotoThumb1;
		}

		public function setUrlPhotoThumb1(value:String):void
		{
			_urlPhotoThumb1 = value;
		}

		public function getUrlPhotoThumb2():String
		{
			return _urlPhotoThumb2;
		}

		public function setUrlPhotoThumb2(value:String):void
		{
			_urlPhotoThumb2 = value;
		}

		public function getUrlPhotoOver():String
		{
			return _urlPhotoOver;
		}

		public function setUrlPhotoOver(value:String):void
		{
			_urlPhotoOver = value;
		}

		public function getTotalOfVotes():int
		{
			return _totalOfVotes;
		}

		public function setTotalOfVotes(value:int):void
		{
			_totalOfVotes = value;
		}

		public function getUrlVs():String
		{
			return _urlVs;
		}

		public function setUrlVs(value:String):void
		{
			_urlVs = value;
		}

		public function getVsXPos():int
		{
			return _vsXPos;
		}

		public function setVsXPos(value:int):void
		{
			_vsXPos = value;
		}

		public function getVsYPos():int
		{
			return _vsYPos;
		}

		public function setVsYPos(value:int):void
		{
			_vsYPos = value;
		}


	}
}