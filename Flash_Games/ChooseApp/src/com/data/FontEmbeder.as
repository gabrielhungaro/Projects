package com.data
{
	import flash.text.Font;
	import flash.text.TextFormat;

	public class FontEmbeder
	{
		[Embed (source="../../../assets/fonts/BebasNeueBold.otf", fontFamily="BebasNeueBold", fontName="BebasNeueBold")]
		private static var _bebasNeueBold:Class;
		[Embed(source="../../../assets/fonts/BebasNeueRegular.otf", fontFamily="BebasNeueRegular", fontName="BebasNeueRegular")]
		private static var _bebasNeueRegular:Class;
		[Embed(source="../../../assets/fonts/BebasNeueBook.otf", fontFamily="BebasNeueBook", fontName="BebasNeueBook")]
		private static var _bebasNeueBook:Class;
		
		public static const FONT_NAME_BEBAS_REGULAR:String = "bebasNeueRegular";
		public static const FONT_NAME_BEBAS_BOLD:String = "bebasNeueBold";
		public static const FONT_NAME_BEBAS_BOOK:String = "bebasNeueBook";
		
		public function FontEmbeder()
		{
		}
		
		public static function getTextFormatInstanceByFontName( name:String, fontSize:int = 20 ):TextFormat
		{
			var font:Font = getFontByName( name );
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = font.fontName;
			textFormat.size = fontSize;
			//textFormat.bold = true;
			
			return textFormat;
		}
		
		private static function getFontByName(fontName:String):Font
		{
			var font:Font;
			switch(fontName)
			{
				case FONT_NAME_BEBAS_REGULAR:
				{
					font = new _bebasNeueRegular() as Font;
					break;
				}
				case FONT_NAME_BEBAS_BOLD:
				{
					font = new _bebasNeueBold() as Font;
					break;
				}
				case FONT_NAME_BEBAS_BOOK:
				{
					font = new _bebasNeueBook() as Font;
					break;
				}
			}
			return font;
		}
	}
}