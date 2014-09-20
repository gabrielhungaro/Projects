package com
{
	import com.data.DataInfo;
	import com.scene.ChooseScene;
	import com.scene.InitScene;
	import com.scene.RankingScene;
	import com.scene.SceneManager;
	import com.scene.ScenesName;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
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