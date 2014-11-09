package com.data
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Result extends Sprite
	{
		private var _name:String;
		private var _type:String;
		private var _photo:Sprite;
		private var _photoUrl:String;
		private var _typePhoto:Sprite;
		private var _typePhotoUrl:String;
		private var _nameTextField:TextField;
		private var _offSetX:int = 10;
		private var quizData:QuizDataInfo;
		private var _imagePath:String;
		private var _shareImgUrl:String;
		private var _containerGold:Sprite;
		private var _containerSilver:Sprite;
		private var _containerBronze:Sprite;
		
		public function Result()
		{
			quizData = QuizDataInfo.getInstance();
			_imagePath = quizData.getImagePath();
		}
		
		public function fillResult():void
		{
			
			_typePhotoUrl = _imagePath + _type + ".png";
			
			_photo = new Sprite();
			this.addChild(_photo);
			_typePhoto = new Sprite();
			this.addChild(_typePhoto);
			
			var placeHolderPhoto:Sprite = new Sprite();
			placeHolderPhoto.graphics.beginFill(0x000000, 0);
			placeHolderPhoto.graphics.drawRect(0, 0, 424, 438);
			placeHolderPhoto.graphics.endFill();
			_photo.addChild(placeHolderPhoto);
			//_photo.y = quizData.getAppHeight() - _photo.height;
			
			var placeHolderTypePhoto:Sprite = new Sprite();
			placeHolderTypePhoto.graphics.beginFill(0x000000, 0);
			placeHolderTypePhoto.graphics.drawRect(0, 0, 260, 210);
			placeHolderTypePhoto.graphics.endFill();
			_typePhoto.addChild(placeHolderTypePhoto);
			//_typePhoto.x = quizData.getAppWidth()/2 + quizData.getAppWidth()/16;
			_typePhoto.x = placeHolderPhoto.width;
			_typePhoto.y = _photo.height/3;
			
			_nameTextField = new TextField();
			this.addChild(_nameTextField);
			_nameTextField.text = _name;
			//_resultTextField.defaultTextFormat = FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_LATO_BLACK, 100);
			_nameTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_LATO_BLACK, 120));
			_nameTextField.textColor = 0xFFFFFF;
			_nameTextField.selectable = false;
			_nameTextField.autoSize = TextFieldAutoSize.LEFT;
			_nameTextField.x = quizData.getAppWidth()/2 - _offSetX*2;
			//_nameTextField.y = quizData.getAppHeight()/2 - _nameTextField.textHeight;
			
			load();
		}
		
		public function calcPontuactionResult():void
		{
			_containerGold = new Sprite();
			_containerSilver = new Sprite();
			_containerBronze = new Sprite();
			
			var placeHolder:Sprite = new Sprite();
			placeHolder.graphics.beginFill(0x000000, 0);
			placeHolder.graphics.drawRect(0, 0, quizData.getResultWidth(), quizData.getResultHeight());
			placeHolder.graphics.endFill();
			_containerGold.addChild(placeHolder);
			
			load();
			var totalOfQuestions:int = quizData.getNumberOfQuestionsToAnswer();
			var correctAnswers:int = quizData.getNumberOfCorrectAnswers();
			var finalResult:int = totalOfQuestions/correctAnswers;
			
			if(finalResult >= totalOfQuestions*.6){
				this.addChild(_containerGold);
				this._shareImgUrl = _imagePath + "goldShare.png";
				//_containerGold.x = quizData.getAppWidth()/2 - _containerGold.width/2;
				//_containerGold.y = quizData.getAppHeight()/2 - _containerGold.height/2;
			}else if(finalResult >= totalOfQuestions*.3){
				this.addChild(_containerSilver);
				this._shareImgUrl = _imagePath + "silverShare.png";
				//_containerSilver.x = quizData.getAppWidth()/2 - _containerGold.width/2;
				//_containerSilver.y = quizData.getAppHeight()/2 - _containerGold.height/2;
			}else{
				this.addChild(_containerBronze);
				this._shareImgUrl = _imagePath + "bronzeShare.png";
				//_containerBronze.x = quizData.getAppWidth()/2 - _containerGold.width/2;
				//_containerBronze.y = quizData.getAppHeight()/2 - _containerGold.height/2;
			}
		}
		
		public function load():void
		{
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("photoResults");
			
			var loader:LoaderMax = new LoaderMax(settings);
			if(quizData.getQuizType() == quizData.TYPE_QUIZ){
				loader.append( new ImageLoader(quizData.getUrlRankingGold(), {name:"goldenRanking", estimatedBytes:5000, container:_containerGold}));
				loader.append( new ImageLoader(quizData.getUrlRankingSilver(), {name:"silverRanking", estimatedBytes:5000, container:_containerSilver}));
				loader.append( new ImageLoader(quizData.getUrlRankingBronze(), {name:"bronzeRanking", estimatedBytes:5000, container:_containerBronze}));
			}else{
				loader.append( new ImageLoader(_photoUrl, {name:"photoResult", estimatedBytes:5000/*, onComplete:completeLoadImageHandler*/, container:_photo}));
				loader.append( new ImageLoader(_typePhotoUrl, {name:"typePhotoResult", estimatedBytes:5000/*, onComplete:completeLoadImageHandler*/, container:_typePhoto}));
			}
			loader.load();
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			
		}
		
		public function setName(value:String):void
		{
			_name = value;
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public function setType(value:String):void
		{
			_type = value;
		}
		
		public function getType():String
		{
			return _type;
		}

		public function getPhoto():Sprite
		{
			return _photo;
		}

		public function setPhoto(value:Sprite):void
		{
			_photo = value;
		}

		public function getTypePhoto():Sprite
		{
			return _typePhoto;
		}

		public function setTypePhoto(value:Sprite):void
		{
			_typePhoto = value;
		}

		public function getTypePhotoUrl():String
		{
			return _typePhotoUrl;
		}

		public function setTypePhotoUrl(value:String):void
		{
			_typePhotoUrl = value;
		}

		public function getPhotoUrl():String
		{
			return _photoUrl;
		}

		public function setPhotoUrl(value:String):void
		{
			_photoUrl = value;
		}
		
		public function setImagePath(value:String):void
		{
			_imagePath = value;
		}
		
		public function setShareImgUrl(value:String):void
		{
			_shareImgUrl = value;
		}
		
		public function getShareImgUrl():String
		{
			return _shareImgUrl;
		}
	}
}