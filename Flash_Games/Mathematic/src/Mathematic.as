package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Mathematic extends Sprite
	{
		
		private var tutorialAsset:TutorialAsset;
		private var questionAsset:QuestionAsset;
		private var ballonAsset:NumBallonAsset;
		private var backgroundAsset:BackgroundAsset;
		private var operator:String;
		private var result:Number;
		private var arrayOfOperators:Array = ["+", "-", "X", "/"];
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var showTuto:Boolean;
		
		public function Mathematic()
		{
			init();
		}
		
		public function init():void
		{
			backgroundAsset = new BackgroundAsset();
			this.addChild(backgroundAsset);
			
			showTutorial();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function update(event:Event):void
		{
			ticks++;
			if(ticks >= 24){
				ticks = 0;
				seconds++;
			}
			if(seconds >= 60){
				seconds = 0;
				minutes++;
			}
			
			if(showTuto){
				trace(seconds);
				if(seconds % 5 == 0){
					hideTutorial()
				}
			}
		}
		
		private function showTutorial():void
		{
			tutorialAsset = new TutorialAsset();
			this.addChild(tutorialAsset);
			tutorialAsset.x = backgroundAsset.width/2;
			tutorialAsset.y = backgroundAsset.height/2;
			
			var tutoNum1:int = Math.floor(Math.random() * 100);
			var tutoNum2:int = Math.floor(Math.random() * 100);
			trace(arrayOfOperators[Math.floor(Math.random()*4)]);
			var tutoOperator:String = arrayOfOperators[Math.floor(Math.random()*4)];
			var tutoResult:int;
			switch(tutoOperator)
			{
				case "+":
				{
					tutoResult = tutoNum1 + tutoNum2;
					break;
				}
				case "-":
				{
					tutoResult = tutoNum1 - tutoNum2;
					break;
				}
				case "/":
				{
					tutoResult = tutoNum1 / tutoNum2;
					break;
				}
				case "X":
				{
					tutoResult = tutoNum1 * tutoNum2;
					break;
				}
			}
			tutorialAsset.num1.text = String(tutoNum1);
			tutorialAsset.num2.text = String(tutoNum2);
			tutorialAsset.operator.text = String(tutoOperator);
			tutorialAsset.resp.text = String(tutoResult);
			showTuto = true;
		}
		
		private function hideTutorial():void
		{
			if(showTuto){
				showTuto = false;
				this.removeChild(tutorialAsset);
				tutorialAsset = null;
				showTutorial();
			}
		}
	}
}