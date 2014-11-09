/*
*************************************************************************************************************
* @className Som
* @author Vinicius Cagnotto de Oliveira
* @description
*	SEE CLASS DECLARATION
* @extraNote 
*	Read the text below before read/use/change/steal this code:
*		
*	WARNING: Be sure to make this code works properly if you change/steal it. 
*			 If some problem show up by any incorrect or ilegal changes
*			 you will be hunted and your life will become a nightmare until you fix up all errors.
*
*			 You're assuming your life by touching in a single line of this code.
*************************************************************************************************************
*/

//Diretório [ROOT]/com/sitio/engine/som/
package com.sound {
	
	/*
	 * Classes Importadas  
	 */
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	//Classe Som - Responsável por armazerar e manipular todos os sons que são tocados no Mundo do Sítio
	public class SoundManager {
		
		public static const SOUND_BACKGROUND:String = "backgroundSound"; 
		public static const SOUND_FX:String = "soundFX"; 
		
		//Array de sons
		private var soundsObjects:Vector.<SoundObject> = new Vector.<SoundObject>();
		//Booleana para deixar mudo
		
		/**Seta o volume de todos os sons cadastrados**/
		private var volume:Number = 1;
		
		private var mute:Boolean = false;
		
		/**Metodo que adiciona um novo som para lista
		 * 
		 * @param name:String - insira o nome do som que deseja cadastrar
		 * @param sound:Sound - insira o som que deseja cadastrar
		 * @param loop:Boolean - caso o valor seja true, o som ficara em loop
		 * @param soundComplete:Function - insira a funcao de callback caso voce queira ser informado que o som foi terminado com sucesso.
		 * **/
 		public function add(name:String, 
							sound:Sound, 
							volume:Number = 1, 
							loop:Boolean = false, 
							isStream:Boolean = false, 
							soundComplete:Function = null, 
							fadeIn:Boolean = false, 
							fadeOut:Boolean = false,
							waitForSoundCompleteToPlayAgain:Boolean = true):void{
			//Inicia um novo objeto que será responsável por armazenar as informações do som (O proprio Som, canal, volume, se é loop, etc)
			var objetoSom:SoundObject = new SoundObject();
			//Altoriza o som antes de parar dar Fade in
			objetoSom.setFadeIn(fadeIn);
			//Altoriza o som antes de comecar dar Fade out
			objetoSom.setFadeOut(fadeOut);
			//Guarda o Som passado
			objetoSom.setSound(sound);
			//Sinaliza se o som é via Streaming
			objetoSom.setIsStream(isStream);
			//Guarda o volume inicial
			//objetoSom.setvolumeInicial = volume;
			//Guarda o nome de alias passado
			objetoSom.setName(name);
			//Guarda se o som precisa ficar repetindo ou não
			objetoSom.setIsLoop(loop);
			//Inicia o parametro posição como 0 (inicio)
			objetoSom.setPosition(0);
			//Guarda um método para ser disparado quando o som terminar, caso tenha sido passado
			objetoSom.setCallbackComplete(soundComplete);			
			//setando volume do som 
			objetoSom.setVolume(volume);
			//Seta se o som espera ele terminar pra poder comecar a tocar denovo
			objetoSom.setWaitForSoundCompleteToPlayAgain(waitForSoundCompleteToPlayAgain);
			//Adiciona o objeto de configurações do Som no array de Sons
			soundsObjects.push(objetoSom);
		}
		
		/**Metodo que adiciona um novo som para lista
		 * 
		 * @param name:String - insira o nome do som que deseja cadastrar
		 * @param sound:Sound - insira o som que deseja cadastrar
		 * @param loop:Boolean - caso o valor seja true, o som ficara em loop
		 * @param soundComplete:Function - insira a funcao de callback caso voce queira ser informado que o som foi terminado com sucesso.
		 * **/
		public function addStream(name:String, 
								  url:String, 
								  bufferTime:Number = 8000, 
								  volume:Number = 1, 
								  loop:Boolean = false, 
								  soundComplete:Function = null,
								  fadeIn:Boolean = true, 
								  fadeOut:Boolean = true):void
		{
			
			//teste var req:URLRequest = new URLRequest("http://av.adobe.com/podcast/csbu_dev_podcast_epi_2.mp3");
			var req:URLRequest = new URLRequest(url);
			var soundLoaderContext:SoundLoaderContext = new SoundLoaderContext(bufferTime, false);
			var sound:Sound = new Sound(req,soundLoaderContext);
			
			this.add(name, sound, volume, loop, true, soundComplete,fadeIn, fadeOut);
		}
		
		private function setAllVolumes():void{
			for each (var soundObject:SoundObject in soundsObjects) 
			{
				if(soundObject)
					soundObject.setVolume(volume);
			}
		}
		
		public function setVolume(value:Number):void{
			if(value >= 0){
				volume = value;
				setAllVolumes();
			}
			else{
				trace("[ WARNING ] - O valor do volume deve ser maior que 0");
			}
		}
		
		public function getVolume():Number{
			return volume;	
		}

		//Método que encontra um objeto Som no array pelo nome (alias)
		public function getSoundObjectByName(name:String):SoundObject{
			//Declara objeto Som ao qual será atribuído o Objeto Encontrado no array
			var soundObject:SoundObject;
			//Loop por todos os sons que estão no array
	
			for each (var sounds:SoundObject in soundsObjects) 
			{
				if(sounds != null){
					//Verifica se o nome do objeto é igual ao nome procurado
					if(sounds.getName() == name)
					{
						soundObject = sounds;
						break;
					}
				}
			}
			
			if(!soundObject){
				trace("[ WARNING ] - O Som " + name + " nao pode ser encontrado, verifique se o mesmo foi cadastrado")
			}
		
			return soundObject;
		}
		
		//Método que encontra um objeto Som no array pelo canal
		private function getSoundByChannel(channel:SoundChannel):Object{
			//Declara objeto Som ao qual será atribuído o Objeto Encontrado no array
			var objetoSom:Object;
			//Loop por todos os sons que estão no array
			for(var i:int = 0; i < soundsObjects.length; i++){
				//Pega o objeto atual e o joga no objeto criado anteriormente
				objetoSom = soundsObjects[i];
				//Verifica se o objeto não é nulo
				if(objetoSom != null){
					//Verifica se o canal do objeto é igual ao canal procurado
					if(channel == objetoSom.canal){ //se for
						//Sai do loop
						break;
					}else{ //se não for
						//atribui nulo ao objetoSom
						objetoSom = null;
					}
				}
			}
			
			//Retorna o objeto encontrado ou nulo, caso não encontre o objeto
			return objetoSom;
		}
		
		
		/**Reproduzo o som pelo seu nome
		 * 
		 * @param name:String - insiara o nome do som que deseja reproduzir
		 * **/
		public function playSoundByName(name:String):void{
			if(!mute){
				var soundObject:SoundObject = this.getSoundObjectByName(name);
				if(soundObject){
					soundObject.play();
				}else{
					trace("[ WARNING ] - Nao foi possivel reproduzir o " + name + ".mp3 ");
				}
			}else{
				trace("[ WARNING ] - Nao foi possivel reproduzir o " + name + ".mp3, pois o aplicativo está em MUTE");
			}
		}
		
		/**Reproduzo o som pelo seu nome
		 * 
		 * @param name:String - insiara o nome do som que deseja parar a reproducao
		 * **/
		public function stopSoundByName(name:String):void{
			var soundObject:SoundObject = this.getSoundObjectByName(name);
			if(soundObject){
				soundObject.stop()
			}else{
				trace("[ WARNING ] - Nao foi possivel parar a reproducao do " + name + ".mp3 ");
			}
		}
		
		public function stopAll():void{
			for each (var soundObject:SoundObject in soundsObjects) 
			{
				if(soundObject.getIsPlaying())
				{
					soundObject.stop();
				}
			}
		}
		
		public function destroy():void{
			trace("[ INFO ] - DELETANDO O SONS DA CLASSE");
			for (var i:int = 0; i < soundsObjects.length; i++) 
			{
				if(soundsObjects[i])
					soundsObjects[i].destroy();
				
				soundsObjects[i] = null;
			}
		}

		public function getMute():Boolean
		{
			return mute;
		}

		public function setMute(value:Boolean):void
		{
			if(mute == value)
				return;
			mute = value;
			this.stopAll();
		}

		
	}
}