package
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.data.TweenMaxVars;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Ease;
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	[SWF(width="250",height="300")]
	
	public class SiteBattleRotateBanner extends Sprite
	{
		private var _banner:Banner;
		private var _resetTimer:Timer;
		TweenPlugin.activate([FramePlugin]);
		
		public function SiteBattleRotateBanner()
		{
			_resetTimer = new Timer(5000);
			_resetTimer.addEventListener(TimerEvent.TIMER, completeTimer);
			_banner = new Banner();
			this.addChild(_banner);
			//changeFrame(3);
			TweenMax.to(_banner.textMc, 2, {frame:_banner.textMc.totalFrames, onComplete:hideText});
		}
		
		private function changeFrame(frame:int = 0):void
		{
			if(frame == 0){
				if(_banner.currentFrame == _banner.totalFrames){
					_banner.gotoAndStop(1);
				}else{
					_banner.nextFrame();
				}
			}else{
				_banner.gotoAndStop(frame);
			}
			_banner.buttonMode = false;
			var _frame:int = _banner.currentFrame;
			switch(_frame){
				case 1:
					TweenMax.to(_banner.textMc, 2, {frame:_banner.textMc.totalFrames, onComplete:hideText});
					break;
				case 2:
					TweenMax.to(_banner.textMc, 2, {frame:_banner.textMc.totalFrames, onComplete:hideText});
					break;
				case 3:
					showText();
					break;
				case 4:
					_banner.buttonMode = true;
					_resetTimer.start();
					moveHand();
					break;
			}
		}
		
		protected function completeTimer(event:TimerEvent):void
		{
			_resetTimer.stop();
			changeFrame();
		}
		
		private function hideText():void
		{
			TweenMax.to(_banner.textMc, 2, {frame:1, delay:1, onComplete:changeFrame});
		}
		
		private function moveHand():void
		{
			TweenLite.to(_banner.hand, .5, {y:_banner.hand.y - 10, onComplete:
				function complete(){ 
					TweenLite.to(_banner.hand, .5, {y:_banner.hand.y + 10, onComplete:moveHand})
				}
			});
			
		}
		
		private function showText():void
		{
			_banner.textMc.scaleX = _banner.textMc.scaleY = 0;
			TweenLite.to(_banner.textMc, 1, {scaleX:1, scaleY:1, ease:Elastic.easeOut, onComplete:shakeText});
		}
		
		private function shakeText():void
		{
			TweenLite.to(_banner.textMc, 1, {scaleX:0, scaleY:0, delay:1, ease:Elastic.easeIn, onComplete:changeFrame});
		}
	}
}