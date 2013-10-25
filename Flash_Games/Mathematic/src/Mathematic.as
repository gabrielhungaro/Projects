package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="800",height="600")]
	public class Mathematic extends Sprite
	{
		
		private var tutorialAsset:TutorialAsset;
		private var questionAsset:QuestionAsset;
		private var ballonAsset:NumBallonAsset;
		private var backgroundAsset:BackgroundAsset;
		private var operator:String;
		private var num1:Number;
		private var num2:Number;
		private var result:Number;
		private var arrayOfOperators:Array = ["+", "-", "X", "/"];
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var showTuto:Boolean;
		private var numberOfTutorials:int = 0;
		private var numberMaxOfTutorials:int = 3;
		private var timeBetweenTutorials:Number = 2;
		private var timer:TimerAsset;
		private var paused:Boolean = true;
		
		public function Mathematic()
		{
			init();
		}
		
		public function init():void
		{
			backgroundAsset = new BackgroundAsset();
			this.addChild(backgroundAsset);
			
			showTutorial();
		}
		
		protected function update(event:Event):void
		{
			if(!paused){
				ticks++;
				if(ticks >= 24){
					ticks = 0;
					seconds++;
				}
				if(seconds >= 60){
					seconds = 0;
					minutes++;
				}
				if(timer){
					timer.minutes.text = String(minutes);
					timer.seconds.text = String(seconds);
				}
			}
		}
		
		private function showTutorial():void
		{
			numberOfTutorials++;
			tutorialAsset = new TutorialAsset();
			this.addChild(tutorialAsset);
			tutorialAsset.x = backgroundAsset.width/2;
			tutorialAsset.y = backgroundAsset.height/2;
			tutorialAsset.scaleX = tutorialAsset.scaleY = 0;
			
			var tutoResult:Number = calcOperation();
			
			tutorialAsset.num1.text = String(num1);
			tutorialAsset.num2.text = String(num2);
			tutorialAsset.operator.text = String(operator);
			tutorialAsset.resp.text = String(tutoResult);
			TweenLite.to(tutorialAsset, .5, {scaleX:1, scaleY:1});
			TweenLite.to(tutorialAsset, .5, {scaleX:0, scaleY:0, delay:3, onComplete:completeCloseTutorial});
		}
		
		private function calcOperation():Number
		{
			num1 = Math.floor(Math.random() * 100);
			num2 = Math.floor(Math.random() * 100);
			operator = arrayOfOperators[Math.floor(Math.random()*4)];
			trace(operator);
			switch(operator)
			{
				case "+":
				{
					result = num1 + num2;
					break;
				}
				case "-":
				{
					result = num1 - num2;
					break;
				}
				case "/":
				{
					result = num1 / num2;
					break;
				}
				case "X":
				{
					result = num1 * num2;
					break;
				}
			}
			return result;
		}
		
		private function completeCloseTutorial():void
		{
			hideTutorial()
		}
		
		private function hideTutorial():void
		{
			this.removeChild(tutorialAsset);
			tutorialAsset = null;
			if(numberOfTutorials >= numberMaxOfTutorials){
				initGame();
			}else{
				TweenLite.delayedCall(timeBetweenTutorials, showTutorial);
			}
		}
		
		private function initGame():void
		{
			showQuestion();
			showTimer();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function showQuestion():void
		{
			questionAsset = new QuestionAsset();
			this.addChild(questionAsset);
			questionAsset.x = backgroundAsset.width/2;
			questionAsset.y = backgroundAsset.height/2;
			questionAsset.scaleX = questionAsset.scaleY = 0;
			TweenLite.to(questionAsset, .5, {scaleX:1, scaleY:1, onComplete:completeShowQuestion});
		}
		
		private function showTimer():void
		{
			if(!timer){
				timer = new TimerAsset();
				timer.x = 10;
				timer.y = 10;
				this.addChild(timer);
			}
		}
		
		private function completeShowQuestion():void
		{
			paused = false;
		}
	}
}