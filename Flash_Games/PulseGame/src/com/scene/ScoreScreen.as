////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////

package com.scene
{
	import com.ScoreScreenAsset;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.sound.SoundBlindHero;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.ui.Keyboard;
	
	/**
	 * com.scene.ScoreScreen
	 *
	 * @author Gabriel Hungaro
	 */
	public class ScoreScreen extends Scene
	{
		
		private var scoreScreenAsset:ScoreScreenAsset;
		private var pontosString:String;
		
		public function ScoreScreen()
		{
			
		}
		
		override public function init():void
		{
			this.sceneManager.soundManager.stopAll();
			scoreScreenAsset = new ScoreScreenAsset();
			
			TweenMax.delayedCall(2, falarPontuacaoFoi);
			
			this.addChild(scoreScreenAsset);
		}
		
		private function falarPontuacaoFoi():void
		{
			TweenMax.delayedCall(3, falarNota);
			this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SUA_PONTUACAO_FOI2);
		}
		
		private function falarNota():void
		{
			pontosString = this.sceneManager.getPoints().toString();
			var pontosNumber:Number = this.sceneManager.getPoints();
			this.scoreScreenAsset.pointsText.maxChars = 3;
			this.scoreScreenAsset.pointsText.text = pontosString;
			
			if(pontosNumber == 0)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ZERO);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 1)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.UM);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 2)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DOIS);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 3)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.TRES);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 4)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.QUATRO);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 5)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.CINCO);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 6)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SEIS);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 7)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SETE);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 8)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.OITO);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 9)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOVE);
				TweenMax.delayedCall(2, falarMedia);
			}
			else if(pontosNumber == 10)
			{
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DEZ);
				TweenMax.delayedCall(2, falarMedia);
			}
			/*	else if(pontosString.search(".") == -1)
			{
				switch(pontosNumber){
					case 0:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ZERO);
						break;
					case 1:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.UM);
						break;
					case 2:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DOIS);
						break;
					case 3:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.TRES);
						break;
					case 4:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.QUATRO);
						break;
					case 5:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.CINCO);
						break;
					case 6:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SEIS);
						break;
					case 7:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SETE);
						break;
					case 8:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.OITO);
						break;
					case 9:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOVE);
						break;
					case 10:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DEZ);
						break;
				}
				
				TweenMax.delayedCall(2, falarMedia);
			}*/
			else
			{
				var pontosStr:String = pontosString.substr(0,1);
				trace("Pontos = ", pontosStr);
				switch(int(pontosStr))
				{
					case 0:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ZERO);
						break;
					case 1:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.UM);
						break;
					case 2:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DOIS);
						break;
					case 3:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.TRES);
						break;
					case 4:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.QUATRO);
						break;
					case 5:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.CINCO);
						break;
					case 6:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SEIS);
						break;
					case 7:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SETE);
						break;
					case 8:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.OITO);
						break;
					case 9:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOVE);
						break;
					case 10:
						this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DEZ);
						break;
				}
				
				TweenMax.delayedCall(1, falarPonto);
			}
		}
		
		private function falarPonto():void
		{
			// TODO Auto Generated method stub
			this.sceneManager.soundManager.playSoundByName(SoundBlindHero.PONTO);
			
			TweenMax.delayedCall(1, falarNotaDepoisDoPonto);
		}
		
		private function falarNotaDepoisDoPonto():void
		{
			var pontosStr:String = pontosString.substr(2,1);
			trace("eu sou depois do ponto", pontosStr);
			switch(int(pontosStr))
			{
				case 0:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.ZERO);
					break;
				case 1:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.UM);
					break;
				case 2:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DOIS);
					break;
				case 3:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.TRES);
					break;
				case 4:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.QUATRO);
					break;
				case 5:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.CINCO);
					break;
				case 6:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SEIS);
					break;
				case 7:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.SETE);
					break;
				case 8:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.OITO);
					break;
				case 9:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.NOVE);
					break;
				case 10:
					this.sceneManager.soundManager.playSoundByName(SoundBlindHero.DEZ);
					break;
			}
			
			
			
			TweenMax.delayedCall(2, falarMedia);
		}
		
		private function falarMedia():void
		{
			if(this.sceneManager.getPoints() <= 3){
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.PERFORMANCE_RUIM);
			}else if(this.sceneManager.getPoints() > 4 && this.sceneManager.getPoints() <= 7){
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.PERFORMANCE_MEDIA);
			}else if(this.sceneManager.getPoints() > 7 && this.sceneManager.getPoints() <= 10){
				this.sceneManager.soundManager.playSoundByName(SoundBlindHero.PERFORMANCE_BOA);
			}
			
			TweenMax.delayedCall(4, falarVoltarMenu);
			
			this.getMainReference().stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		private function falarVoltarMenu():void
		{
			// TODO Auto Generated method stub
			this.sceneManager.soundManager.playSoundByName(SoundBlindHero.VOLTAR_MENU);
		}
		
		private function onKeyPress(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.SPACE:
					onSelectedMenu();
					break;
				
				case Keyboard.RIGHT:
					//onQuit();
					break;
			}
			
			this.getMainReference().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		protected function onSelectedMenu():void
		{
			this.gotoScene(GameState.STATE_START_SCREEN);
		}
		
		private function onQuit():void
		{
			System.exit(0);
		}
		
		override protected function gotoScene(sceneName:String):void
		{
			super.gotoScene(sceneName);
		}
		
		override public function destroy():void
		{
			
			this.removeChild(scoreScreenAsset);
			this.getMainReference().stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
	}
}