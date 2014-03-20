package com
{
	import com.data.QuizDataInfo;
	import com.scene.InitScene;
	import com.scene.LoadingScene;
	import com.scene.QuestionScene;
	import com.scene.RankingScene;
	import com.scene.SceneManager;
	import com.scene.ScenesName;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	
	[SWF(width="500", height="500")]
	public class QuizEngine extends Sprite
	{
		private var _stage:Stage;
		private var _display:Sprite;
		private var _sceneManager:SceneManager;
		private static var appWidth:Number = 500;
		private static var appHeight:Number = 500;
		
		public function QuizEngine()
		{
			initSceneManager();
			var quizData:QuizDataInfo = QuizDataInfo.getInstance();
			quizData.setAppWidth(stage.stageWidth)
			quizData.setAppHeight(stage.stageHeight)
			quizData.loadXMLComplete.add(completeLoadXML);
			quizData.initLoad();
		}
		
		private function initSceneManager():void
		{
			trace(stage.width);
			_stage = stage;
			_display = new Sprite();
			trace(_stage.stageHeight);
			this.addChild(_display);
						
			_sceneManager = new SceneManager(_display);
			_sceneManager.add(ScenesName.LOADING_SCENE, new LoadingScene(), new Point(0,0));
			_sceneManager.add(ScenesName.INIT_SCENE, new InitScene(), new Point(0,0));
			_sceneManager.add(ScenesName.QUESTION_SCENE, new QuestionScene(), new Point(0,0));
			_sceneManager.add(ScenesName.RANKING_SCENE, new RankingScene(), new Point(0,0));
			_sceneManager.changeScene(ScenesName.LOADING_SCENE);
		}
		
		private function completeLoadXML():void
		{
			_sceneManager.changeScene(ScenesName.INIT_SCENE);
		}
	}
}