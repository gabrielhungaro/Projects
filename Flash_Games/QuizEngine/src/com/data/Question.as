package com.data {
	import flash.display.Sprite;
	
	/**
	 *
	 * @author Gabriel Hungaro
	 */
	public class Question extends Sprite{
		///////////////////////
		// PROPERTIES
		///////////////////////
		
		private var question:String;
		private var correctAlternative:String;
		private var numberOfAlternatives:int;
		private var stringOfAlternatives:String;
		private var arrayOfAlternativesLetters:Array;
		private var arrayOfAlternatives:Array;
		
		
		///////////////////////
		// METHODS
		///////////////////////
		
		public function Question() 
		{
			stringOfAlternatives = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			arrayOfAlternativesLetters = new Array();
			arrayOfAlternatives = new Array();
			
		}
		
		public function init():void
		{
			for (var i:int = 1; i <= numberOfAlternatives; i++) 
			{
				arrayOfAlternativesLetters.push(stringOfAlternatives.charAt(i-1));
				arrayOfAlternatives.push("");
			}
		}
		
		public function setQuestion(value:String):void
		{
			question = value;
		}
		
		public function getQuestion():String
		{
			return question;
		}
		
		public function setCorrectAlternative(value:String):void
		{
			correctAlternative = value;
		}
		
		public function getCorrectAlternative():String
		{
			return correctAlternative;
		}
		
		public function setAlternative(letter:int, value:String):void
		{
			arrayOfAlternatives[letter] = value;
			/*for (var i:int = 0; i < arrayOfAlternativesLetters.length; i++) 
			{
				if(letter == arrayOfAlternativesLetters[i]){
					arrayOfAlternatives[i] = value;
				}
			}*/
			
			//this["alternative"+letter] = value;
		}
		
		public function getAlternative(letter:String):String
		{
			for (var i:int = 0; i < arrayOfAlternativesLetters.length; i++) 
			{
				if(letter == arrayOfAlternativesLetters[i]){
					return arrayOfAlternatives[i];
				}
			}
			return null;
			//return this["alternative"+letter];
		}
		
		public function getAlternativeArray():Array
		{
			return arrayOfAlternatives;
		}
		
		public function getAlternativeLettersArray():Array
		{
			return arrayOfAlternativesLetters;
		}
		
		public function setNumberOfAlternatives(value:int):void
		{
			numberOfAlternatives = value;
		}
	}
}