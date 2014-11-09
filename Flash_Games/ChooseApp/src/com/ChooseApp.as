package com
{
	import com.data.DataInfo;
	import com.scene.ChooseScene;
	import com.scene.InitScene;
	import com.scene.RankingScene;
	import com.scene.SceneManager;
	import com.scene.ScenesName;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	[SWF(width="620", height="1227")]
	public class ChooseApp extends Sprite
	{
		private var _sceneManager:SceneManager;
		private var _display:Sprite;
		
		public function ChooseApp()
		{
			initSceneManager();
			var dataInfo:DataInfo = DataInfo.getInstance();
			dataInfo.setAppWidth(stage.stageWidth)
			dataInfo.setAppHeight(stage.stageHeight)
			dataInfo.loadXMLComplete.add(completeLoadXML);
			dataInfo.initLoad();
			
			/*createCara("teste1", "testeDescription1", "url1");
			createCara("teste2", "testeDescription2", "url2");
			createCara("teste3", "testeDescription3", "url3");
			createCara("teste4", "testeDescription4", "url4");*/
			//getQuiz("1");
			
			//createQuiz();
		}
		
		private function createCara(_name:String, _description:String, _urlPhoto:String):void
		{
			var urlreq:URLRequest = new URLRequest ("http://edg-1-1242075393.us-east-1.elb.amazonaws.com/quizcopa/processa_requests.php");
			urlreq.method = URLRequestMethod.POST; 
			
			var urlvars:URLVariables = new URLVariables(); 
			urlvars.metodo = new String("novo_participante");
			urlvars.participante = new String(_name);
			urlvars.descricao = new String(_description);
			urlvars.foto = new String(_urlPhoto);
			
			var loader:URLLoader = new URLLoader (urlreq); 
			loader.addEventListener(Event.COMPLETE, completed); 
			loader.dataFormat = URLLoaderDataFormat.TEXT; 
			loader.load(urlreq); 
		}
		
		private function createQuiz():void
		{
			var urlreq:URLRequest = new URLRequest ("http://edg-1-1242075393.us-east-1.elb.amazonaws.com/quizcopa/processa_requests.php");
			urlreq.method = URLRequestMethod.POST; 
			
			var urlvars:URLVariables = new URLVariables(); 
			urlvars.metodo = new String("novo_quiz");
			urlvars.nome = new String("Musas");
			urlvars.descricao = new String("Quiz Musas");
			
			urlreq.data = urlvars;
			
			var loader:URLLoader = new URLLoader (urlreq); 
			loader.addEventListener(Event.COMPLETE, completed); 
			loader.dataFormat = URLLoaderDataFormat.TEXT; 
			loader.load(urlreq); 
		}
		
		private function getQuiz(quizId:String):void
		{
			var urlreq:URLRequest = new URLRequest ("http://edg-1-1242075393.us-east-1.elb.amazonaws.com/quizcopa/processa_requests.php");
			urlreq.method = URLRequestMethod.POST; 
			
			var urlvars:URLVariables = new URLVariables(); 
			urlvars.metodo = new String("todos_participantes");
			//urlvars.quiz = new String(quizId);
			
			urlreq.data = urlvars;
			
			var loader:URLLoader = new URLLoader (urlreq); 
			loader.addEventListener(Event.COMPLETE, completed); 
			loader.dataFormat = URLLoaderDataFormat.TEXT; 
			loader.load(urlreq); 
		}
		
		public function completed (event:Event):void{
			//resptxt.text = variables.done;
			
			trace ( event.target.data );
		}
		
		private function initSceneManager():void
		{
			_display = new Sprite();
			this.addChild(_display);
			_sceneManager = new SceneManager(_display);
			_sceneManager.add(ScenesName.INIT_SCENE, new InitScene(), new Point(0,0));
			_sceneManager.add(ScenesName.CHOOSE_SCENE, new ChooseScene(), new Point(0,0));
			_sceneManager.add(ScenesName.RANKING_SCENE, new RankingScene(), new Point(0,0));
			//_sceneManager.changeScene(ScenesName.INIT_SCENE);
		}
		
		private function completeLoadXML():void
		{
			_sceneManager.changeScene(ScenesName.CHOOSE_SCENE);
		}
	}
}