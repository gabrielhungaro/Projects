package
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	[SWF(width="800", height="600")]
	public class English extends Sprite
	{
		private var dog:DogAsset;
		private var bird:BirdAsset;
		private var horse:HorseAsset;
		private var chicken:ChickenAsset;
		private var pig:PigAsset;
		private var sheep:SheepAsset;
		private var cow:CowAsset;
		private var animalName:AnimalNameAsset;
		private var arrayOfConstNames:Array = ["dog", "bird", "horse", "cow", "pig", "sheep", "chicken"];
		private var arrayOfNamesOriginal:Array;
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
		private var score:ScoreAssetEnglish;
		private var finishScreen:EnglishFinishScreenAsset;
		private var background:EnglishBackgroundAsset;
		private var onQuitFunction:Function;
		private var animalSound:EnglishBtnSound;
		private var gameOverScreen:EnglishGameOverScreen;
		private var initTutorial:InitTutorialAssetEnglish;
		private var _isMuted:Boolean;
		public function English(isMuted:Boolean = false)
		{
			_isMuted = isMuted;
			SoundManagerEnglish.setIsMuted(isMuted);
			init();
		}
		
		private function init():void
		{
			SoundManagerEnglish.getInstance();
			background = new EnglishBackgroundAsset();
			this.addChild(background);
			rounds = 0;
			corrects = 0;
			wrongs = 0;
			resetArrayOfNamesOriginal();
			arrayOfImages = new Array();
			arrayOfImagesClass = new Vector.<Class>();
			arrayOfImagesClass.push(DogAsset, PigAsset, HorseAsset, CowAsset, ChickenAsset, BirdAsset, SheepAsset);
			
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
				arrayOfImages[i].x = 10 + arrayOfImages[i].width/2;
				//arrayOfImages[i].y = arrayOfImages[i].height/2 * (i+1) + arrayOfImages[i].height * i + arrayOfImages[i].height/2;
				if(i > 0){
					arrayOfImages[i].y = /*arrayOfImages[i-1].height/2 + */arrayOfImages[i-1].y + arrayOfImages[i-1].height;
				}else{
					arrayOfImages[i].y = arrayOfImages[i].height/2 + 10;
				}
				arrayOfImages[i].name = arrayOfImages[i].aninalName.text;
				arrayOfImages[i].aninalName.visible = false;
				arrayOfImages[i].addEventListener(MouseEvent.CLICK, onClickImage);
				arrayOfImages[i].addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				arrayOfImages[i].addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				
				animalName = new AnimalNameAsset();
				animalName.scaleX = animalName.scaleY = .5;
				animalName.x = background.width - (animalName.width/2 + 50);
				animalName.y = animalName.height/2 * (i+1) + animalName.height * i + animalName.height/2;
				animalName.animalName.text = arrayOfRandonNames[i];
				animalName.name = arrayOfRandonNames[i];
				this.addChild(animalName);
				animalName.addEventListener(MouseEvent.CLICK, onClickName);
				/*animalName.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				animalName.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);*/
				
				animalSound = new EnglishBtnSound();
				animalSound.name = animalName.name;
				animalSound.scaleX = animalSound.scaleY = .5;
				animalSound.x = animalName.x + animalName.width/2 + (animalSound.width/2+10);
				animalSound.y = animalName.y
				this.addChild(animalSound);
				animalSound.addEventListener(MouseEvent.CLICK, onClickSound);
				animalSound.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				animalSound.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
			
			addInitTutorial();
		}
		
		private function addInitTutorial():void
		{
			initTutorial = new InitTutorialAssetEnglish();
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
		
		protected function onClickSound(event:MouseEvent):void
		{
			SoundManagerEnglish.playByName(event.currentTarget.name);
		}
		
		private function addScore():void
		{
			score = new ScoreAssetEnglish();
			score.x = background.width/2;
			score.y = background.height - score.height+10;
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
				connectionLine.graphics.clear();
				connectionLine.graphics.lineStyle(2, 0x990000, .75);
				connectionLine.graphics.moveTo(imageChoose.x, imageChoose.y); 
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
			/*if(!isWithAnmalChoosed){
				connectionLine = new Sprite();
				connectionLine.mouseEnabled = false;
				connectionLine.mouseChildren = false;
				connectionLine.graphics.lineStyle(2, 0x990000, .75);
				connectionLine.graphics.moveTo(event.currentTarget.x, event.currentTarget.y); 
				connectionLine.graphics.lineTo(mouseX, mouseY);
				this.addChild(connectionLine);
				isWithAnmalChoosed = true;
			}else{*/
				drawConnection = false;
				verifyChoosedAnimals();
			//}
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
			if(isWithAnmalChoosed){
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
					SoundManagerEnglish.playByName(SoundManagerEnglish.CORRECT);
				}else{
					wrongs++;
					SoundManagerEnglish.playByName(SoundManagerEnglish.WRONG);
				}
				updateScore();
				removeConnectionLine();
				if(wrongs >= 5 || corrects >= numberOfNames){
					addFinishScreen();
				}
			}
		}
		
		private function addFinishScreen():void
		{
			if(corrects > wrongs){
				finishScreen = new EnglishFinishScreenAsset();
				finishScreen.btnGames.addEventListener(MouseEvent.CLICK, onClickGames);
				finishScreen.btnGames.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver2);
				finishScreen.btnGames.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut2);
				finishScreen.btnGames.buttonMode = true;
				finishScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickExit);
				finishScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver2);
				finishScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut2);
				finishScreen.btnBack.buttonMode = true;
				this.addChild(finishScreen);
			}else{
				gameOverScreen = new EnglishGameOverScreen();
				gameOverScreen.btnExit.addEventListener(MouseEvent.CLICK, onClickExit);
				gameOverScreen.btnExit.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver2);
				gameOverScreen.btnExit.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut2);
				gameOverScreen.btnExit.buttonMode = true;
				gameOverScreen.btnExit.buttonMode = true;
				gameOverScreen.btnTryAgain.addEventListener(MouseEvent.CLICK, onClickTryAgain);
				gameOverScreen.btnTryAgain.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver2);
				gameOverScreen.btnTryAgain.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut2);
				gameOverScreen.btnTryAgain.buttonMode = true;
				this.addChild(gameOverScreen);
			}
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
			if(gameOverScreen){
				if(this.contains(gameOverScreen)){
					this.removeChild(gameOverScreen);
					gameOverScreen = null;
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
			arrayOfNamesOriginal = arrayOfConstNames.concat();
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
		
		public function setOnQuitFunction(value:Function):void
		{
			onQuitFunction = value;
		}
		
		public function destroy(goToGames:Boolean = false):void
		{
			while(this.numChildren > 0){
				this.removeChild(this.getChildAt(0));
			}
			onQuitFunction(goToGames);
		}
	}
}