package com.elements
{
	import com.data.DataInfo;
	import com.data.Debug;
	import com.data.FontEmbeder;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.osflash.signals.Signal;
	
	public class ObjectToChoose extends MovieClip
	{
		private var _name:String;
		private var _photo:Bitmap;
		private var _info:String;
		private var _urlThumb:String;
		private var _urlPhotoThumb1:String;
		private var _urlPhotoThumb2:String;
		private var _urlPhotoOver:String;
		private var _urlPhoto:String;
		private var _nameField:TextField;
		private var _infoField:TextField;
		private var _containerPhoto:Sprite;
		private var _containerThumb:Sprite;
		private var _containerPhotoOver:Sprite;
		private var _containerThumbPhoto1:Sprite;
		private var _containerThumbPhoto2:Sprite;
		private var _width:int = 290;
		private var _height:int = 370;
		private var _numberOfVotes:int;
		
		public var onClick:Signal;
		private var withOverAvaliable:Boolean;
		private var numberToAppear:int;
		
		public function ObjectToChoose()
		{
			super();
		}
		
		public function init():void
		{
			var placeHolder:Sprite = new Sprite();
			placeHolder.graphics.beginFill(0x000000, 0);
			placeHolder.graphics.drawRect(0, 0, 290, 370);
			placeHolder.graphics.endFill();
			this.addChild(placeHolder);
			
			_nameField = new TextField();
			_nameField.defaultTextFormat = FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_BEBAS_BOLD, 40);
			_nameField.text = _name;
			_nameField.textColor = 0xFFFFFF;
			_nameField.selectable = false;
			_nameField.autoSize = TextFieldAutoSize.LEFT;
			_nameField.x = placeHolder.width/2 - _nameField.textWidth/2;
			_nameField.y = placeHolder.y + placeHolder.height;// + _nameField.textHeight/2;
			this.addChild(_nameField);
			
			_infoField = new TextField();
			_infoField.defaultTextFormat = FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_BEBAS_BOOK, 30);
			_infoField.text = _info;
			_infoField.textColor = 0xFFFFFF;
			_infoField.selectable = false;
			_infoField.autoSize = TextFieldAutoSize.LEFT;
			_infoField.x = placeHolder.width/2 - _infoField.textWidth/2;
			_infoField.y = _nameField.y + _nameField.textHeight;
			this.addChild(_infoField);
			
			onClick = new Signal();
			_nameField = new TextField();
			_infoField = new TextField();
			this._nameField.text = _name;
			this._infoField.text = _info;
			this._containerThumb = new Sprite();
			this.addChild(_containerThumbPhoto1 = new Sprite());
			this.addChild(_containerThumbPhoto2 = new Sprite());
			this.addChild(_containerPhoto = new Sprite());
			this.addChild(_containerPhotoOver = new Sprite());
			_containerPhoto.x = _containerPhotoOver.x = 12;
			_containerPhoto.y = _containerPhotoOver.y = 12;
			_containerPhotoOver.visible = false;
			
			var dataInfo:DataInfo = DataInfo.getInstance();
			
			_urlPhotoThumb1 = dataInfo.getUrlPhotoThumb1();
			_urlPhotoThumb2 = dataInfo.getUrlPhotoThumb2();
			_urlPhotoOver = dataInfo.getUrlPhotoOver();
			
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadImagesHanlder);
			settings.onError(this.errorLoadImagesHanlder);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(4);
			settings.name("thumbs");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(_urlPhotoThumb1, {name:"thumb1", estimatedBytes:5000, container:_containerThumbPhoto1}));
			loader.append( new ImageLoader(_urlPhotoThumb2, {name:"thumb2", estimatedBytes:5000, container:_containerThumbPhoto2}));
			loader.append( new ImageLoader(_urlPhotoOver, {name:"photoOver", estimatedBytes:5000, container:_containerPhotoOver}));
			loader.append( new ImageLoader(_urlPhoto, {name:"photo", estimatedBytes:5000, container:_containerPhoto}));
			loader.append( new ImageLoader(_urlThumb, {name:"thumb", estimatedBytes:5000, container:_containerThumb}));
			loader.load();
			
			this.addEventListener(MouseEvent.CLICK, onClickObject);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			_containerPhotoOver.visible = false;
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			_containerPhotoOver.visible = true;
		}
		
		protected function onClickObject(event:MouseEvent):void
		{
			onClick.dispatch(this);
		}
		
		public function addVote():void
		{
			_numberOfVotes++;
		}
		
		private function loadPhotoHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "[ loadPhotoHandler ]");
			/*var thumb:Bitmap = event.target.rawContent as Bitmap;//LoaderMax.getContent("petThumb").rawContent;
			thumb.x -= thumb.width/2;
			thumb.y -= thumb.height/2;*/
		}
		
		private function completeLoadImagesHanlder(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "[ completeLoadImagesHanlder ]");
			withOverAvaliable = true;
		}
		
		private function errorLoadImagesHanlder(event:LoaderEvent):void
		{
			Debug.message(Debug.ERROR, event.text);
			withOverAvaliable = false;
		}

		public function getName():String
		{
			return _name;
		}

		public function setName(value:String):void
		{
			_name = value;
		}

		public function getInfo():String
		{
			return _info;
		}

		public function setInfo(value:String):void
		{
			_info = value;
		}

		public function getUrlPhoto():String
		{
			return _urlPhoto;
		}

		public function setUrlPhoto(value:String):void
		{
			_urlPhoto = value;
		}

		public function getUrlPhotoOver():String
		{
			return _urlPhotoOver;
		}

		public function setUrlPhotoOver(value:String):void
		{
			_urlPhotoOver = value;
		}

		public function getUrlPhotoThumb2():String
		{
			return _urlPhotoThumb2;
		}

		public function setUrlPhotoThumb2(value:String):void
		{
			_urlPhotoThumb2 = value;
		}

		public function getUrlPhotoThumb1():String
		{
			return _urlPhotoThumb1;
		}

		public function setUrlPhotoThumb1(value:String):void
		{
			_urlPhotoThumb1 = value;
		}

		public function setUrlThumb(value:String):void
		{
			_urlThumb = value;
		}

		public function getWidth():int
		{
			return _width;
		}

		public function setWidth(value:int):void
		{
			_width = value;
		}

		public function getHeight():int
		{
			return _height;
		}

		public function setHeight(value:int):void
		{
			_height = value;
		}

		public function setNumberOfVotes(value:int):void
		{
			_numberOfVotes = value;
		}

		public function getNumberOfVotes():int
		{
			return _numberOfVotes;
		}

		public function getContainerThumb():Sprite
		{
			return _containerThumb;
		}

		public function setContainerThumb(value:Sprite):void
		{
			_containerThumb = value;
		}
		
		public function addNumberToAppear():void
		{
			numberToAppear++;
		}
		
		public function getNumberToAppear():int
		{
			return numberToAppear;
		}

	}
}