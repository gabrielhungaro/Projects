package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
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
		private var background:BackgroundAsset;
		private var canMove:Boolean = true;;
		private var finishScreen:LabirintyFinishScreenAsset;
		private var onQuitFunction:Function;
		private var _stage:Stage;
		
		public function Labirinty(aStage:Stage = null)
		{
			if(aStage){
				_stage = aStage;
			}else{
				_stage = stage;
			}
			initGame();
		}
		
		private function initGame():void
		{
			arrayOfLabirinties = new Array();
			arrayOfWalls = new Array();
			background = new BackgroundAsset();
			this.addChild(background);
			fillArrayOfLabirinties();
			createLabirinty();
			createHero();
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
			activeLabirinty.y = 10;
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
				hero.image.rotation = -90;
				hero.image.scaleX = 1;
			}
			if(event.keyCode == Keyboard.DOWN){
				isDown = true;
				hero.image.rotation = 90;
				hero.image.scaleX = 1;
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
			finishScreen.addEventListener(MouseEvent.CLICK, onClickExit);
			this.addChild(finishScreen);
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
		
		protected function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY += .1; 
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY -= .1; 
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
		
		private function destroy():void
		{
			this.removeEventListener(Event.ENTER_FRAME, update);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			destroyObjects();
			
			onQuitFunction();
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