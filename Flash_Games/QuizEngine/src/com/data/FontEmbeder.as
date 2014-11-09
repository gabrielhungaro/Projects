package com.data
{
	import flash.text.Font;
	import flash.text.TextFormat;

	public class FontEmbeder
	{
		[Embed (source="../../../assets/fonts/LatoBlack.otf", fontFamily="LatoBlack", fontName="LatoBlack")]
		private static var _latoBlack:Class;
		[Embed(source="../../../assets/fonts/LatoBold.otf", fontFamily="LatoBold", fontName="LatoBold")]
		private static var _latoBold:Class;
		[Embed(source="../../../assets/fonts/LatoRegular.otf", fontFamily="LatoRegular", fontName="LatoRegular")]
		private static var _latoRegular:Class;
		[Embed(source="../../../assets/fonts/GloberBoldFree.otf", fontFamily="GloberBoldFree", fontName="GloberBoldFree")]
		private static var _globerBoldFree:Class;
		[Embed(source="../../../assets/fonts/GloberThinFree.otf", fontFamily="GloberThinFree", fontName="GloberThinFree")]
		private static var _globerThinFree:Class;
		
		public static const FONT_NAME_LATO_REGULAR:String = "LatoRegular";
		public static const FONT_NAME_LATO_BOLD:String = "LatoBold";
		public static const FONT_NAME_LATO_BLACK:String = "LatoBlack";
		public static const FONT_NAME_GLOBER_BOLD_FREE:String = "GloberBoldFree";
		public static const FONT_NAME_GLOBER_THIN_FREE:String = "GloberThinFree";
		
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
				case FONT_NAME_LATO_REGULAR:
				{
					font = new _latoRegular() as Font;
					break;
				}
				case FONT_NAME_LATO_BOLD:
				{
					font = new _latoBold() as Font;
					break;
				}
				case FONT_NAME_LATO_BLACK:
				{
					font = new _latoBlack() as Font;
					break;
				}
				case FONT_NAME_GLOBER_BOLD_FREE:
				{
					font = new _globerBoldFree() as Font;
					break;
				}
				case FONT_NAME_GLOBER_THIN_FREE:
				{
					font = new _globerThinFree() as Font;
					break;
				}
			}
			return font;
		}
	}
}