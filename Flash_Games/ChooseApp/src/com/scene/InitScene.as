package com.scene
{
	import com.elements.Button;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class InitScene extends Scene
	{
		private var startButton:Button;
		private var initSceneAsset:InitSceneAsset;
		private var titleApp:String;
		private var titleTextField:TextField;
		
		public function InitScene()
		{
			super();
		}
		
		override public function init():void
		{
			this.name = ScenesName.INIT_SCENE;
			addArt();
		}
		
		private function addArt():void
		{
			backgroundContainer = new Sprite();
			this.addChild(backgroundContainer);
			
			startButton = new Button();
			startButton.setButtonName("StartButton");
			startButton.setUrlButton(dataInfo.getUrlStartButton());
			startButton.setUrlButtonOver(dataInfo.getUrlStartButtonOver());
			this.addChild(startButton);
			startButton.buttonMode = true;
			startButton.onClick.add(onClickStart);
			startButton.init();
			startButton.load();
			startButton.x = dataInfo.getAppWidth()/2 - startButton.width/2;
			startButton.y = dataInfo.getAppHeight()/2;
			
			load();
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
		
		protected function onClickStart():void
		{
			this.gotoScene(ScenesName.CHOOSE_SCENE);
		}
		
		override public function destroy():void
		{
			if(startButton){
				this.removeChild(startButton);
				startButton.destroy();
				startButton = null;
			}
			while(this.numChildren > 0){
				this.removeChild(this.getChildAt(0));
			}
		}
	}
}