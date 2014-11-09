package com.scene
{
	import flash.events.Event;
	
	public final class SceneEvent extends Event
	{
		
		public static const ON_SCENE_SELECTED:String = "onSceneSelected";
	
		public var sceneSelected:String;
		
		public function SceneEvent(type:String, sceneSelectedName:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			this.sceneSelected = sceneSelectedName;
			super(type, bubbles, cancelable);
		}
	}
}