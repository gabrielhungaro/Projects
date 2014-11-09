package com.scene
{
	import com.elements.ObjectToChoose;
	import com.elements.ThumbRanking;
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
		private var arrayOfPersonality:Array;
		private var arrayOfRankingPersonalities:Array;
		private var _rankingContainer:Sprite;
		private var _containerPersonalities:Sprite;
		private var _vsContainer:Sprite;
		
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
			arrayOfPersonality = [];
			arrayOfRankingPersonalities = [];
			_containerPersonalities = new Sprite();
			this.addChild(_containerPersonalities);
			_vsContainer = new Sprite();
			_vsContainer.graphics.beginFill(0x000000, 1);
			_vsContainer.graphics.drawRect(0, 0, 50, 50);
			_vsContainer.graphics.endFill();
			this.addChild(_vsContainer);
			randomPerson();
			mountRanking();
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
			loader.append( new ImageLoader(dataInfo.getUrlVs(), {name:"vsImage", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:_vsContainer}));
			loader.load();
		}
		
		private function mountRanking():void
		{
			_rankingContainer = new Sprite();
			_rankingContainer.graphics.beginFill(0x000000, 0);
			_rankingContainer.graphics.drawRect(0, 0, dataInfo.getAppWidth(), dataInfo.getAppHeight()/4 + dataInfo.getAppHeight()/32*2);
			_rankingContainer.graphics.endFill();
			_rankingContainer.y = dataInfo.getAppHeight()/2 + (dataInfo.getAppHeight()/32)*3 + 1;
			this.addChild(_rankingContainer);
			
			updateRanking();
		}
		
		private function updateRanking():void
		{
			clearRanking();
			var arrayOfRankingObjs:Vector.<ObjectToChoose> = dataInfo.getRankingTopByCount(3);
			//var arrayOfRankingObjs:Vector.<ObjectToChoose> = dataInfo.getRankingObjects();
			for (var i:int = 0; i < arrayOfRankingObjs.length; i++) 
			{
				var thumb:ThumbRanking = new ThumbRanking();
				thumb.setPosition(i+1);
				thumb.setPhoto(arrayOfRankingObjs[i]);
				thumb.updateInfo();
				_rankingContainer.addChild(thumb);
				thumb.x = (offSetX*2)*(i+1) + thumb.getThumbWidth()*i;
				thumb.y = thumb.getThumbHeight()/2;
				arrayOfRankingPersonalities.push(thumb);
			}
		}
		
		private function clearRanking():void
		{
			for (var i:int = 0; i < arrayOfRankingPersonalities.length; i++) 
			{
				if(_rankingContainer.contains(arrayOfRankingPersonalities[i])){
					_rankingContainer.removeChild(arrayOfRankingPersonalities[i]);
				}
			}
			arrayOfRankingPersonalities = [];
		}
		
		private function randomPerson():void
		{
			var arrayOfObjects:Vector.<ObjectToChoose> = new Vector.<ObjectToChoose>();
			arrayOfObjects = dataInfo.getArrayOfObjectsToChoose().concat();
			
			var randomPersonalityNum1:int = Math.floor(Math.random() * arrayOfObjects.length);
			_containerPersonalities.addChild(arrayOfObjects[randomPersonalityNum1]);
			arrayOfObjects[randomPersonalityNum1].onClick.add(onClickPersonality);
			arrayOfObjects[randomPersonalityNum1].x = dataInfo.getAppWidth()/2 - (arrayOfObjects[randomPersonalityNum1].getWidth() + offSetX);
			arrayOfObjects[randomPersonalityNum1].y = arrayOfObjects[randomPersonalityNum1].getHeight()/1.5;
			arrayOfObjects[randomPersonalityNum1].addNumberToAppear();
			//adicionar numero de vezes que apareceu
			arrayOfPersonality.push(arrayOfObjects[randomPersonalityNum1]);
			arrayOfObjects.splice(randomPersonalityNum1, 1);
			
			var randomPersonalityNum2:int = Math.floor(Math.random() * arrayOfObjects.length);
			_containerPersonalities.addChild(arrayOfObjects[randomPersonalityNum2]);
			arrayOfObjects[randomPersonalityNum2].onClick.add(onClickPersonality);
			arrayOfObjects[randomPersonalityNum2].x = dataInfo.getAppWidth()/2 + offSetX;
			arrayOfObjects[randomPersonalityNum2].y = arrayOfObjects[randomPersonalityNum2].getHeight()/1.5;
			arrayOfObjects[randomPersonalityNum2].addNumberToAppear();
			arrayOfPersonality.push(arrayOfObjects[randomPersonalityNum2]);
			arrayOfObjects.splice(randomPersonalityNum2, 1);
			
			_vsContainer.x = dataInfo.getVsXPos();
			_vsContainer.y = dataInfo.getVsYPos();
		}
		
		private function onClickPersonality(personClicked:ObjectToChoose):void
		{
			personClicked.addVote();
			clearPersonContainers();
			randomPerson();
			updateRanking();
		}
		
		private function clearPersonContainers():void
		{
			for (var i:int = 0; i < arrayOfPersonality.length; i++) 
			{
				if(_containerPersonalities.contains(arrayOfPersonality[i])){
					_containerPersonalities.removeChild(arrayOfPersonality[i]);
				}
			}
			arrayOfPersonality = [];
		}
		
		private function completeLoadImageHandler(event:LoaderEvent):void
		{
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