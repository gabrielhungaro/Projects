package com.sound
{
	import com.sound.SoundManager;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundBlindHero
	{
		private var soundManager:SoundManager = null;
		
		
		private static var instance:SoundBlindHero = null;
		private static var okToCreate:Boolean = false;
		
		//Sons Menu
		public static var MUSICA1_FACIL:String = "musica1";
		public static var MUSICA2_MEDIO:String = "musica2";
		public static var MUSICA3_DIFICIL:String = "musica3";
		public static var PERFORMANCE_BOA:String = "performanceBoa";
		public static var PERFORMANCE_MEDIA:String = "performanceMedia";
		public static var PERFORMANCE_RUIM:String = "performanceRuim";
		public static var TELA_MENU_PRINCIPAL1:String = "telaMenuPrincipal1";
		public static var TELA_MENU_PRINCIPAL2:String = "telaMenuPrincipal2";
		
		public static var TRILHA_MENU:String = "trilhaMenu";
		public static var VOLTAR_MENU:String = "voltarMenu";
		
		//Sons Pontuacao
		public static var ZERO:String = "zero";
		public static var UM:String = "um";
		public static var DOIS:String = "dois";
		public static var TRES:String = "tres";
		public static var QUATRO:String = "quatro";
		public static var CINCO:String = "cinco";
		public static var SEIS:String = "seis";
		public static var SETE:String = "sete";
		public static var OITO:String = "oito";
		public static var NOVE:String = "nove";
		public static var DEZ:String = "dez";
		
		public static var PONTO:String = "ponto";
		
		public static var SUA_PONTUACAO_FOI:String = "suaPontuacao1";
		public static var SUA_PONTUACAO_FOI2:String = "suaPontuacao2";
		
		public static var MUSICA1_FUNDO:String = "musica1Fundo";
		public static var MUSICA1_CERTA:String = "musica1Certa";
		public static var MUSICA1_ERRADA:String = "musica1Errada";
		
		public static var MUSICA2_FUNDO:String = "musica2Fundo";
		public static var MUSICA2_CERTA:String = "musica2Certa";
		public static var MUSICA2_ERRADA:String = "musica2Errada";
		
		public static var MUSICA3_FUNDO:String = "musica3Fundo";
		public static var MUSICA3_CERTA:String = "musica3Certa";
		public static var MUSICA3_ERRADA:String = "musica3Errada";
		
		public static var NOTA_1:String = "nota1";
		public static var NOTA_2:String = "nota2";
		public static var NOTA_3:String = "nota3";
		public static var NOTA_4:String = "nota4";
		public static var NOTA_5:String = "nota5";
		public static var NOTA_6:String = "nota6";
		
		public static var ACERTOU:String = "acertou";
		public static var ERROU:String = "errou";
		public static var ACERTOUMETADE:String = "acertouMetade";
		
		
		public static function getInstance():SoundBlindHero
		{
			if(!instance){
				okToCreate = true;
				instance = new SoundBlindHero();
				okToCreate = false;
			}
			
			return instance;
		}
		
		public function SoundBlindHero()
		{
			if(!okToCreate)
				trace("A classe: SoundBlindHero não pode ser instanciada");
		}
		
		public function loadSounds(sound:SoundManager):void
		{
			sound.add(MUSICA1_FACIL, new musica1(), 1, false);
			sound.add(MUSICA2_MEDIO, new musica2(), 1, false);
			sound.add(MUSICA3_DIFICIL, new musica3(), 1, false);
			sound.add(PERFORMANCE_BOA, new performanceBoa(), 1, false);
			sound.add(PERFORMANCE_MEDIA, new performanceMedia(), 1, false);
			sound.add(PERFORMANCE_RUIM, new performanceRuim(), 1, false);
			sound.add(TELA_MENU_PRINCIPAL1, new telaMenuPrincipal1(), 1, false);
			sound.add(TELA_MENU_PRINCIPAL2, new telaMenuPrincipal2(), 1, false);
			
			sound.add(TRILHA_MENU, new trilhaMenu(), .2, true);
			sound.add(VOLTAR_MENU, new voltarMenu(), 1, false);
			
			sound.add(ZERO, new zero(), 1, false);
			sound.add(UM, new um(), 1, false);
			sound.add(DOIS, new dois(), 1, false);
			sound.add(TRES, new tres(), 1, false);
			sound.add(QUATRO, new quatro(), 1, false);
			sound.add(CINCO, new cinco(), 1, false);
			sound.add(SEIS, new seis(), 1, false);
			sound.add(SETE, new sete(), 1, false);
			sound.add(OITO, new oito(), 1, false);
			sound.add(NOVE, new nove(), 1, false);
			sound.add(DEZ, new dez(), 1, false);
			
			sound.add(PONTO, new ponto(), 1, false);
			
			sound.add(SUA_PONTUACAO_FOI, new suaPontuacao1(), 1, false);
			sound.add(SUA_PONTUACAO_FOI2, new suaPontuacao2(), 1, false);
			
			sound.add(MUSICA1_FUNDO, new Musica1_fundo(), .3, false);
			sound.add(MUSICA1_CERTA, new Musica1_certa(), 1, false);
			sound.add(MUSICA1_ERRADA, new Musica1_errada(), 1, false);
			sound.add("previewMusica1", new previewMusica1(), 1, false);
			
			sound.add(MUSICA2_FUNDO, new Musica2_fundo(), .3, false);
			sound.add(MUSICA2_CERTA, new Musica2_certa(), 1, false);
			sound.add(MUSICA2_ERRADA, new Musica2_errada(), 1, false);
			sound.add("previewMusica2", new previewMusica2(), 1, false);
			
			sound.add(MUSICA3_FUNDO, new Musica3_fundo(), .3, false);
			sound.add(MUSICA3_CERTA, new Musica3_certa(), 1, false);
			sound.add(MUSICA3_ERRADA, new Musica3_errada(), 1, false);
			sound.add("previewMusica3", new previewMusica3(), 1, false);
			
			sound.add(NOTA_1, new nota1(), 1, false);
			sound.add(NOTA_2, new nota2(), 1, false);
			sound.add(NOTA_3, new nota3(), 1, false);
			sound.add(NOTA_4, new nota4(), 1, false);
			sound.add(NOTA_5, new nota5(), 1, false);
			sound.add(NOTA_6, new nota6(), 1, false);
			
			sound.add(ERROU, new erro(), 1.5, false);
			sound.add(ACERTOUMETADE, new acertoMetade(), 1.5, false);
			sound.add(ACERTOU, new acerto(), 3, false);
			
			soundManager = sound;
		}
		
		public function destroy():void
		{
			super.destroy();
			instance = null;
		}
		
	}

}