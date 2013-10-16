package com
{
	import com.levels.ALevel;
	
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.utils.LevelManager;
	
	[SWF(width=800,height=600)]
	public class Enlaced extends CitrusEngine
	{
		Security.allowDomain("*");
		
		public function Enlaced()
		{
			
			//var mc:Level1 = new Level1();
			//level1State = new Level1State(mc, debugSprite);
			//state = level1State;
			
			levelManager = new LevelManager(ALevel);
			levelManager.applicationDomain = ApplicationDomain.currentDomain; 
			levelManager.onLevelChanged.add(_onLevelChanged);
			levelManager.levels = [[ALevel, "../bin/levels/level1.swf"]/*, [Level2State, "../lib/level2Teste.swf"], [Level3State, "../lib/level3Teste.swf"], [Level4State, "../lib/level4Teste.swf"]*/];
			levelManager.gotoLevel();
		}
		
		private function _onLevelChanged(lvl:ALevel):void {
			
			state = lvl;
			
			lvl.lvlEnded.add(_nextLevel);
			lvl.restartLevel.add(_restartLevel);
		}
		
		private function _nextLevel():void {
			
			levelManager.nextLevel();
		}
		
		private function _restartLevel():void {
			
			state = levelManager.currentLevel as IState;
		}
	}
}