package com.elements
{
	import com.data.Debug;
	import com.globo.sitio.engine.debug.Debug;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.data.LoaderMaxVars;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class Button extends Sprite
	{
		private var urlButton:String;
		private var urlButtonOver:String;
		private var buttonName:String;
		private var buttonImg:Sprite;
		private var buttonImgOver:Sprite;
		private var OVER:String = "over";
		private var OUT:String = "out";
		public var onClick:Signal = new Signal();
		private var overImgEnabled:Boolean;
		
		public function Button()
		{
		}
		
		public function init():void
		{
			var placeHolder:Sprite = new Sprite();
			placeHolder.graphics.beginFill(0x303030, 1);
			placeHolder.graphics.drawRect(0, 0, 20, 10);
			placeHolder.graphics.endFill();
			placeHolder.mouseChildren = false;
			placeHolder.mouseEnabled = false;
			this.addChild(placeHolder);
			this.addEventListener(MouseEvent.CLICK, onClickButton);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			buttonImgOver = new Sprite();
			this.addChild(buttonImgOver);
			buttonImg = new Sprite();
			this.addChild(buttonImg);
		}
		
		protected function onClickButton(event:MouseEvent):void
		{
			onClick.dispatch();
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			changeButtonState(OUT);
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			changeButtonState(OVER);
		}
		
		public function load():void
		{
			var settings:LoaderMaxVars = new LoaderMaxVars();
			settings.onComplete(this.completeLoadAllImagesHandler);
			settings.onError(this.errorLoadAllImagesHandler);
			settings.autoDispose(false);
			settings.autoLoad(false);
			settings.maxConnections(5);
			settings.name("sceneImages");
			
			var loader:LoaderMax = new LoaderMax(settings);
			loader.append( new ImageLoader(urlButton, {name:"buttonImg", estimatedBytes:5000, onComplete:completeLoadImageHandler, container:buttonImg}));
			loader.append( new ImageLoader(urlButtonOver, {name:"buttonImgOver", estimatedBytes:5000, onComplete:completeLoadImageOverHandler, container:buttonImgOver}));
			loader.load();
		}
		
		public function changeButtonState(state:String):void
		{
			switch(state){
				case OVER:
					if(overImgEnabled){
						buttonImgOver.visible = true;
						buttonImg.visible = false;
					}else{
						buttonImg.scaleX = buttonImg.scaleY += 0.1;
					}
					break;
				case OUT:
					if(overImgEnabled){
						buttonImgOver.visible = false;
						buttonImg.visible = true;
					}else{
						buttonImg.scaleX = buttonImg.scaleY -= 0.1;
					}
					break;
			}
		}
		
		private function completeLoadAllImagesHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "BUTTON - [ " + buttonName + " ] - completeLoadAllImagesHandler");
			overImgEnabled = true;
			changeButtonState(OUT);
		}
		
		private function errorLoadAllImagesHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "BUTTON - [ " + buttonName + " ] - errorLoadAllImagesHandler");
			overImgEnabled = false;
		}
		
		private function completeLoadImageHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "BUTTON - [ " + buttonName + " ] - completeLoadImageHandler");
		}
		
		private function completeLoadImageOverHandler(event:LoaderEvent):void
		{
			Debug.message(Debug.INFO, "BUTTON - [ " + buttonName + " ] - OVER - completeLoadImageOverHandler");
		}
		
		public function destroy():void
		{
			buttonName = "";
			if(buttonImg){
				this.removeChild(buttonImg);
				buttonImg = null;
			}
			if(buttonImgOver){
				this.removeChild(buttonImgOver);
				buttonImgOver = null;
			}
		}
		
		public function setButtonName(value:String):void
		{
			buttonName = value;
		}
		
		public function setUrlButton(value:String):void
		{
			urlButton = value;
		}
		
		public function setUrlButtonOver(value:String):void
		{
			urlButtonOver = value;
		}
	}
}