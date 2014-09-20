package
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.ui.Keyboard;
	
	[SWF(width="800",height="600")]
	public class Labirinty extends Sprite
	{
		
		private var arrayOfLabirinties:Array;
		private var hero:HeroAsset;
		private var startPoint:MovieClip;
		private var endPoint:MovieClip;
		private var activeLabirinty:MovieClip;
		private var isLeft:Boolean;
		private var isRight:Boolean;
		private var isUp:Boolean;
		private var isDown:Boolean;
		private var speed:int = 5;
		private var arrayOfWalls:Array;
		private var background:BackgroundAssetLabirinty;
		private var canMove:Boolean = true;;
		private var finishScreen:LabirintyFinishScreenAsset;
		private var onQuitFunction:Function;
		private var _stage:Stage;
		private var bubbleAsset:BubbleAsset;
		private var arrayOfBubbles:Array;
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var timer:LabirintyTimerAsset;
		private var timeBetweenBubbles:int = 62;
		private var bubbleSpeed:int = 2;
		private var initTutorial:TutorialAsset;
		private var _isMuted:Boolean;
		
		public function Labirinty(aStage:Stage = null, isMuted:Boolean = false)
		{
			_isMuted = isMuted;
			SoundManagerLabirinty.setIsMuted(isMuted);
			if(aStage){
				_stage = aStage;
			}else{
				_stage = stage;
			}
			initGame();
		}
		
		private function initGame():void
		{
			SoundManagerLabirinty.getInstance();
			SoundManagerLabirinty.playByName(SoundManagerLabirinty.BACKGROUND);
			arrayOfLabirinties = new Array();
			arrayOfBubbles = new Array();
			arrayOfWalls = new Array();
			background = new BackgroundAssetLabirinty();
			this.addChild(background);
			fillArrayOfLabirinties();
			showTimer();
			createLabirinty();
			createHero();
			
			addInitTutorial();
			
			
		}
		
		private function addInitTutorial():void
		{
			initTutorial = new TutorialAsset();
			initTutorial.x = background.width/2;
			initTutorial.y = background.height/2;
			this.addChild(initTutorial);
			initTutorial.scaleX = initTutorial.scaleY = 0;
			TweenLite.to(initTutorial, .5, {scaleX:1, scaleY:1});
			TweenLite.to(initTutorial, .5, {scaleX:0, scaleY:0, delay:8, onComplete:completeHideInitTutorial});
		}
		
		private function completeHideInitTutorial():void
		{
			if(initTutorial){
				if(this.contains(initTutorial)){
					this.removeChild(initTutorial);
					initTutorial = null;
				}
			}
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function fillArrayOfLabirinties():void
		{
			arrayOfLabirinties.push(new Labirinty1Asset());
			//arrayOfLabirinties.push(new Labirinty2Asset());
		}
		
		private function createLabirinty():void
		{
			var randomLabirinty:int = Math.floor(Math.random() * arrayOfLabirinties.length);
			activeLabirinty = arrayOfLabirinties[randomLabirinty];
			this.addChild(activeLabirinty);
			activeLabirinty.x = 5;
			activeLabirinty.y = timer.y + timer.height + 10;
			for (var i:int = 0; i < activeLabirinty.numChildren; i++) 
			{
				if(activeLabirinty.getChildAt(i) is StartPointAsset){
					startPoint = activeLabirinty.getChildAt(i) as StartPointAsset;
					startPoint.visible = false;
				}
				if(activeLabirinty.getChildAt(i) is EndPointAsset){
					endPoint = activeLabirinty.getChildAt(i) as EndPointAsset;
				}
				if(activeLabirinty.getChildAt(i) is WallBlockAsset){
					arrayOfWalls.push(activeLabirinty.getChildAt(i));
					activeLabirinty.getChildAt(i).alpha = 0;
				}
			}
		}
		
		private function createHero():void
		{
			if(!hero){
				hero = new HeroAsset();
				this.activeLabirinty.addChild(hero);
				hero.x = startPoint.x;
				hero.y = startPoint.y;
				hero.downHit.visible = false;
				hero.topHit.visible = false;
				hero.leftHit.visible = false;
				hero.rightHit.visible = false;
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				canMove = true;
			}
		}
		
		private function createBubble():void
		{
			bubbleAsset = new BubbleAsset();
			bubbleAsset.x = Math.random() * (background.width-bubbleAsset.width) + bubbleAsset.width/2;
			bubbleAsset.y = background.height + bubbleAsset.height;
			var bubbleSize:int = Math.floor(Math.random()*10);
			bubbleAsset.scaleX = bubbleAsset.scaleY = bubbleSize/10;
			this.addChild(bubbleAsset);
			arrayOfBubbles.push(bubbleAsset);
		}
		
		private function moveBubbles():void
		{
			for (var i:int = 0; i < arrayOfBubbles.length; i++) 
			{
				arrayOfBubbles[i].y -= bubbleSpeed;
				if(arrayOfBubbles[i].y <= (-arrayOfBubbles[i].height)){
					this.removeChild(arrayOfBubbles[i]);
					arrayOfBubbles.splice(i, 1);
				}
			}
		}
		
		private function destroyBalloon(balloon:MovieClip):void
		{
			TweenLite.to(balloon, .2, {scaleX:1.2, scaleY:1.2});
			TweenLite.to(balloon, .5, {scaleX:0, scaleY:0, alpha:0, delay:.5, onComplete:completeDestroyBubble, onCompleteParams:[balloon]});
		}
		
		private function completeDestroyBubble(balloon:MovieClip):void
		{
			this.removeChild(balloon);
			balloon = null;
		}
		
		private function showTimer():void
		{
			if(!timer){
				timer = new LabirintyTimerAsset();
				timer.x = background.width - (timer.width+10);
				timer.y = 10;
				this.addChild(timer);
				timer.visible = true;
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.LEFT){
				isLeft = true;
				hero.image.rotation = 0;
				hero.image.scaleX = -1;
			}
			if(event.keyCode == Keyboard.RIGHT){
				isRight = true;
				hero.image.rotation = 0;
				hero.image.scaleX = 1;
			}
			if(event.keyCode == Keyboard.UP){
				isUp = true;
				//hero.image.rotation = -90;
				//hero.image.scaleX = 1;
			}
			if(event.keyCode == Keyboard.DOWN){
				isDown = true;
				//hero.image.rotation = 90;
				//hero.image.scaleX = 1;
			}
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.LEFT){
				isLeft = false;
			}
			if(event.keyCode == Keyboard.RIGHT){
				isRight = false;
			}
			if(event.keyCode == Keyboard.UP){
				isUp = false;
			}
			if(event.keyCode == Keyboard.DOWN){
				isDown = false;
			}
		}
		
		private function update(event:Event):void
		{
			moveHero();
			verifyCollision();
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
				if(minutes < 10){
					var minutesStr:String = "0"+String(minutes);
				}else{
					var minutesStr:String = String(minutes);
				}
				if(seconds < 10){
					var secondsStr:String = "0"+String(seconds);
				}else{
					var secondsStr:String = String(seconds);
				}
				timer.minutes.text = String(minutesStr);
				timer.seconds.text = String(secondsStr);
			}
			if(((ticks + seconds*24) % timeBetweenBubbles) == 0){
				createBubble();
			}
			moveBubbles();
		}
		
		private function moveHero():void
		{
			if(canMove){
				if(isDown){
					hero.y += speed;
				}
				if(isUp){
					hero.y -= speed;
				}
				if(isLeft){
					hero.x -= speed;
				}
				if(isRight){
					hero.x += speed;
				}
			}
		}
		
		private function verifyCollision():void
		{
			for (var i:int = 0; i < arrayOfWalls.length; i++) 
			{
				if(hero.leftHit.hitTestObject(arrayOfWalls[i])){
					canMove = false;
					hero.x += speed;
				}
				if(hero.rightHit.hitTestObject(arrayOfWalls[i])){
					canMove = false;
					hero.x -= speed;
				}
				if(hero.topHit.hitTestObject(arrayOfWalls[i])){
					canMove = false;
					hero.y += speed;
				}
				if(hero.downHit.hitTestObject(arrayOfWalls[i])){
					canMove = false;
					hero.y -= speed;
				}
				canMove = true;
			}
			if(hero.hitTestObject(endPoint)){
				endGame();
			}
		}
		
		private function endGame():void
		{
			canMove = false;
			this.removeEventListener(Event.ENTER_FRAME, update);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			finishScreen = new LabirintyFinishScreenAsset();
			finishScreen.btnGames.addEventListener(MouseEvent.CLICK, onClickGames);
			finishScreen.btnGames.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver2);
			finishScreen.btnGames.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut2);
			finishScreen.btnGames.buttonMode = true;
			finishScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickExit);
			finishScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver2);
			finishScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut2);
			finishScreen.btnBack.buttonMode = true;
			this.addChild(finishScreen);
		}
		
		protected function onMouseOut2(event:MouseEvent):void
		{var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 0; 
			glow.blurY = 0; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			Sprite(event.currentTarget).filters = [glow];
			//event.currentTarget.scaleX = event.currentTarget.scaleY -= .1; 
		}
		
		protected function onMouseOver2(event:MouseEvent):void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0xffffff; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			Sprite(event.currentTarget).filters = [glow];
			//event.currentTarget.scaleX = event.currentTarget.scaleY += .1; 
		}
		
		protected function onClickGames(event:MouseEvent):void
		{
			destroy(true);
		}
		
		protected function onClickExit(event:MouseEvent):void
		{
			destroy();
		}
		
		protected function onClickTryAgain(event:MouseEvent):void
		{
			if(finishScreen){
				if(this.contains(finishScreen)){
					this.removeChild(finishScreen);
					finishScreen = null;
				}
			}
			destroyObjects();
			initGame();
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 0; 
			glow.blurY = 0; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			Sprite(event.currentTarget).filters = [glow];
			//event.currentTarget.scaleX = event.currentTarget.scaleY -= .1; 
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0xffffff; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			Sprite(event.currentTarget).filters = [glow];
			//event.currentTarget.scaleX = event.currentTarget.scaleY += .1; 
		}
		
		public function setOnQuitFunction(value:Function):void
		{
			onQuitFunction = value;
		}
		
		private function destroyObjects():void
		{
			arrayOfLabirinties = null;
			arrayOfWalls = null;
			canMove = false;
			isDown = false;
			isLeft = false;
			isRight = false;
			isUp = false;
			destroyHero();
			startPoint = null;
			endPoint = null;
			activeLabirinty = null;
			while(this.numChildren > 0){
				this.removeChild(this.getChildAt(0));
			}
		}
		
		private function destroy(goToGames:Boolean = false):void
		{
			SoundManagerLabirinty.stopAll();
			this.removeEventListener(Event.ENTER_FRAME, update);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			destroyObjects();
			
			onQuitFunction(goToGames);
		}
		
		private function destroyHero():void
		{
			if(hero){
				if(this.activeLabirinty.contains(hero)){
					this.activeLabirinty.removeChild(hero);
					hero = null;
				}
			}
		}
	}
}