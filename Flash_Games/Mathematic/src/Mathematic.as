package
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="800",height="600")]
	public class Mathematic extends Sprite
	{
		
		private var tutorialAsset:TutorialAsset;
		private var questionAsset:QuestionAsset;
		private var balloonAsset:NumBallonAsset;
		private var backgroundAsset:MathBackgroundAsset;
		private var operator:String;
		private var num1:Number;
		private var num2:Number;
		private var result:Number;
		private var arrayOfOperators:Array = ["+", "-", "X", "/"];
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var showTuto:Boolean;
		private var numberOfTutorials:int = 3;
		private var numberMaxOfTutorials:int = 1;
		private var timeBetweenTutorials:Number = 2;
		private var timer:MathTimerAsset;
		private var paused:Boolean = true;
		private var chanceInLevel:int = 6;
		private var balloonSpeed:int = 5;
		private var timeBetweenBalloons:int = 24;
		private var arrayOfBalloons:Array;
		private var correctAnswer:Boolean;
		private var lifes:int = 3;
		private var level:int;
		private var levelMax:int;
		private var loseScreen:LoseScreenAsset;
		private var winScreen:MathWinScreenAsset;
		private var onQuitFunction:Function;
		
		public function Mathematic()
		{
			init();
		}
		
		public function init():void
		{
			backgroundAsset = new MathBackgroundAsset();
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
				if((ticks % timeBetweenBalloons) == 0){
					createBalloon();
				}
				moveBalloons();
			}
		}
		
		private function createBalloon():void
		{
			balloonAsset = new NumBallonAsset();
			balloonAsset.x = Math.random() * (backgroundAsset.width-balloonAsset.width) + balloonAsset.width/2;
			balloonAsset.y = backgroundAsset.height + balloonAsset.height;
			var chanceOfCorrectNumber:int = Math.floor(Math.random()*10);
			var balloonNumber:Number;
			if(chanceOfCorrectNumber > chanceInLevel){
				balloonNumber = result;
			}else{
				balloonNumber = Math.floor(Math.random()*10000);
			}
			var typeBalloon:int = Math.floor(Math.random()*4)+1;
			balloonAsset.gotoAndStop(typeBalloon);
			balloonAsset.num.text = String(balloonNumber);
			balloonAsset.num.mouseEnabled = false;
			this.addChild(balloonAsset);
			arrayOfBalloons.push(balloonAsset);
			balloonAsset.buttonMode = true;
			balloonAsset.addEventListener(MouseEvent.CLICK, onClickBalloon);
			balloonAsset.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			balloonAsset.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickBalloon(event:MouseEvent):void
		{
			for (var i:int = 0; i < arrayOfBalloons.length; i++) 
			{
				if(arrayOfBalloons[i].name == event.currentTarget.name){
					arrayOfBalloons.splice(i, 1);
				}
			}
			destroyBalloon(event.currentTarget as MovieClip);
			if(event.currentTarget.num.text == String(result)){
				correctAnswer = true;
				paused = true;
				for (var j:int = 0; j < arrayOfBalloons.length; j++) 
				{
					destroyBalloon(arrayOfBalloons[j]);
					TweenLite.delayedCall(1, destroyQuestion);
				}
				nextLevel();
			}else{
				correctAnswer = false;
				resetLevel();
			}
		}
		
		private function resetLevel():void
		{
			lifes--;
			if(lifes < 0){
				paused = true;
				for (var j:int = 0; j < arrayOfBalloons.length; j++) 
				{
					destroyBalloon(arrayOfBalloons[j]);
					TweenLite.delayedCall(1, destroyQuestion);
				}
			}
		}
		
		private function nextLevel():void
		{
			level++;
			chanceInLevel++;
			balloonSpeed++;
		}
		
		private function destroyQuestion():void
		{
			TweenLite.to(questionAsset, .2, {scaleX:1.2, scaleY:1.2});
			TweenLite.to(questionAsset, .5, {scaleX:0, scaleY:0, alpha:0, delay:.5, onComplete:completeDestroyQuestion});
		}
		
		private function completeDestroyQuestion():void
		{
			this.removeEventListener(Event.ENTER_FRAME, update);
			if(lifes < 0){
				showLoseScreen();
			}else if(level >= levelMax){
				showWinScreen();
			}else{
				initGame();
			}
		}
		
		private function showWinScreen():void
		{
			resetValues();
			winScreen = new MathWinScreenAsset();
			this.addChild(winScreen);
			winScreen.addEventListener(MouseEvent.CLICK, onClickExit);
			/*winScreen.minutes.text = String(minutes);
			winScreen.seconds.text = String(seconds);
			winScreen.x = backgroundAsset.width/2;
			winScreen.y = backgroundAsset.height/2;*/
		}
		
		private function showLoseScreen():void
		{
			resetValues();
			loseScreen = new LoseScreenAsset();
			this.addChild(loseScreen);
			loseScreen.btnExit.buttonMode = true;
			loseScreen.btnExit.addEventListener(MouseEvent.CLICK, onClickExit);
			loseScreen.btnExit.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			loseScreen.btnExit.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			loseScreen.btnPlayAgain.buttonMode = true;
			loseScreen.btnPlayAgain.addEventListener(MouseEvent.CLICK, onClickPlayAgain);
			loseScreen.btnPlayAgain.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			loseScreen.btnPlayAgain.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			loseScreen.x = backgroundAsset.width/2;
			loseScreen.y = backgroundAsset.height/2;
		}
		
		protected function onClickPlayAgain(event:MouseEvent):void
		{
			resetGame();
		}
		
		private function resetGame():void
		{
			resetValues();
			removeLoseScreen();
			removeWinScreen();
			initGame();
		}
		
		private function resetValues():void
		{
			lifes = 3;
			chanceInLevel = 6;
			balloonSpeed = 5;
			timeBetweenBalloons = 24;
			ticks = 0;
			seconds = 0;
			minutes = 0;
		}
		
		private function removeWinScreen():void
		{
			if(winScreen){
				if(this.contains(winScreen)){
					this.removeChild(winScreen);
					winScreen = null;
				}
			}
		}
		
		private function removeLoseScreen():void
		{
			if(loseScreen){
				if(this.contains(loseScreen)){
					this.removeChild(loseScreen);
					loseScreen = null;
				}
			}
		}
		
		protected function onClickExit(event:MouseEvent):void
		{
			destroy();
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY += .1; 
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY -= .1; 
		}
		
		private function moveBalloons():void
		{
			for (var i:int = 0; i < arrayOfBalloons.length; i++) 
			{
				arrayOfBalloons[i].y -= balloonSpeed;
				if(arrayOfBalloons[i].y <= (-arrayOfBalloons[i].height)){
					this.removeChild(arrayOfBalloons[i]);
					arrayOfBalloons.splice(i, 1);
				}
			}
		}
		
		private function destroyBalloon(balloon:MovieClip):void
		{
			TweenLite.to(balloon, .2, {scaleX:1.2, scaleY:1.2});
			TweenLite.to(balloon, .5, {scaleX:0, scaleY:0, alpha:0, delay:.5, onComplete:completeDestroyBalloon, onCompleteParams:[balloon]});
		}
		
		private function completeDestroyBalloon(balloon:MovieClip):void
		{
			this.removeChild(balloon);
			balloon = null;
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
			num1 = Math.floor(Math.random() * 10);
			num2 = Math.floor(Math.random() * 10);
			operator = arrayOfOperators[Math.floor(Math.random()*4)];
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
			trace("CALC " + num1 + " " + operator + " " + num2);
			result = Math.floor(result);
			trace("RESULT " + result);
			return result;
		}
		
		private function completeCloseTutorial():void
		{
			hideTutorial();
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
			arrayOfBalloons = new Array();
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
			var assetHeight:Number = questionAsset.height;
			questionAsset.scaleX = questionAsset.scaleY = 0;
			TweenLite.to(questionAsset, .5, {scaleX:.8, scaleY:.8});
			TweenLite.to(questionAsset, .5, {y:assetHeight/2 + 10, scaleX:1, scaleY:1, delay: 3, onComplete:completeShowQuestion});
			calcOperation();
			updateQuestionValue();
		}
		
		private function updateQuestionValue():void
		{
			if(questionAsset){
				questionAsset.num1.text = String(num1);
				questionAsset.num2.text = String(num2);
				questionAsset.operator.text = String(operator);
			}
		}
		
		private function showTimer():void
		{
			if(!timer){
				timer = new MathTimerAsset();
				timer.x = 10;
				timer.y = 10;
				this.addChild(timer);
				timer.visible = false;
			}
		}
		
		private function completeShowQuestion():void
		{
			paused = false;
		}
		
		public function setOnQuitFunction(value:Function):void
		{
			onQuitFunction = value;
		}
		
		public function destroy():void
		{
			while(this.numChildren > 0){
				this.removeChild(this.getChildAt(0));
			}
			onQuitFunction();
		}
	}
}