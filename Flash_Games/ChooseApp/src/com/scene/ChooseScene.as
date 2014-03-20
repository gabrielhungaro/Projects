package com.scene
{
	import com.elements.ObjectToChoose;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Sprite;
	
	
	public class ChooseScene extends Scene
	{
		private var objectToChoose:ObjectToChoose;
		private var offSetX:int = 10;
		private var offSetY:int = 10;
		
		public function ChooseScene()
		{
			super();
		}
		
		override public function init():void
		{
			this.name = ScenesName.CHOOSE_SCENE;
			addArt();
		}
		
		private function addArt():void
		{
			backgroundContainer = new Sprite();
			this.addChild(backgroundContainer);
			
			/*objectToChoose = new ObjectToChoose();
			startButton.setButtonName("StartButton");
			startButton.setUrlButton(quizData.getUrlStartButton());
			startButton.setUrlButtonOver(quizData.getUrlStartButtonOver());
			this.addChild(startButton);
			startButton.buttonMode = true;
			startButton.onClick.add(onClickStart);
			startButton.init();
			startButton.load();
			startButton.x = quizData.getAppWidth()/2 - startButton.width/2;
			startButton.y = quizData.getAppHeight()/2;*/
			
			load();
			
			randomPerson();
		}
		
		private function load():void
		{
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("sceneImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(dataInfo.getUrlStartScreen(), {name:"startScreenImage", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:backgroundContainer}));
			loader.load();
		}
		
		private function randomPerson():void
		{
			var arrayOfObjects:Vector.<ObjectToChoose> = new Vector.<ObjectToChoose>();
			arrayOfObjects = dataInfo.getArrayOfObjectsToChoose().concat();
			
			var randomPersonalityNum1:int = Math.floor(Math.random() * arrayOfObjects.length);
			this.addChild(arrayOfObjects[randomPersonalityNum1]);
			arrayOfObjects[randomPersonalityNum1].onClick.add(onClickPersonality);
			arrayOfObjects[randomPersonalityNum1].x = dataInfo.getAppWidth()/2 - (arrayOfObjects[randomPersonalityNum1].getWidth() + offSetX);
			arrayOfObjects[randomPersonalityNum1].y = arrayOfObjects[randomPersonalityNum1].getHeight()/1.5;
			arrayOfObjects.splice(randomPersonalityNum1, 1);
			
			var randomPersonalityNum2:int = Math.floor(Math.random() * arrayOfObjects.length);
			this.addChild(arrayOfObjects[randomPersonalityNum2]);
			arrayOfObjects[randomPersonalityNum2].onClick.add(onClickPersonality);
			arrayOfObjects[randomPersonalityNum2].x = dataInfo.getAppWidth()/2 + offSetX;
			arrayOfObjects[randomPersonalityNum2].y = arrayOfObjects[randomPersonalityNum2].getHeight()/1.5;
			arrayOfObjects.splice(randomPersonalityNum2, 1);
			
			

		}
		
		private function onClickPersonality():void
		{
			
		}
		
		private function completeLoadImageHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			// TODO Auto Generated method stub
			
		}
	}
}