////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////


package com.scene {
	import com.data.DataInfo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * com.globo.sitio.jogos.doutorCaramujo.scene.Scene
	 *
	 * @author Gabriel Hungaro
	 * 
	 * @update Douglas Mendes Barreto
	 * 
	 * 
	 * @version 1.1
	 */
	public class Scene extends Sprite{
		///////////////////////
		// PROPERTIES
		///////////////////////
		private var standBy:Boolean = true;	
		private var isInitialized:Boolean = false;
		private var _sceneManager:SceneManager;
		public var dataInfo:DataInfo = DataInfo.getInstance();
		public var backgroundContainer:Sprite;
		
		///////////////////////
		// METHODS
		///////////////////////
		public function Scene():void{}
		public function quit():void{
			this.dispatchEvent(new SceneEvent(SceneEvent.ON_EXIT, this.name));
		}
		public function init():void {
			standBy = false;
			isInitialized = true;
		}
		
		public function continueSceneProcess():void{
			standBy = false;
		}
		
		public function stopSceneProcess():void{
			standBy = true;
		}
		
		public function destroy():void {
			//TODO
		}

		public function update():void {
			//TODO
		}

		public function add(object:DisplayObject):void {
			//TODO
		}

		public function remove(object:DisplayObject):void {
			//TODO
		}
		
		public function gotoScene(sceneName:String):void{
			if(sceneName == null && sceneName == "")
				throw new Error("O valor da scene nao pode ser nulo");
			
			this.dispatchEvent(new SceneEvent(SceneEvent.ON_SCENE_SELECTED, sceneName))
		}
		
		protected function onExitGame(sceneName:String):void{
			this.dispatchEvent(new SceneEvent(SceneEvent.ON_EXIT, sceneName));
		}
		
		public function getAsset():Sprite{ 
			return null;
		}
		public function setName(value:String):void
		{
			this.name = value;
		}
		
		public function getName():String
		{
			return this.name;
		}

		public function getStandBy():Boolean
		{
			return standBy;
		}

		public function isSceneInitialized():Boolean
		{
			return isInitialized;
		}
		
		public function setIsSceneInitialized(value:Boolean):void
		{
			isInitialized = value;
		}
		
		public function setManagerReference(value:SceneManager):void
		{
			_sceneManager = value;
		}

		public function getManagerReference():SceneManager
		{
			return _sceneManager;
		}
	}
}