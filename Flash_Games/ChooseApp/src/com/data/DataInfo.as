package com.data
{
	import com.elements.ObjectToChoose;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	
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
		private var _numberOfObjectToChoose:int;
		
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
		private var imagePath:String = "../assets/";
		private var fontPath:String = imagePath + "fonts/";
		private var photoPath:String = "personalities/";
		
		public var loadXMLComplete:Signal = new Signal();
		
		[Embed(source=fontPath + "BebasNeue Bold.otf", fontFamily="BedasNeueBold", mimeType="application/x-font")]
		private var _bebasNeueBold:Class;
		private var bedasNeueBoldFormat:TextFormat;
		[Embed(source=fontPath + "BebasNeue Regular.otf", fontFamily="BedasNeueRegular", mimeType="application/x-font")]
		private var _bebasNeueRegular:Class;
		private var bedasNeueRegularFormat:TextFormat;
		
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
			createTextFormats();
			
			xmlRequest = new URLRequest(urlXML);
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, completeLoadXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.load(xmlRequest);
		}
		
		private function createTextFormats():void
		{
			bedasNeueFormat = new TextFormat();
			bedasNeueFormat.font = "bedasNeueFormat";
			
			
		}
		
		protected function completeLoadXML(event:Event):void
		{
			_arrayOfObjectsToChoose = new Vector.<ObjectToChoose>();
			_arrayOfAllObjectsToChoose = new Vector.<ObjectToChoose>();
			var xml:XML = new XML(event.target.data);
			_appName = xml.app.@name;
			
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
			
			var numberOfObjectsXML:int = xml.objects.object.length();
			
			for (var i:int = 0; i < numberOfObjectsXML; i++) 
			{
				var urlPhoto:String = imagePath + photoPath + xml.objects.*[i].photoUrl;
				var objectToChoose:ObjectToChoose = new ObjectToChoose();
				objectToChoose.setName( xml.objects.*[i].name );
				objectToChoose.setInfo( xml.objects.*[i].info );
				objectToChoose.setUrlPhoto( urlPhoto );
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

		public function getBebasNeueBold():Class
		{
			return _bebasNeueBold;
		}

		public function setBebasNeueBold(value:Class):void
		{
			_bebasNeueBold = value;
		}


	}
}