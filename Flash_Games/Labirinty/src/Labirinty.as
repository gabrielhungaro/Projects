package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	[SWF(width="800",height="600")]
	public class Labirinty extends Sprite
	{
		
		private var arrayOfLabirinties:Array = new Array();
		private var hero:HeroAsset;
		private var startPoint:MovieClip;
		private var endPoint:MovieClip;
		private var activeLabirinty:MovieClip;
		private var isLeft:Boolean;
		private var isRight:Boolean;
		private var isUp:Boolean;
		private var isDown:Boolean;
		private var speed:int = 5;
		private var arrayOfWalls:Array = new Array();
		private var background:BackgroundAsset;
		
		public function Labirinty()
		{
			initGame();
		}
		
		private function initGame():void
		{
			background = new BackgroundAsset();
			this.addChild(background);
			fillArrayOfLabirinties();
		}
		
		private function fillArrayOfLabirinties():void
		{
			arrayOfLabirinties.push(new Labirinty1Asset());
			createLabirinty();
			createHero();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function createLabirinty():void
		{
			var randomLabirinty:int = Math.floor(Math.random() * arrayOfLabirinties.length);
			activeLabirinty = arrayOfLabirinties[randomLabirinty];
			this.addChild(activeLabirinty);
			for (var i:int = 0; i < activeLabirinty.numChildren; i++) 
			{
				if(activeLabirinty.getChildAt(i) is StartPointAsset){
					startPoint = activeLabirinty.getChildAt(i) as StartPointAsset;
				}
				if(activeLabirinty.getChildAt(i) is EndPointAsset){
					endPoint = activeLabirinty.getChildAt(i) as EndPointAsset;
				}
				if(activeLabirinty.getChildAt(i) is WallBlockAsset){
					arrayOfWalls.push(activeLabirinty.getChildAt(i));
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
				addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				//addEventListener(MouseEvent.CLICK, onClick);
				activeLabirinty.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			isDown = true;
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.LEFT){
				isLeft = true;
			}
			if(event.keyCode == Keyboard.RIGHT){
				isRight = true;
			}
			if(event.keyCode == Keyboard.UP){
				isUp = true;
			}
			if(event.keyCode == Keyboard.DOWN){
				isDown = true;
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
			virifyCollision();
		}
		
		private function moveHero():void
		{
			if(isDown){
				hero.y += speed;
			}
			if(isUp){
				hero.y -= speed;
			}
			if(isLeft){
				hero.x += speed;
			}
			if(isRight){
				hero.x -= speed;
			}
		}
		
		private function virifyCollision():void
		{
			for (var i:int = 0; i < arrayOfWalls.length; i++) 
			{
				if(hero.hitTestObject(arrayOfWalls[i])){
					trace("hitei");
				}
			}
		}
	}
}