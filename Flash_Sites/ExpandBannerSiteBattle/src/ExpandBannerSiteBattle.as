package
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="728", height="300")]
	public class ExpandBannerSiteBattle extends Sprite
	{
		private var _banner:Banner;
		private var _numberOfPhotos:int = 15;
		
		public function ExpandBannerSiteBattle()
		{
			_banner = new Banner();
			this.addChild(_banner);
			_banner.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_banner.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			for(var i:int = 0; i < _numberOfPhotos; i++){
				_banner["olho" + String(i+1)].addEventListener(MouseEvent.CLICK, onClick);
				_banner["olho" + String(i+1)].buttonMode = true;
			}
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			TweenLite.to(_banner._mask, .5, {scaleY:1});
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			TweenLite.to(_banner._mask, .5, {scaleY:3});
		}
		
		private function onClick(event:MouseEvent):void
		{
			if(event.currentTarget.currentFrame == event.currentTarget.totalFrames){
				event.currentTarget.gotoAndStop(1);
			}else{
				event.currentTarget.nextFrame();
			}
		}
	}
}