package com.sound
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	internal final class SoundObject
	{
		/**Controlador do som**/
		private var transform:SoundTransform = new SoundTransform(0);
		/**Nome pelo qual o nome sera tratado***/
		private var name:String = null;
		/**Tipo do som**/
		private var type:String = null;
		/**Canal que o som esta tocando, é apartir dele que podemos diminuir, parar ou mudar o som**/
		private var channel:SoundChannel = null;
		/**src do som**/
		private var sound:Sound = null;
		/**Funcao que sera chamada toda a vez que o som chegar ao final***/
		private var callbackComplete:Function = null;
		/**Posicao que o som irá inciar**/
		private var position:int = 0;
		/**Tempo de delay para tocar entre as repiticoes do som**/
		private var delay:Number = 0;
		/**Tempo que o fadeIn e ou fadeOut levara para realizar a transicao**/
		private var tweenDuration:Number = 20;
		/**Volume do som***/
		private var volume:Number = 1;
		
		/**Autoriza toda vez que o som for parado ser realizado o fadeIn**/
		private var fadeIn:Boolean;
		/**Autoriza toda vez que o som for iniciado ser realizado o fadeOut**/
		private var fadeOut:Boolean;
		/**Indica que o som é caregado por stream**/
 		private var isStream:Boolean;
		/**Autoriza o som realizar repeticoes**/
		private var isLoop:Boolean;
		
		/*****/
		
		/**Parametro que decide se um som pode ser tocado novamente antes do seu soundComplete*/
		private var waitForSoundCompleteToPlayAgain:Boolean;
		
		/**Verifica se o som está sendo tocado*/
		private var isPlaying:Boolean;
		
		
		
		public function SoundObject()
		{
			TweenPlugin.activate([VolumePlugin]);
		}
		
		/****/
		public function play():void{
			if(sound){
				if(canPlay()){
					isPlaying = true;
					if(fadeOut){
						channel = sound.play(this.position,0,transform);
						TweenLite.to(channel, tweenDuration,{volume:this.volume});
					}else{
						transform.volume = this.volume;
						channel = sound.play(0,0,transform);
					}
					
					channel.addEventListener(Event.SOUND_COMPLETE, onSoundCompleteHandler, false, 0, true);
				}
			}
		}
		
		private function canPlay():Boolean{
			if(waitForSoundCompleteToPlayAgain){
				if(isPlaying){
					return false;
				}
			}
			return true;
		}
		
		internal function updateChannel():void{
			channel.soundTransform = transform;
		}
		
		/****/
		protected function onSoundCompleteHandler(event:Event):void
		{
			isPlaying = false;
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundCompleteHandler, false);
			if(this.callbackComplete != null){
				this.callbackComplete(event)
			}
			
			//Zerando a posicao para o som da proxima vez que for execultado comecar do inicio 
			this.position = 0;
					
			if(isLoop){
				play();
			}
		}
		
		/****/
		public function stop():void{
			isPlaying = false;
			if(channel){
				if(fadeIn){
					TweenLite.to(sound, tweenDuration, {volume:0, onComplete:this.onStopSoundTweenComplete});
				}else{
					this.onStopSoundTweenComplete();
				}
			}
		}
		
		/**Metodo utilizado somente pela funcao stop**/
		internal function onStopSoundTweenComplete():void{
			if(channel){
				channel.stop();
				this.position = channel.position;	
			}
		}
		
		
		/**Nome do som**/
		public function getName():String
		{
			return name;
		}
		
		/**Nome do som**/
		public function setName(value:String):void
		{
			if(value == "" || value == null)
				//throw new TheValueCanNotBeNull();
				trace("O Nome do som nao pode ser nulo");
			
			name = value
		}

		/**Canal do som**/
		public function getChannel():SoundChannel
		{
			return channel;
		}

		/**
		 * @private
		 */
		public function setChannel(value:SoundChannel):void
		{
			channel = value;
		}

		public function getSound():Sound
		{
			return sound;
		}

		public function setSound(value:Sound):void
		{
			if(value == null)
				//throw new TheValueCanNotBeNull();
				trace("O Objeto som nao pode ser nulo");
			
			sound = value;
		}

		public function getTransform():SoundTransform
		{
			return transform;
		}

		public function setTransform(value:SoundTransform):void
		{
			transform = value;
		}

		public function getIsLoop():Boolean
		{
			return isLoop;
		}

		public function setIsLoop(value:Boolean):void
		{
			isLoop = value;
		}

		public function getCallbackComplete():Function
		{
			return callbackComplete;
		}

		public function setCallbackComplete(value:Function):void
		{
			callbackComplete = value;
		}

		public function getPosition():int
		{
			return position;
		}

		public function setPosition(value:int):void
		{
			position = value;
		}
		
		public function destroy():void{
			if(channel){
				channel.removeEventListener(Event.SOUND_COMPLETE, onSoundCompleteHandler, false);
				this.channel.stop();
			}
			name = null;
			channel= null;
			sound= null;
			transform= null;
			callbackComplete = null;
		}
		
		protected function progressHandler(event:ProgressEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onSecurityErrorHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function errorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			
		}

		public function getIsStream():Boolean
		{
			return isStream;
		}

		public function setIsStream(value:Boolean):void
		{
			isStream = value;
		}

		public function getTweenDuration():Number
		{
			return tweenDuration;
		}

		public function setTweenDuration(value:Number):void
		{
			tweenDuration = value;
		}

		public function getFadeIn():Boolean
		{
			return fadeIn;
		}

		public function setFadeIn(value:Boolean):void
		{
			fadeIn = value;
		}

		public function getFadeOut():Boolean
		{
			return fadeOut;
		}

		public function setFadeOut(value:Boolean):void
		{
			fadeOut = value;
		}

		public function getVolume():Number
		{
			return volume;
		}

		public function setVolume(value:Number):void
		{
			///if(value > 0){
				if(volume != value){
					volume = value;
					setSoundVolume();
				}
			//}
			/*else
			{
				trace("[ WARNING ] - O valor do volume do som nao pode ser menor que 0");
			}*/
		}
		
		private function setSoundVolume():void{
			if(fadeOut != false || fadeIn != false)
			{
				if(channel != null)
				{
					TweenLite.to(sound , this.tweenDuration, {volume:this.volume});	
				}
			}
			else
			{
				if (channel != null)
				{
					transform.volume = this.volume;
					channel.soundTransform = transform;
					channel.soundTransform.volume = this.volume;
				}
			}
		}
		
		public function getIsPlaying():Boolean
		{
			return isPlaying;
		}
		
		private function setIsPlaying(value:Boolean):void
		{
			isPlaying = value;
		}
		
		public function getWaitForSoundCompleteToPlayAgain():Boolean
		{
			return waitForSoundCompleteToPlayAgain;
		}
		
		public function setWaitForSoundCompleteToPlayAgain(value:Boolean):void
		{
			waitForSoundCompleteToPlayAgain = value;
		}
	}
}