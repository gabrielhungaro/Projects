////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////


package com {
	
	import com.events.ExternalEvents;
	import com.scene.GameScene;
	import com.scene.SceneManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * com
	 *
	 * @author Gabriel Hungaro
	 */
	public class MusicBuilder  extends Sprite{
		///////////////////////
		// PROPERTIES
		///////////////////////
		
		private var currentMusic:int;
		private var gameScene:GameScene;
		private var _sceneManager:SceneManager;
		
		private var musicaRequest:URLRequest;
		private var musicaLoader:URLLoader;
		private var musicsXML:XML;
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader;
		private var musicXML:XML;
		private var totalOfLevels:int;

		///////////////////////
		// METHODS
		///////////////////////
		private var delay:Number;
		private var arrayDeSequancias:Array = new Array();
		private var arrayDeNotas:Array;
		private var music:Object;
		private var musicaFundo:String;
		private var musicaCerta:String;
		private var musicaErrada:String;
		private var musicURL:String = "xml/musicas.xml";
		
		public function MusicBuilder() 
		{
			
		}
		
		public function init():void
		{
			currentMusic = this._sceneManager.getCurrentMusic();
			loadXML();
		}
		
		private function setNewLevel():void
		{			
			/*level = new CC_Level();
			level.setCurrentLevel(currentLevel+1);
			level.setBubbles(bubbles);
			level.setNumberOfRedPills(numberOfRedPills);
			level.setNumberOfBluePills(numberOfBluePills);
			level.setNumberOfYellowPills(numberOfYellowPills);
			level.setNumberOfGreenPills(numberOfGreenPills);
			level.setNumberOfCharactersOnLevel(numberOfCharactersOnLevel);
			level.setTimeToSpawnCharacters(timeToSpawnCharacters);
			level.setPercentOfWhale(percentOfWhale);
			level.setNumberOfWhalePatientsPerLEvel(numberOfWhalePatientsPerLevel);
			level.setSceneManagerReference(_sceneManager);
			level.addEventListener(CC_ExternalApplicationEvents.ON_FINISH_LEVEL, callBackOnFinishLevel);
			level.init();*/
		}
		
		/*public function dispararEvento():void{
			this.dispatchEvent(new CC_ExternalApplicationEvents(CC_ExternalApplicationEvents.ON_LOAD_LEVEL_XML));
		}*/
		
		public function build(levelNumber:XML):void {
			var xml:XML = new XML(levelNumber);
			
			
			delay = xml.delay;
			
			for (var i:int = 1; i < xml.*.length()-3; i++) 
			{
				//trace(xml.*[i].*[0].*.length());
				arrayDeNotas = new Array();
				for (var j:int = 0; j < xml.*[i].*[0].*.length(); j++) 
				{
					//trace(xml.*[i].*[0].*[j].@nota);
					var nota:int = xml.*[i].*[0].*[j].@nota;
					arrayDeNotas.push(nota);
					
				}
				arrayDeSequancias.push(arrayDeNotas);
				//trace("fondof");
			}
			
			musicaFundo = xml.musicaFundo;
			musicaCerta = xml.musicaCerta;
			musicaErrada = xml.musicaErrada;
			
			music = new Object();
			music.delay = new Object();
			music.sequencias = new Object();
			music.musicaFundo = musicaFundo;
			music.musicaCerta = musicaCerta;
			music.musicaErrada = musicaErrada;
			
			music.delay = delay;
			music.sequencias = arrayDeSequancias;
			this.dispatchEvent(new ExternalEvents(ExternalEvents.ON_LOAD_MUSIC, music));
		}

		public function loadXML(/*levelNumber:int, levelName:String*/):void {
			//musicaRequest = new URLRequest("xml/musicas.xml");
			musicaRequest = new URLRequest(musicURL);
			musicaLoader = new URLLoader();
			musicaLoader.addEventListener(Event.COMPLETE, onCompleteTotalOfMusicsHandler);
			musicaLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			musicaLoader.load(musicaRequest);
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("[ ERROR ] - Erro ao carregar XML de level");
		}
		
		private function onCompleteTotalOfMusicsHandler(event:Event):void {
			musicsXML = new XML(event.target.data);
			totalOfLevels = musicsXML.*[0].*.length();
			//for (var i:int = 0; i < totalOfLevels; i++) 
			//{
				loadMusicaXML(currentMusic);
			//}
		}
		
		private function loadMusicaXML(musica:int):void
		{
			//xmlRequest = new URLRequest("xml/musicas/musica"+musica+".xml");
			xmlRequest = new URLRequest("xml/musicas/musica"+musica+".xml");
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onCompleteLoadMusicXML);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			xmlLoader.load(xmlRequest);
		}
		
		protected function onCompleteLoadMusicXML(event:Event):void
		{
			musicXML = new XML(event.target.data);
			build(musicXML);
			
		}
		
		public function setSceneReference(value:GameScene):void
		{
			gameScene = value;
		}
		
		public function setSceneManagerReference(value:SceneManager):void
		{
			_sceneManager = value;
		}
	}
}