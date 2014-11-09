////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////


package com.scene {
	import com.ButtonsController;
	import com.GameScreenAsset;
	import com.Input;
	import com.MusicBuilder;
	import com.events.ExternalEvents;
	import com.greensock.TweenMax;
	import com.songs.Song;
	import com.songs.Song1;
	import com.songs.Song2;
	import com.songs.Song3;
	import com.songs.Song4;
	import com.songs.Song5;
	import com.songs.Song6;
	import com.sound.SoundBlindHero;
	import com.sound.Subwooffer;
	import com.sound.Waveform;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * com.globo.sitio.jogos.doutorCaramujo.scene.GameScene
	 *
	 * @author YourName
	 */
	public class GameScene extends Scene {
		///////////////////////
		// PROPERTIES
		///////////////////////
		
		private var gameScreen:GameScreenAsset;
		
		private var musicBuilder:MusicBuilder;
		
		private var nota1				:Song1;
		private var nota2				:Song2;
		private var nota3				:Song3;
		private var nota4				:Song4;
		private var nota5				:Song5;
		private var nota6				:Song6;
		private var music				:Object;
		private var arrayDeNotasMC		:Vector.<Song> = new Vector.<Song>();
		private var timer				:int;
		private var lastButtonPressed:int;
		private var arrayCurrentNotes:Array = [];
		private var numberOfNotesCreated:int = 0;
		private var canPressButtons:Boolean = false;
		private var arrayPressedNotes:Array = [];
		
		//Nao mecher nesse numero(12)..multiplicador do delay..delay entre sequencias eh 12x maior que delay entre notas(setado no xml)
		private var multiplicadorDeDelay:int = 12;
		private var tempoAteVerificar:int = 8;//4 = tempo exato que aparece os botoes | 6 = 1.5x tempo q aparece os botoes | 8 = verifica na hr que aparece a proxima sequencia
		private var jaVerificou:Boolean = false;
		private var quantidadeDeSequenciaDaMusica:Number = 0;
		private var quantidadeDeSequenciaCertas:Number = 0;
		private var quantidadeDeNotasAcertadas:int;
		private var godModeON:Boolean = false;
		
		public function GameScene() 
		{
			
		}
		
		override public function init():void
		{
			this.sceneManager.soundManager.stopAll();
			gameScreen = new GameScreenAsset();
			this.addChild(gameScreen);
			this.getMainReference().stage.focus = this;
			
			arrayCurrentNotes = [];
			numberOfNotesCreated = 0;
			canPressButtons = false;
			arrayPressedNotes = [];
			
			jaVerificou = false;
			quantidadeDeSequenciaDaMusica = 0;
			quantidadeDeSequenciaCertas = 0;
			
			musicBuilder = new MusicBuilder();
			musicBuilder.setSceneManagerReference(this.sceneManager);
			musicBuilder.addEventListener(ExternalEvents.ON_LOAD_MUSIC, onLoadMusic);
			musicBuilder.init();
			
			var posicaoDawave:int = 50;
			var posXdoEq:int = 397;//397 = entre caixas com scale 1.9
			var posYdoEq:int = 300;//300
			var scaleDosEq:Number = 1.9;
			var alphaDosEq:Number = 0.2;
			
			var vis:Waveform = new Waveform(false, posicaoDawave,0x99FFFF,0xCC33FF);
			vis.x = posXdoEq;
			vis.y = posYdoEq;
			vis.scaleX = vis.scaleY = scaleDosEq;
			addChild(vis);
			vis.alpha = alphaDosEq;
			
			var vis2:Waveform = new Waveform(false, posicaoDawave+10,0xFF0000,0xFF6600);
			vis2.x = posXdoEq;
			vis2.y = posYdoEq;
			vis2.scaleX = vis2.scaleY = scaleDosEq;
			addChild(vis2);
			vis2.alpha = alphaDosEq;
			
			var vist3:Waveform = new Waveform(false, posicaoDawave+20,0xFFFF00,0x99FF00);
			vist3.x = posXdoEq;
			vist3.y = posYdoEq;
			vist3.scaleX = vist3.scaleY = scaleDosEq;
			addChild(vist3);
			vist3.alpha = alphaDosEq;
			
			var sub1:Subwooffer = new Subwooffer();
			sub1.x = 290;
			sub1.y = 315;
			sub1.alpha = .5;
			sub1.scaleX = -1;
			addChild(sub1);
			
			var sub2:Subwooffer = new Subwooffer();
			sub2.x = 290;
			sub2.y = 500;
			sub2.alpha = .5;
			sub2.scaleX = -1;
			addChild(sub2);
			
			var sub3:Subwooffer = new Subwooffer();
			sub3.x = 990;
			sub3.y = 315;
			sub3.alpha = .5;
			sub3.scaleX = 1;
			addChild(sub3);
			
			var sub4:Subwooffer = new Subwooffer();
			sub4.x = 990;
			sub4.y = 500;
			sub4.alpha = .5;
			sub4.scaleX = 1;
			addChild(sub4);
			
			this.getMainReference().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		protected function onLoadMusic(event:ExternalEvents):void
		{
			music = event._music;
			this.sceneManager.setMusicObject(music);
			quantidadeDeNotasAcertadas = 0;
			//Agenda chamada de cada sequencia da musica
			
			this.sceneManager.soundManager.playSoundByName(music.musicaFundo);
			this.sceneManager.soundManager.playSoundByName(music.musicaCerta);
			this.sceneManager.soundManager.playSoundByName(music.musicaErrada);
			//this.sceneManager.soundManager.getSoundObjectByName(music.musicaCerta).setVolume(0);
			//this.sceneManager.soundManager.getSoundObjectByName(music.musicaErrada).setVolume(0);
			
			
			for (var i:int = 0; i < music.sequencias.length; i++) 
			{
				trace("[Function]OnLoadMusic"+" -delaySeq"+i+ ": "+ (music.delay*multiplicadorDeDelay)*(i+1)+"  -sequencia:"+music.sequencias[i]);
				TweenMax.delayedCall((music.delay*multiplicadorDeDelay)*(i+1), startSequence, [music.sequencias[i]]);
				quantidadeDeSequenciaDaMusica++;
				if(i == music.sequencias.length-1){
					TweenMax.delayedCall((music.delay*multiplicadorDeDelay)*(i+2), completeSong);
				}
			}
		}
		
		private function startSequence(sequencia:Array):void
		{
			//Limpa todas as informacoes da sequencia atual antes de mandar a proxima
			clearSequenciaInformation();
			
			//Cria primeira nota da sequencia sem delay
			trace("[Function]startSequence"+ " -delayEntreNotas: "+0 +"   -Nota: "+sequencia[i]);
			createNote(sequencia[0]);
			
			//Cria notas restantes da sequencia com delay entre elas
			for(var i:int = 1; i < sequencia.length; i++)
			{
				trace("[Function]startSequence"+ " -delayEntreNotas: "+music.delay*i +"   -Nota: "+sequencia[i]);
				TweenMax.delayedCall(music.delay*i, createNote,[sequencia[i]])
			}
			
			//Seta notas da sequencia atual
			for(var j:int = 0; j < sequencia.length; j++)
			{
				arrayCurrentNotes.push(sequencia[j]);
			}
			
			trace("[Function]startSequence"+ "NotasDaSequenciaAtual: "+arrayCurrentNotes);
		}
		
		private function clearSequenciaInformation():void
		{
			trace("############ FUNCTION clearSequenciaInformation()  #####################");
			//Remove todas as notas da tela
			for (var k:int = 0; k < arrayDeNotasMC.length; k++) 
			{
				if(this.contains(arrayDeNotasMC[k]))
					this.removeChild(arrayDeNotasMC[k]);
			}
			trace("[Function]clearSequenciaInformation"+ "   -Removeu todas notas da tela");
			
			//Zera as notas certas da sequencia anterior
			arrayCurrentNotes = [];
			trace("[Function]clearSequenciaInformation"+ "   -Zerou as notas certas da sequencia anterior");
			
			//Zera a quantidade de notas criadas
			numberOfNotesCreated = 0;
			trace("[Function]clearSequenciaInformation"+ "   -Zerou a quantidade de notas criadas(usada para liberar o pressionamento de botoes");
			
			//Bloqueia os botoes ateh ter as 4 notas na tela
			canPressButtons = false;
			trace("[Function]clearSequenciaInformation"+ "   -Bloqueou os botoes");
			
			//Zera a array de botoes pressionados(notas escolhidas/digitadas)
			arrayPressedNotes = [];
			trace("[Function]clearSequenciaInformation"+ "   -Zerou as notas que foram pressionadas");
			
			jaVerificou = false;
			trace("############ END clearSequenciaInformation()  #####################");
		}
		
		private function completeSong():void
		{
			trace("############ [Function] completeSong()  #####################");
			var points:Number;
			var quantidadeDeNotasDaMusica:int = quantidadeDeSequenciaDaMusica*4;
			trace("############ [Pontos]", (100*quantidadeDeNotasAcertadas)/quantidadeDeNotasDaMusica);
			points = ((100*quantidadeDeNotasAcertadas)/quantidadeDeNotasDaMusica)/10;
			trace("############ [Pontos]", points);
			this.sceneManager.setPoints(points);
			
			this.getMainReference().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			
			this.gotoScene(GameState.STATE_SCORE_SCREEN);
		}
		
		protected function onKeyPress(event:KeyboardEvent):void
		{
			keyboardConverter(event);
		}
		
		private function keyboardConverter(event:KeyboardEvent):void
		{
			if(canPressButtons)
			{
				switch (event.keyCode)
				{
					case Input.keyboard1:
						lastButtonPressed = 2; 
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_1);
						break;
					
					case Input.keyboard2:
						lastButtonPressed = 3; 
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_2);
						break;
					
					case Input.keyboard3:
						lastButtonPressed = 4; 
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_3);
						break;
					
					case Input.keyboard4:
						lastButtonPressed = 5; 
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_4);
						break;
					
					case Input.keyboard5:
						lastButtonPressed = 6; 
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_5);
						break;
					
					case Input.keyboard6:
						lastButtonPressed = 7; 
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_6);
						break;
				}
				
				//Soh adiciona a nota no array se ja nao tiver as 4 notas
				if(arrayPressedNotes.length < 4)
					arrayPressedNotes.push(lastButtonPressed);
				
				if(arrayPressedNotes.length == 4)
				{
					verifyNotes();
				}
				trace("[Function]keyboardConverter"+"   -Notas pressionadas: "+arrayPressedNotes);  
			}
		}
		
		private function createNote(nota:int):void
		{
			switch(nota)
			{
				case 2:
					nota1 = new Song1();
					this.addChild(nota1);
					TweenMax.to(nota1, music.delay*2, {alpha:0/*visible: false*/});
					arrayDeNotasMC.push(nota1);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_1);
					ButtonsController.earthQuakeButton(2,music.delay);
					break;
				
				case 3:
					nota2 = new Song2();
					this.addChild(nota2);
					TweenMax.to(nota2, music.delay*2, {alpha:0/*visible: false*/});
					arrayDeNotasMC.push(nota2);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_2);
					ButtonsController.earthQuakeButton(3,music.delay);
					break;
				
				case 4:
					nota3 = new Song3();
					this.addChild(nota3);
					TweenMax.to(nota3, music.delay*2, {alpha:0/*visible: false*/});
					arrayDeNotasMC.push(nota3);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_3);
					ButtonsController.earthQuakeButton(4,music.delay);
					break;
				
				case 5:
					nota4 = new Song4();
					this.addChild(nota4);
					TweenMax.to(nota4, music.delay*2, {alpha:0/*visible: false*/});
					arrayDeNotasMC.push(nota4);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_4);
					ButtonsController.earthQuakeButton(5,music.delay);
					break;
				
				case 6:
					nota5 = new Song5();
					this.addChild(nota5);
					TweenMax.to(nota5, music.delay*2, {alpha:0/*visible: false*/});
					arrayDeNotasMC.push(nota5);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_5);
					ButtonsController.earthQuakeButton(6,music.delay);
					break;
				
				case 7:
					nota6 = new Song6();
					this.addChild(nota6);
					TweenMax.to(nota6, music.delay*2, {alpha:0/*visible: false*/});
					arrayDeNotasMC.push(nota6);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOTA_6);
					ButtonsController.earthQuakeButton(7,music.delay);
					break;
			}
			
			numberOfNotesCreated++;
			
			if(numberOfNotesCreated >= 4)
			{
				canPressButtons = true;
				trace("[Function]createNote"+"   -Todas notas criadas("+numberOfNotesCreated+")"+"   -canPressButtons: "+canPressButtons);
				
				TweenMax.delayedCall(music.delay*tempoAteVerificar, verifyNotes);
				trace("[Function]createNote"+"   -Agendada verificacao de notas em "+music.delay*tempoAteVerificar+" segundos");
			}
		}
		
		private function verifyNotes():void
		{
			trace("############ FUNCTION verifyNotes()  #####################");
			if(!jaVerificou)
			{
				var numberOfCorrecNotesInSequence:int = 0;
				
				for(var i:int = 0; i< arrayCurrentNotes.length; i++)
				{
					if(godModeON){
						arrayPressedNotes[i] = arrayCurrentNotes[i];
					}
					
					if(arrayCurrentNotes[i] == arrayPressedNotes[i])
					{
						numberOfCorrecNotesInSequence++;
						quantidadeDeNotasAcertadas++;
					}
				}
				
				if(numberOfCorrecNotesInSequence <=1)
				{
					trace("[Function]verifyNotes"+ "   -ERREI A SEQUENCIA");
					this.sceneManager.soundManager.getSoundObjectByName(music.musicaErrada).setVolume(0);
					this.sceneManager.soundManager.getSoundObjectByName(music.musicaCerta).setVolume(0);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ERROU);
				}
				else if(numberOfCorrecNotesInSequence == 2 || numberOfCorrecNotesInSequence == 3)
				{
					trace("[Function]verifyNotes"+ "   -ACERTEI MEIA SEQUENCIA");
					quantidadeDeSequenciaCertas += 0.5;
					this.sceneManager.soundManager.getSoundObjectByName(music.musicaErrada).setVolume(1);
					this.sceneManager.soundManager.getSoundObjectByName(music.musicaCerta).setVolume(0);
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ACERTOUMETADE);
				}
				else
				{
					trace("[Function]verifyNotes"+ "   -ACERTEI A SEQUENCIA");
					//this.sceneManager.soundManager.stopAll();
					quantidadeDeSequenciaCertas++;
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ACERTOU);
					this.sceneManager.soundManager.getSoundObjectByName(music.musicaErrada).setVolume(1);
					this.sceneManager.soundManager.getSoundObjectByName(music.musicaCerta).setVolume(1);
				}
			}
			
			jaVerificou = true;
			trace("############ END verifyNotes()  #####################");
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}