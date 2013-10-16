package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="800", height="600")]
	public class English extends Sprite
	{
		private var dog:DogAsset;
		private var cat:CatAsset;
		private var horse:HorseAsset;
		private var shark:SharkAsset;
		private var fish:FishAsset;
		private var rat:RatAsset;
		private var sheep:SheepAsset;
		private var wolf:WolfAsset;
		private var whale:WhaleAsset;
		private var turtle:TurtleAsset;
		private var animalName:AnimalNameAsset;
		private var arrayOfNamesOriginal:Array = ["dog", "cat", "horse", "rat", "fish", "shark", "sheep", "turtle", "wolf", "whale"];
		private var arrayOfRandonNames:Array;
		private var arrayOfImagesClass:Vector.<Class>;
		private var arrayOfImages:Array;
		private var numberOfNames:int; 
		private var arrayOfRandonImages:Array;
		private var connectionLine:Sprite;
		private var imageChoose:MovieClip;
		private var animalChoose:MovieClip;
		private var isWithAnmalChoosed:Boolean = false;
		private var drawConnection:Boolean;
		private var wrongs:int;
		private var corrects:int;
		private var rounds:int;
		private var score:ScoreAsset;
		private var finishScreen:FinishScreenAsset;
		public function English()
		{
			init();
		}
		
		private function init():void
		{
			rounds = 0;
			corrects = 0;
			wrongs = 0;
			resetArrayOfNamesOriginal();
			arrayOfImages = new Array();
			arrayOfImagesClass = new Vector.<Class>();
			arrayOfImagesClass.push(DogAsset, CatAsset, HorseAsset, SharkAsset, FishAsset, RatAsset, SheepAsset, WolfAsset, WhaleAsset, TurtleAsset);
			
			arrayOfRandonNames = new Array();
			arrayOfRandonImages = new Array();
			numberOfNames = arrayOfNamesOriginal.length;
			
			fillArrayOfAnimalsImage();
			resetArrayOfNamesOriginal();
			fillArrayOfNames();
			addScore();
			
			for (var i:int = 0; i < arrayOfRandonNames.length; i++) 
			{
				arrayOfImages.push(new arrayOfImagesClass[i]());
				this.addChild(arrayOfImages[i]);
				arrayOfImages[i].x = 20;
				arrayOfImages[i].y = 5 * (i+1) + arrayOfImages[i].height * i;
				arrayOfImages[i].name = arrayOfImages[i].aninalName.text;
				arrayOfImages[i].addEventListener(MouseEvent.CLICK, onClickImage);
				arrayOfImages[i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				arrayOfImages[i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				
				animalName = new AnimalNameAsset();
				animalName.x = stage.stageWidth - (animalName.width+20);
				animalName.y = 5 * (i+1) + animalName.height * i;
				animalName.animalName.text = arrayOfRandonNames[i];
				animalName.name = arrayOfRandonNames[i];
				this.addChild(animalName);
				animalName.addEventListener(MouseEvent.CLICK, onClickName);
				animalName.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				animalName.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function addScore():void
		{
			score = new ScoreAsset();
			score.x = stage.stageWidth/2 - score.width/2;
			score.y = 15;
			this.addChild(score);
			updateScore();
		}
		
		private function updateScore():void
		{
			score.corrects.text = String(corrects);
			score.wrongs.text = String(wrongs);
		}
		
		protected function update(event:Event):void
		{
			if(connectionLine && drawConnection){
				connectionLine.graphics.lineTo(mouseX, mouseY);
			}
		}
		
		protected function onClickImage(event:MouseEvent):void
		{
			imageChoose = event.currentTarget as MovieClip;
			if(!isWithAnmalChoosed){
				drawConnection = true;
				connectionLine = new Sprite();
				connectionLine.mouseEnabled = false;
				connectionLine.mouseChildren = false;
				connectionLine.graphics.lineStyle(2, 0x990000, .75);
				connectionLine.graphics.moveTo(event.currentTarget.x, event.currentTarget.y); 
				connectionLine.graphics.lineTo(mouseX, mouseY);
				this.addChild(connectionLine);
				isWithAnmalChoosed = true;
			}else{
				drawConnection = false;
				verifyChoosedAnimals();
			}
		}
		
		protected function onClickName(event:MouseEvent):void
		{
			animalChoose = event.currentTarget as MovieClip;
			if(!isWithAnmalChoosed){
				connectionLine = new Sprite();
				connectionLine.mouseEnabled = false;
				connectionLine.mouseChildren = false;
				connectionLine.graphics.lineStyle(2, 0x990000, .75);
				connectionLine.graphics.moveTo(event.currentTarget.x, event.currentTarget.y); 
				connectionLine.graphics.lineTo(mouseX, mouseY);
				this.addChild(connectionLine);
				isWithAnmalChoosed = true;
			}else{
				drawConnection = false;
				verifyChoosedAnimals();
			}
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY += .1; 
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY -= .1; 
		}
		
		private function verifyChoosedAnimals():void
		{
			rounds++;
			isWithAnmalChoosed = false;
			if(animalChoose.name == imageChoose.name){
				animalChoose.alpha = .5;
				animalChoose.removeEventListener(MouseEvent.CLICK, onClickName);
				animalChoose.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				animalChoose.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				imageChoose.alpha = .5;
				imageChoose.removeEventListener(MouseEvent.CLICK, onClickImage);
				imageChoose.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				imageChoose.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				corrects++;
			}else{
				wrongs++;
			}
			updateScore();
			removeConnectionLine();
			if(rounds >= numberOfNames){
				addFinishScreen();
			}
		}
		
		private function addFinishScreen():void
		{
			finishScreen = new FinishScreenAsset();
			finishScreen.corrects.text = String(corrects);
			finishScreen.wrongs.text = String(wrongs);
			finishScreen.btnTryAgain.addEventListener(MouseEvent.CLICK, onClickTryAgain);
			finishScreen.btnTryAgain.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			finishScreen.btnTryAgain.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addChild(finishScreen);
		}
		
		protected function onClickTryAgain(event:MouseEvent):void
		{
			if(finishScreen){
				if(this.contains(finishScreen)){
					this.removeChild(finishScreen);
				}
			}
			while(this.numChildren > 0){
				this.removeChild(this.getChildAt(0));
			}
			init();
		}
		
		private function removeConnectionLine():void
		{
			if(connectionLine){
				if(this.contains(connectionLine)){
					this.removeChild(connectionLine);
					connectionLine = null;
				}
			}
		}
		
		private function resetArrayOfNamesOriginal():void
		{
			arrayOfNamesOriginal = ["dog", "cat", "horse", "rat", "fish", "shark", "sheep", "turtle", "wolf", "whale"];
		}
		
		private function fillArrayOfNames():void
		{
			for (var i:int = 0; i < numberOfNames; i++) 
			{
				randomizeName();
			}
		}
		
		private function randomizeName():void
		{
			var randomName:int = Math.floor(Math.random() * arrayOfNamesOriginal.length);
			verifyRandomName(arrayOfNamesOriginal[randomName], randomName);
		}
		
		private function verifyRandomName(randomName:String, indexNumber:int):void
		{
			for (var i:int = 0; i < arrayOfRandonNames.length; i++) 
			{
				if(arrayOfRandonNames[i] == randomName){
					randomizeName();
				}
			}
			arrayOfNamesOriginal.splice(indexNumber, 1);
			arrayOfRandonNames.push(randomName);
			return;
		}
		
		private function fillArrayOfAnimalsImage():void
		{
			for (var i:int = 0; i < numberOfNames; i++) 
			{
				randomizeImage();
			}
		}
		
		private function randomizeImage():void
		{
			var randomImage:int = Math.floor(Math.random() * arrayOfNamesOriginal.length);
			verifyRandomImage(arrayOfNamesOriginal[randomImage], randomImage);
		}
		
		private function verifyRandomImage(randomName:String, indexNumber:int):void
		{
			for (var i:int = 0; i < arrayOfRandonImages.length; i++) 
			{
				if(arrayOfRandonImages[i] == randomName){
					randomizeImage();
				}
			}
			arrayOfNamesOriginal.splice(indexNumber, 1);
			arrayOfRandonImages.push(randomName);
			return;
		}
	}
}