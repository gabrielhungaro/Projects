////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////

package com.scene
{
	import com.ContainerMusic;
	import com.MusicAsset;
	import com.StartScreenAsset;
	import com.greensock.TweenMax;
	import com.sound.SoundBlindHero;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.ui.Keyboard;
	
	/**
	 * com.StartScreen
	 *
	 * @author Gabriel Hungaro
	 */
	
	public class StartScreen extends Scene
	{
		
		private var startScreenAsset:StartScreenAsset;
		private var musicAsset:MusicAsset;
		private var containerMusics:ContainerMusic;
		//private var numberOfMusics:int = 3;
		private var musicSelected:int = 1;
		private var deslocamentoTrocaDeMusica:int = 100;
		
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader;
		private var musicListXML:XML;
		private var totalOfMusics:int;
		private var listaComNomeDasMusicas:Vector.<String> = new Vector.<String>();
		
		private var musicNameHolder:MusicNameAsset;
		private var musicURL:String = "xml/musicas.xml";
		
		public function StartScreen():void
		{
			
		}
		
		override public function init():void
		{
			this.sceneManager.soundManager.stopAll();
			
			startScreenAsset = new StartScreenAsset();
			this.setAsset(startScreenAsset);
			this.addChild(startScreenAsset);
			this.musicSelected = 1;
			
			loadXML();
			
			
			containerMusics = new ContainerMusic();
			containerMusics.x = 500;
			containerMusics.y = 200;
			this.addChild(containerMusics);
			
			this.sceneManager.soundManager.playSoundByName(SoundBlindHero.TRILHA_MENU);
			this.sceneManager.soundManager.playSoundByName(SoundBlindHero.TELA_MENU_PRINCIPAL2);
			
		}
		
		public function loadXML(/*levelNumber:int, levelName:String*/):void {
			xmlRequest = new URLRequest(musicURL);
			//xmlRequest = new URLRequest("xml/musicas.xml");
			//xmlRequest = new URLRequest("C:/PulseBanca/xml/musicas.xml");
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onLoadMusicListHandler);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.load(xmlRequest);
		}
		
		private function onLoadMusicListHandler(event:Event):void {
			listaComNomeDasMusicas = new Vector.<String>();
			musicListXML = new XML(event.target.data);
			totalOfMusics = musicListXML.*[0].*.length();
			for (var i:int = 0; i < totalOfMusics; i++) 
			{
				//poe o nome da musica no array que vai aparecer
				//loadMusicaXML(currentMusic);
				listaComNomeDasMusicas.push(musicListXML.*[0].*[i].@nome);
			}
			
			preencherListaDeMusicas(listaComNomeDasMusicas);
		}
		
		private function preencherListaDeMusicas(listaDasMusicas:Vector.<String>):void
		{
			for (var i:int = 0; i < listaComNomeDasMusicas.length; i++) 
			{
				musicNameHolder = new MusicNameAsset();
				containerMusics.container.addChild(musicNameHolder);
				musicNameHolder.musicNameTxtField.text = listaDasMusicas[i];
				musicNameHolder.y = musicNameHolder.height*i;
			}
			
			//Preencher a lista de musicas, adiciona listener aos botoes
			this.getMainReference().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		private function onKeyPress(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					if(musicSelected > 1)
					{
						musicSelected--;
						//containerMusics.container.gotoAndStop(containerMusics.container.currentFrame-1);
						TweenMax.to(containerMusics.container, 1, {y:containerMusics.container.y + musicNameHolder.height,onComplete:readicionarListeners});
						
						//tira listener ate terminar o tween
						this.getMainReference().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
						
						playSelectedMusicName();
					}
					break;
				
				case Keyboard.DOWN:
					if(musicSelected < totalOfMusics)
					{
						musicSelected++;
						//containerMusics.container.gotoAndStop(containerMusics.container.currentFrame+1);
						TweenMax.to(containerMusics.container, 1, {y:containerMusics.container.y - musicNameHolder.height,onComplete:readicionarListeners});
						//tira listener ate terminar o tween
						this.getMainReference().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
						
						playSelectedMusicName();
					}
					break;
				
				case Keyboard.SPACE:
					onStart();
					break;
				
				case Keyboard.RIGHT:
					//onQuit();
					break;
			}
		}
		
		private function readicionarListeners():void
		{
			this.getMainReference().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		private function playSelectedMusicName():void
		{
			this.sceneManager.soundManager.stopAll();
			/*switch(musicSelected)
			{
				case 1:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.MUSICA1_FACIL);
					break;
				
				case 2:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.MUSICA2_MEDIO);
					break;
				
				case 3:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.MUSICA3_DIFICIL);
					break;
			}*/
			this.sceneManager.soundManager.playSoundByName("musica"+musicSelected);//SoundBlindHero.MUSICA1_FACIL);
			TweenMax.delayedCall(3, tocarPreview);
		}
		
		private function tocarPreview():void
		{
			this.sceneManager.soundManager.playSoundByName("previewMusica" + musicSelected);
		}
		
		private function onQuit():void
		{
			System.exit(0);
		}
		
		private function onStart():void
		{
			//sceneManager.soundManager.playSoundByName("CLICK");
			destroy();
			this.sceneManager.setCurrentMusic(musicSelected);
			this.gotoScene(GameState.STATE_IN_GAME);
		}
		
		override protected function gotoScene(sceneName:String):void
		{
			super.gotoScene(sceneName);
		}
		
		override public function destroy():void
		{
			this.getMainReference().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			startScreenAsset = null;
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("[ ERROR ] - Erro ao carregar XML com a lista de musicas.");
			trace("Error: " + event.text);
		}
		
	}
}