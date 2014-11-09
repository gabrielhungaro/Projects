package com.data
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Alternative extends MovieClip
	{
		public var alternativeText:String;
		public var alternativeLetter:String;
		public var alternativeTextField:TextField;
		public var letterTextField:TextField;
		private var _correctImg:Sprite;
		private var _overImg:Sprite;
		private var offSetX:Number = 10;
		private var offSetY:Number = 10;
		private var CORRECT:String = "correct";
		private var WRONG:String = "wrong";
		private var OUT:String = "out";
		private var OVER:String = "over";
		private var choosedTimes:int;
		
		private var urlAlternativeImg:String;
		private var urlAlternativeOver:String;
		private var urlAlternativeCorrect:String;
		private var urlAlternativeWrong:String;
		private var backgroundSprite:Sprite;
		private var _containerImg:Sprite;
		private var _containerImgOver:Sprite;
		private var _containerImgWrong:Sprite;
		private var _containerImgCorrect:Sprite;
		private var _correctLabelAvaliable:Boolean = false;
		private var _overLabelAvaliable:Boolean = false;
		private var _wrongLabelAvaliable:Boolean = false;
		private var _currentState:String;
		private var _isSelected:Boolean;
		private var _width:int;
		private var _height:int;
		
		public function Alternative(width:int = 0, height:int = 0)
		{
			var quizData:QuizDataInfo = QuizDataInfo.getInstance();
			if(width == 0){
				_width = quizData.getAppWidth()/3;
				_height = 95;
			}else{
				_width = width;
				_height = height;
			}
			urlAlternativeImg = quizData.getUrlAlternative();
			urlAlternativeOver = quizData.getUrlAlternativeOver();
			urlAlternativeCorrect = quizData.getUrlAlternativeCorrect();
			urlAlternativeWrong = quizData.getUrlAlternativeWrong();
			
			alternativeTextField = new TextField();
			
			letterTextField = new TextField();
			
			backgroundSprite = new Sprite();
			backgroundSprite.graphics.beginFill(0x808080, 0);
			backgroundSprite.graphics.drawRect(0, 0, _width, _height);
			backgroundSprite.graphics.endFill();
			this.addChild(backgroundSprite);
			
			_containerImg = new Sprite();
			this.addChild(_containerImg);
			_containerImgOver = new Sprite();
			this.addChild(_containerImgOver);
			_containerImgCorrect = new Sprite();
			this.addChild(_containerImgCorrect);
			_containerImgWrong = new Sprite();
			this.addChild(_containerImgWrong);
			
			this.addChild(letterTextField);
			this.addChild(alternativeTextField);
			
			load();
		}
		
		public function load():void
		{
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("alternativeImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(urlAlternativeImg, {name:"alternativeImg", estimatedBytes:5000/*, onComplete:completeLoadImageHandler*/, container:_containerImg}));
			loader.append( new ImageLoader(urlAlternativeOver, {name:"alternativeOver", estimatedBytes:5000, onComplete:completeLoadOverImageHandler, container:_containerImgOver}));
			loader.append( new ImageLoader(urlAlternativeWrong, {name:"alternativeWrong", estimatedBytes:5000, onComplete:completeLoadWrongImageHandler, container:_containerImgWrong}));
			loader.append( new ImageLoader(urlAlternativeCorrect, {name:"alternativeCorrect", estimatedBytes:5000, onComplete:completeLoadCorrectImageHandler, container:_containerImgCorrect}));
			loader.load();
		}
		
		private function completeLoadOverImageHandler(event:LoaderEvent):void
		{
			_overLabelAvaliable = true;
			updateAnswerStatus(OUT);
		}
		
		private function completeLoadWrongImageHandler(event:LoaderEvent):void
		{
			_wrongLabelAvaliable = true;
			updateAnswerStatus(OUT);
		}
		
		private function completeLoadCorrectImageHandler(event:LoaderEvent):void
		{
			_correctLabelAvaliable = true;
			updateAnswerStatus(OUT);
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			
		}
		
		public function fillAlternative():void
		{
			var quizData:QuizDataInfo = QuizDataInfo.getInstance();
			_isSelected = false;
			alternativeTextField.selectable = letterTextField.selectable = false;
			alternativeTextField.multiline = true;
			alternativeTextField.background = false;
			alternativeTextField.backgroundColor = 0xFF0000;
			alternativeTextField.wordWrap = true;
			alternativeTextField.text = alternativeText;
			alternativeTextField.textColor = quizData.getAlternativeColor();
			alternativeTextField.mouseEnabled = false;
			alternativeTextField.autoSize = letterTextField.autoSize = "left";
			alternativeTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(quizData.getAlternativeFont(), quizData.getAlternativeSize()));
			
			letterTextField.text = alternativeLetter;
			letterTextField.mouseEnabled = false;
			letterTextField.textColor = quizData.getAlternativeColor();
			letterTextField.y = backgroundSprite.height/2 - letterTextField.textHeight/2;
			letterTextField.x = offSetX*4;
			letterTextField.visible = quizData.getAlternativeLetterVisibility();
			letterTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(quizData.getAlternativeFont(), quizData.getAlternativeSize()));
			
			//alternativeTextField.autoSize = "none";
			alternativeTextField.y = backgroundSprite.height/2 - alternativeTextField.textHeight/2;
			alternativeTextField.x = letterTextField.x + letterTextField.textWidth + offSetX;
			alternativeTextField.width = backgroundSprite.width - alternativeTextField.x;
			this.updateAnswerStatus(OUT);
		}
		
		public function updateAnswerStatus(status:String):void
		{
			switch(status){
				case CORRECT:
					if(_correctLabelAvaliable){
						_containerImg.visible = false;
						_containerImgOver.visible = false;
						_containerImgWrong.visible = false;
						_containerImgCorrect.visible = true;
					}else{
						letterTextField.textColor = 0x008000;
						alternativeTextField.textColor = 0x008000;
					}
					break;
				case WRONG:
					if(_wrongLabelAvaliable){
						_containerImg.visible = false;
						_containerImgOver.visible = false;
						_containerImgWrong.visible = true;
						_containerImgCorrect.visible = false;
					}else{
						letterTextField.textColor = 0x800000;
						alternativeTextField.textColor = 0x800000;
					}
					break;
				case OVER:
					if(!_isSelected){
						if(_overLabelAvaliable){
							_containerImg.visible = false;
							_containerImgOver.visible = true;
							_containerImgWrong.visible = false;
							_containerImgCorrect.visible = false;
						}else{
							letterTextField.textColor = 0x666666;
							alternativeTextField.textColor = 0x666666;
						}
					}
					break;
				case OUT:
					if(!_isSelected){
						if(_overLabelAvaliable){
							_containerImg.visible = true;
							_containerImgOver.visible = false;
							_containerImgWrong.visible = false;
							_containerImgCorrect.visible = false;
							letterTextField.textColor = 0x000000;
							alternativeTextField.textColor = 0x000000;
						}else{
							letterTextField.textColor = 0x000000;
							alternativeTextField.textColor = 0x000000;
						}
					}
					break;
			}
			_currentState = status
		}
		
		public function addChoosedTime():void
		{
			choosedTimes++;
		}
		
		public function getNumberOfChoosedTimes():int
		{
			return choosedTimes;
		}
		
		public function setIsSelected(value:Boolean):void
		{
			_isSelected = value;
		}
	}
}