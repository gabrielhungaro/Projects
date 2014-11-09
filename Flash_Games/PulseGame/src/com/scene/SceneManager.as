////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////

package com.scene
{
	import com.Pulse;
	import com.greensock.TweenMax;
	import com.sound.SoundBlindHero;
	import com.sound.SoundManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import fl.controls.TextArea;
	
	/**
	 * com.globo.sitio.jogos.doutorCaramujo.scene.SceneManager
	 *
	 * @author Gabriel Hungaro
	 */
	public class SceneManager
	{
		///////////////////////
		// PROPERTIES
		///////////////////////
		
		private var gameStates:Vector.<Scene>;
		private var currentState:String;
		private var display:Sprite = null;
		public var currentScene:Scene;
		private var currentMusic:int;
		
		public var _blindHero:Pulse;
		
		public var soundManager:SoundManager = new SoundManager();
		private var musicObject:Object;
		
		//private var arrayOfMusics
		
		///////////////////////
		// METHODS
		///////////////////////
		private var points:Number;
		private var output:TextArea;
		private var withControl:Boolean;
		public function SceneManager(displayObj:Sprite, blindHero:Pulse):void
		{
			_blindHero = blindHero;
			display = displayObj;
			
			var soundBlindHero:SoundBlindHero = SoundBlindHero.getInstance();
			soundBlindHero.loadSounds(soundManager);
			
			gameStates = new Vector.<Scene>;
			
			this.add(GameState.STATE_START_SCREEN, new StartScreen(), new Point(0, 0));
			this.add(GameState.STATE_IN_GAME, new GameScene(), new Point(0, 0));
			this.add(GameState.STATE_SCORE_SCREEN, new ScoreScreen(), new Point(0, 0));
			this.changeScene(GameState.STATE_START_SCREEN);
			
		}
		
		public function getCurrentMusic():int
		{
			return currentMusic;
		}

		public function setCurrentMusic(value:int):void
		{
			currentMusic = value;
		}

		private function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.scaleX = 1;
			event.currentTarget.scaleY = 1;
			TweenMax.to(event.currentTarget, 0.1, {colorTransform:{tint:0xffffff, exposure:1}});
		}
		
		private function onMouseOver(event:MouseEvent):void
		{
			//event.currentTarget.scaleX = 1.1;
			//event.currentTarget.scaleY = 1.1;
			TweenMax.to(event.currentTarget, 0.1, {colorTransform:{tint:0xffffff, exposure:1.3}});
		}
		
		public function add(name:String, screenAsset:Scene, position:Point):void
		{
			
			if (this.getStateByName(name))
			{
				trace(this.getStateByName(name));
				trace("Scene ja existe");
				return;
			}
			
			screenAsset.addEventListener(SceneEvent.ON_SCENE_SELECTED, onSceneSelectedHandler);
			screenAsset.setName(name);
			gameStates.push(screenAsset);
		}
		
		protected function onSceneSelectedHandler(event:SceneEvent):void
		{
			trace("[CALLBACK] - onSceneSelectedHandler", event.sceneSelected);
			this.changeScene(event.sceneSelected);
		}
		
		private function onClickClear(e:MouseEvent):void
		{
			//_capricho.outputTxt.text = "";
		}
		
		public function removeSceneByName(name:String):void
		{
			//TODO
			if (name != null)
			{
				display.removeChild(getStateByName(name));
			}
		}
		
		public function changeScene(state:String):void
		{
			//TODO
			if (currentState != state)
			{
				this.removeSceneByName(currentState);
				currentState = state;
				currentScene = new Scene();
				currentScene = getStateByName(currentState);
				currentScene.setManagerRef(this);
				currentScene.setMainReference(_blindHero);
				display.addChild(currentScene);
				currentScene.init();
			}
			else
			{
				trace("O ESTADO ESCOLHIDO E O MESMO DO ANTERIOR");
			}
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
		
		}
		
		public function getStateByName(name:String):Scene
		{
			//TODO
			for (var i:int = 0; i < gameStates.length; i++)
			{
				if (gameStates[i].getName() == name)
				{
					return gameStates[i];
				}
			}
			return null;
		}
		
		public function getDisplay():Sprite
		{
			return display;
		}
		
		public function setDisplay(value:Sprite):void
		{
			display = value;
		}
		
		public function setMusicObject(value:Object):void
		{
			musicObject = value;
		}
		
		public function getMusicObject():Object
		{
			return musicObject;
		}
		
		public function setPoints(value:Number):void
		{
			points = value;
		}
		
		public function getPoints():Number
		{
			return points;
		}
		
		public function setOutput(value:TextArea):void
		{
			output = value;
		}
		
		public function getOutput():TextArea
		{
			return output;
		}
		
		public function setControl(value:Boolean):void
		{
			withControl = value;
		}
		
		public function getControl():Boolean
		{
			return withControl;
		}
	}
}