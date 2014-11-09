package com.elements
{
	import com.data.DataInfo;
	import com.data.FontEmbeder;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class ThumbRanking extends Sprite
	{
		private var _personality:ObjectToChoose;
		private var _photo:Sprite;
		private var _name:String;
		private var _percent:String;
		private var _nameTextField:TextField;
		private var _percentTextField:TextField;
		private var offSetY:Number = 10;
		private var _thumbWidth:int = 179;
		private var _thumbHeight:int = 179;
		private var _position:int;
		
		public function ThumbRanking()
		{
		}
		
		public function updateInfo():void
		{
			var placeHolder:Sprite = new Sprite();
			placeHolder.graphics.beginFill(0x000000, 0);
			placeHolder.graphics.drawRect(0, 0, 179, 179);
			placeHolder.graphics.endFill();
			this.addChild(placeHolder);
			
			_name = "#" + String(_position) + " " + _personality.getName();
			
			var dataInfo:DataInfo = DataInfo.getInstance();
			var numPercent:Number = Math.ceil((_personality.getNumberOfVotes()/dataInfo.getTotalOfVotes()) * 100);
			//var numPercent:Number = Math.floor((_personality.getNumberOfVotes()/_personality.getNumberToAppear()) * 100);
			_percent = String(numPercent) + "%";
			_photo = _personality.getContainerThumb();
			this.addChild(_photo);
			
			_nameTextField = new TextField();
			_nameTextField.text = _name;
			//_nameTextField.defaultTextFormat = FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_BEBAS_BOLD, 45);
			_nameTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_BEBAS_REGULAR, 28))
			_nameTextField.textColor = 0xFFFFFF;
			_nameTextField.selectable = false;
			_nameTextField.autoSize = TextFieldAutoSize.LEFT;
			_nameTextField.y = this.height;
			this.addChild(_nameTextField);
			
			_percentTextField = new TextField();
			_percentTextField.text = _percent;
			//_percentTextField.defaultTextFormat = FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_BEBAS_REGULAR, 25);
			_percentTextField.setTextFormat(FontEmbeder.getTextFormatInstanceByFontName(FontEmbeder.FONT_NAME_BEBAS_BOLD, 30));
			_percentTextField.textColor = 0xFFFFFF;
			_percentTextField.selectable = false;
			_percentTextField.autoSize = TextFieldAutoSize.LEFT;
			_percentTextField.y = _nameTextField.y + _nameTextField.textHeight;
			this.addChild(_percentTextField);
		}
		
		public function setPhoto(value:ObjectToChoose):void
		{
			_personality = value;
		}

		public function getThumbWidth():int
		{
			return _thumbWidth;
		}

		public function setThumbWidth(value:int):void
		{
			_thumbWidth = value;
		}

		public function getThumbHeight():int
		{
			return _thumbHeight;
		}

		public function setThumbHeight(value:int):void
		{
			_thumbHeight = value;
		}


		public function setPosition(value:int):void
		{
			_position = value;
		}
	}
}