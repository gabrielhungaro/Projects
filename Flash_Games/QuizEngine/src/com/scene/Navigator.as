package com.scene
{
	import com.data.FontEmbeder;
	import com.data.QuizDataInfo;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class Navigator extends Sprite
	{
		private const NAVIGATOR_TEXT_TYPE:String = "text";
		private const NAVIGATOR_IMG_TYPE:String = "image";
		private var quizData:QuizDataInfo;
		private var _actualNumber:String;
		private var _totalNumbers:String;
		private var _navigatorTextField:TextField;
		private var _containerNavigator:Sprite;
		private var _containerNavigatorIdicator:Sprite;
		private var _containerNavigatorIdicatorActual:Sprite;
		private var navigatorImg:ContentDisplay;
		private var arrayOfIndicator:Array;
		private var arrayOfIndicatorActual:Array;
		
		public function Navigator()
		{
			super();
		}
		
		public function init():void
		{
			quizData = QuizDataInfo.getInstance();	
			arrayOfIndicator = [];
			arrayOfIndicatorActual = [];
			if(quizData.getNavigatorType() == NAVIGATOR_TEXT_TYPE){
				_navigatorTextField = new TextField();
				_navigatorTextField.selectable = false;
				_navigatorTextField.mouseEnabled = false;
				this.addChild(_navigatorTextField);
				_navigatorTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(quizData.getNavigatorFont(), quizData.getNavigatorFontSize()));
				_navigatorTextField.textColor = quizData.getNavigatorFontColor();
				/*_actualNumber = new TextField();
				this.addChild(_actualNumber);
				
				_totalNumbers = new TextField();
				this.addChild(_totalNumbers);*/
				updateTextNavigator();
			}else{
				_containerNavigator = new Sprite();
				this.addChild(_containerNavigator);
				load();
			}
		}
		
		public function updateNavigator():void
		{
			if(quizData.getNavigatorType() == NAVIGATOR_TEXT_TYPE){
				updateTextNavigator();
			}else{
				for (var i:int = 0; i < arrayOfIndicator.length; i++) 
				{
					if((i+1) == quizData.getActualQuestion()){
						arrayOfIndicatorActual[i].visible = true;
					}else{
						arrayOfIndicatorActual[i].visible = false;
					}
				}
			}
		}
		
		private function updateTextNavigator():void
		{
			_actualNumber = String(quizData.getActualQuestion());
			_totalNumbers = String(quizData.getNumberOfQuestionsToAnswer());
			_navigatorTextField.text = "(" + _actualNumber + "/" + _totalNumbers + ")";
		}		
		
		public function load():void
		{
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(1);
			settings.name("navigator");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(quizData.getUrlNavigator(), {name:"navigator", estimatedBytes:5000/*, onComplete:completeLoadImageHandler*/, container:_containerNavigator}));
			loader.append( new ImageLoader(quizData.getUrlNavigatorIndicator(), {name:"navigatorIndicator", estimatedBytes:5000, onComplete:onCompleteLoadIndicatorHandle}));
			loader.append( new ImageLoader(quizData.getUrlNavigatorIndicatorActual(), {name:"navigatorIndicatorActual", estimatedBytes:5000, onComplete:onCompleteLoadIndicatorActualHandle}));
			LoaderMax.prioritize("navigatorIndicator");
			//loader.prioritize(true);
			loader.load();
		}
		
		private function onCompleteLoadIndicatorHandle(event:LoaderEvent):void
		{
			var navigatorImg:Bitmap = event.target.rawContent;
			var bitmapData:BitmapData;
			var navigatorBitmap:Bitmap;
			
			for (var i:int = 0; i < quizData.getNumberOfQuestionsToAnswer(); i++) 
			{
				bitmapData = new BitmapData( navigatorImg.width, navigatorImg.height, true );
				bitmapData.copyPixels( navigatorImg.bitmapData, navigatorImg.bitmapData.rect, new Point(0,0) );
				navigatorBitmap = new Bitmap( bitmapData );
				
				_containerNavigatorIdicator = new Sprite();
				this.addChild(_containerNavigatorIdicator);
				arrayOfIndicator.push(_containerNavigatorIdicator);
				_containerNavigatorIdicator.addChild(navigatorBitmap);
			}
			
		}
		
		private function onCompleteLoadIndicatorActualHandle(event:LoaderEvent):void
		{
			var navigatorImg:Bitmap = event.target.rawContent;
			var bitmapData:BitmapData;
			var navigatorBitmap:Bitmap;
			for (var i:int = 0; i < quizData.getNumberOfQuestionsToAnswer(); i++) 
			{
				bitmapData = new BitmapData( navigatorImg.width, navigatorImg.height, true );
				bitmapData.copyPixels( navigatorImg.bitmapData, navigatorImg.bitmapData.rect, new Point(0,0) );
				navigatorBitmap = new Bitmap( bitmapData );
				
				_containerNavigatorIdicatorActual = new Sprite();
				this.addChild(_containerNavigatorIdicatorActual);
				arrayOfIndicatorActual.push(_containerNavigatorIdicatorActual);
				_containerNavigatorIdicatorActual.addChild(navigatorBitmap);
				//_containerNavigatorIdicatorActual.visible = false;
			}
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			drawNavigator();
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			
		}
		
		private function drawNavigator():void
		{
			for (var i:int = 0; i < arrayOfIndicator.length; i++) 
			{
				arrayOfIndicator[i].x = (_containerNavigator.width + (_containerNavigator.width/quizData.getNumberOfQuestionsToAnswer()))/quizData.getNumberOfQuestionsToAnswer() * i;
				arrayOfIndicator[i].y = -arrayOfIndicator[i].height/2 + _containerNavigator.height/2;
				arrayOfIndicatorActual[i].x = arrayOfIndicator[i].x;
				arrayOfIndicatorActual[i].y = arrayOfIndicator[i].y;
				/*var middleOfAlternativeList:int = (numberOfCols * arrayOfAlternatives[j].width)/2;
				var initialPosX:int = (mcAlternativeContainer.width/2) - middleOfAlternativeList;
				arrayOfAlternatives[j].x = initialPosX + (arrayOfAlternatives[j].width*cols);*/
			}
			updateNavigator();
		}
	}
}