package com.scene
{
	import com.data.Question;
	import com.data.QuizDataInfo;
	import com.globo.sitio.controllers.scene.Scene;
	import com.globo.sitio.engine.debug.Debug;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class LoadingScene extends Scene
	{
		private var urlXML:String = "";
		private var xmlRequest:URLRequest;
		private var xmlLoader:URLLoader;
		private static var quizName:String;
		private static var arrayOfQuestion:Array;
		private static var arrayOfAllQuestion:Array;
		private static var numberOfAlternatives:int;
		private var urlStartScreen:String;
		private var urlQuestionScreen:String;
		private var urlRankingScreen:String;
		
		public function LoadingScene()
		{
			super();
		}
		
		override public function init():void
		{
		}
	}
}