package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class EmbCon extends Sprite
	{
		
		[Embed(source="../lib/level1Teste.swf", mimeType="application/octet-stream")]
		private var Level1Class:Class;
		
		public function EmbCon()
		{
			initSwfEmbCon()
		}
		
		private function initSwfEmbCon():void{
			
			var loader:Loader = new Loader();
			loader.loadBytes( new Level1Class() as ByteArray );
			loader.contentLoaderInfo.addEventListener(Event.INIT, onSwfLoaded);
			this.addChild(loader);
		}
		
		private function onSwfLoaded(e:Event):void 
		{
			var mc:MovieClip = e.target.content as MovieClip;
			this.addChild(mc);
		}
		
		private function recursivaDoMal(display:*):void
		{
			trace(display.name);
			trace(display.numChildren)
			
			if(display.getChildAt(0))
				recursivaDoMal(display.getChildAt(0));
		}
		
	}
}