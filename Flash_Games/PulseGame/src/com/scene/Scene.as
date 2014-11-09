////////////////////////////////////////////////////////////////////////////////
//Code stub generated with:
//                                Crocus Modeller
//                      Robust UML editor for AS3 & Flex devs.
//                             http://CrocusModeller.com
//
////////////////////////////////////////////////////////////////////////////////


package com.scene {
	import com.Pulse;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * com.globo.sitio.jogos.doutorCaramujo.scene.Scene
	 *
	 * @author Gabriel Hungaro
	 */
	public class Scene extends Sprite{
		///////////////////////
		// PROPERTIES
		///////////////////////
		
		public var sceneManager:SceneManager;
		private var _stage:Stage;
		
		///////////////////////
		// METHODS
		///////////////////////
		private var main:Pulse;
		private var asset:MovieClip;
		
		public function init():void {
			
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
		
		protected function gotoScene(sceneName:String):void{
			if(sceneName == null && sceneName == "")
				throw new Error("O valor da scene nao pode ser nulo");
			
			this.dispatchEvent(new SceneEvent(SceneEvent.ON_SCENE_SELECTED, sceneName))
		}
		
		
		public function setAsset(value:MovieClip):void{ 
			asset = value;
		}
		
		public function getAsset():MovieClip{ 
			return asset;
		}

		public function setName(value:String):void
		{
			this.name = value;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function setManagerRef(value:SceneManager):void
		{
			sceneManager = value;
		}
		
		public function setMainReference(value:Pulse):void
		{
			main = value;
		}
		
		public function getMainReference():Pulse
		{
			return main;
		}
	}
}