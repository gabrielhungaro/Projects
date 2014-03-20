package com.data
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Alternative extends MovieClip
	{
		public var alternativeText:String;
		public var alternativeLetter:String;
		public var alternativeTextField:TextField;
		public var letterTextField:TextField;
		private var offSetX:Number = 10;
		private var offSetY:Number = 10;
		private var CORRECT:String = "correct";
		private var WRONG:String = "wrong";
		private var OUT:String = "out";
		private var OVER:String = "over";
		
		private var urlAlternativeImg:String;
		private var urlAlternativeOver:String;
		private var urlAlternativeCorrect:String;
		private var urlAlternativeWrong:String;
		private var backgroundSprite:Sprite;
		
		public function Alternative()
		{
			var quizData:DataInfo = DataInfo.getInstance();
			urlAlternativeImg = quizData.getUrlAlternative();
			urlAlternativeOver = quizData.getUrlAlternativeOver();
			urlAlternativeCorrect = quizData.getUrlAlternativeCorrect();
			urlAlternativeWrong = quizData.getUrlAlternativeWrong();
			
			alternativeTextField = new TextField();
			
			letterTextField = new TextField();
			
			backgroundSprite = new Sprite();
			backgroundSprite.graphics.beginFill(0x808080, 1);
			backgroundSprite.graphics.drawRect(0, 0, quizData.getAppWidth()/3, 50);
			backgroundSprite.graphics.endFill();
			
			this.addChild(backgroundSprite);
			this.addChild(letterTextField);
			this.addChild(alternativeTextField);
		}
		
		public function fillAlternative():void
		{
			alternativeTextField.autoSize = letterTextField.autoSize = "left";
			alternativeTextField.selectable = letterTextField.selectable = false;
			var quizData:DataInfo = DataInfo.getInstance();
			alternativeTextField.text = alternativeText;
			letterTextField.text = alternativeLetter;
			
			alternativeTextField.y = backgroundSprite.height/2 - alternativeTextField.textHeight;
			letterTextField.y = backgroundSprite.height/2 - letterTextField.textHeight;
			alternativeTextField.x = letterTextField.x + letterTextField.textWidth + offSetX;
			this.updateAnswerStatus(OUT);
		}
		
		public function updateAnswerStatus(status:String):void
		{
			switch(status){
				case CORRECT:
					letterTextField.textColor = 0x008000;
					alternativeTextField.textColor = 0x008000;
					break;
				case WRONG:
					letterTextField.textColor = 0x800000;
					alternativeTextField.textColor = 0x800000;
					break;
				case OVER:
					letterTextField.textColor = 0xFFFFFF;
					alternativeTextField.textColor = 0xFFFFFF;
					break;
				case OUT:
					letterTextField.textColor = 0x000000;
					alternativeTextField.textColor = 0x000000;
					break;
			}
		}
	}
}