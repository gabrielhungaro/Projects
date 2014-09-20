////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////

package com.scene {
	import com.data.Debug;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	/**
	 * com.globo.sitio.jogos.doutorCaramujo.scene.SceneManager
	 *
	 * @author Gabriel Hungaro
	 */
	public class SceneManager extends EventDispatcher{
		///////////////////////
		// PROPERTIES
		///////////////////////
		protected var gameStates:Vector.<Scene>;
		protected var currentState:String;
		protected var display:Sprite = null;
		protected var currentScene:Scene;
		//
		protected var _callBackOnQuit:Function;
		
		///////////////////////
		// METHODS
		///////////////////////
		private var _main:Object;
		private var _applicationQuit:Function;
		
		public function SceneManager(displayObj:Sprite = null, callBackOnQuit:Function = null):void {
			display = displayObj;
			gameStates = new Vector.<Scene>;
			
			_callBackOnQuit = callBackOnQuit;
		}
		
		protected function addEnterFrameHandler(event:Event = null):void
		{
			this.display.removeEventListener(Event.ADDED_TO_STAGE, addEnterFrameHandler, false);
			this.display.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		public function getDisplay():Sprite
		{
			return display;
		}

		public function setDisplay(value:Sprite):void
		{
			if(display != null){
				Debug.message(Debug.WARNING, "Cuidado o diplay da applicacao foi modificado");
				this.display.removeEventListener(Event.ADDED_TO_STAGE, addEnterFrameHandler, false);
			}
			
			display = value;
			if(display.stage){
				addEnterFrameHandler();
			}else{
				this.display.addEventListener(Event.ADDED_TO_STAGE, addEnterFrameHandler, false, 0, true);
			}
			
		}

		public function add(name:String, screenAsset:Scene, position:Point):void {
			try{
				if(this.getStateByName(name)){
					//throw new SceneAlreadyExists(name);
					return;
				}
				
				screenAsset.addEventListener(SceneEvent.ON_SCENE_SELECTED, onSceneSelectedHandler);
				screenAsset.addEventListener(SceneEvent.ON_EXIT, onSceneExit);
				screenAsset.setName(name);
				gameStates.push(screenAsset);
			}catch(error:Error){
				//Debug.message(Debug.ERROR, error.message, error);
				Debug.message(Debug.ERROR, error.message);
			}
		}
		
		protected function update(e:Event):void{
			if(currentScene){
				currentScene.update();
			}
		}
		protected function onSceneExit(Event:SceneEvent):void{
			//_frameExterno.getCarregador().voltarParaLobby();
		}
		
		protected function onSceneSelectedHandler(event:SceneEvent):void
		{
			this.changeScene(event.sceneSelected);
		}
		
		protected function onSceneQuitHandler(event:SceneEvent):void
		{
			if(_callBackOnQuit != null){
				_callBackOnQuit();
			}
		}
		
		protected function onSceneMenuExit(event:SceneEvent):void
		{
		//	this.changeScene(GameState.STATE_MENU);
		}
		
		public function removeSceneByName(name:String):void {
			if(name != null){
				getStateByName(name).destroy();
				//getStateByName(name).visible = false;
			}
		}

		public function changeScene(state:String):void {
			if(currentState != state){
				this.removeSceneByName(currentState);
				currentState = state;
				currentScene = getStateByName(currentState);
				currentScene.setManagerReference(this);
				display.addChild(currentScene);
				currentScene.addEventListener(SceneEvent.ON_SCENE_QUIT, onSceneQuitHandler);
				currentScene.addEventListener(SceneEvent.ON_EXIT, onApplicationQuit);
				if(!currentScene.isSceneInitialized()){
					currentScene.init();
				}else{
					currentScene.visible = true;
					currentScene.continueSceneProcess();
				}
			}else{
				Debug.message(Debug.INFO, "THE STATE: " + state + "IS THE CURRENT")
			}
		}

		public function getStateByName(name:String):Scene {
			for(var i:int = 0; i < gameStates.length; i++){
				if(gameStates[i].getName() == name){
					return gameStates[i];
				}
			}
			return null;
		}
		
		public function onApplicationQuit(event:SceneEvent):void
		{
			if(_applicationQuit != null)
				this._applicationQuit();
		}

		public function destroy():void
		{
			for (var i:int = 0; i < this.gameStates.length; i++) 
			{
				this.gameStates[i].removeEventListener(SceneEvent.ON_SCENE_SELECTED, onSceneSelectedHandler);
				this.gameStates[i].destroy();
				this.gameStates[i] = null;
			}

		}
		
		public function setApplicationQuit(value:Function):void
		{
			_applicationQuit = value;
		}
		
		public function getCurrentState():String
		{
			return currentState;
		}
		
		public function setMainReference(value:Object):void
		{
			_main = value;
		}
		
		public function getMainReference():Object
		{
			return _main;
		}
		
		public function setCurrentScene(value:Scene):void
		{
			currentScene = value;
		}
		
		public function getCurrentScene():Scene
		{
			return currentScene;
		}
		
	}
}