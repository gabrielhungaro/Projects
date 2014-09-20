package com.scene
{
	import flash.events.Event;
	
	public final class SceneEvent extends Event
	{
		
		public static const ON_SCENE_SELECTED:String = "onSceneSelected";
		public static const ON_SCENE_QUIT:String = "onSceneQuit";
		public static const ON_EXIT:String = "onExit";
	
		public var sceneSelected:String;
		
		public function SceneEvent(type:String, sceneSelectedName:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.sceneSelected = sceneSelectedName;
			super(type, bubbles, cancelable);
		}
	}
}