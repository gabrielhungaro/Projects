package com.songs
{
	import com.events.SongsEvents;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Song extends Sprite
	{
		private var asset:MovieClip;
		private var onCompleteOutTween:Object;
		
		public function Song()
		{
			/*this.scaleX = .5;
			this.scaleY = .5;*/
			/*this.x = Math.floor(Math.random()*700)+50;
			this.y = Math.floor(Math.random()*500)+50;*/
		}
		
		public function init():void
		{
			//TweenLite.to(this.asset.timer, 4, {frame:60, onComplete:onCompleteTimerTween});
		}
		
		/*private function onCompleteTimerTween():void
		{
			this.dispatchEvent(new SongsEvents(SongsEvents.ON_END_TIMER, this));
		}
		
		public function out():void
		{
			TweenLite.to(this.asset.timer, 4, {alpha:0, onComplete:onCompleteOutTween});
		}
		
		public function gotoCorrect():void
		{
			this.getAsset().gotoAndStop("correct");
			TweenLite.to(this, .5, {scaleX:1.1, scaleY:1.1, onComplete:onCompleteScaleIn});
		}
		
		public function gotoWrong():void
		{
			this.getAsset().gotoAndStop("wrong");
			TweenLite.to(this, .5, {scaleX:1.1, scaleY:1.1, onComplete:onCompleteScaleIn});
		}
		
		private function onCompleteScaleIn():void
		{
			TweenLite.to(this, .5, {scaleX:0, scaleY:0, onComplete:onCompleteScaleOut()});
		}
		
		private function onCompleteScaleOut():void
		{
			this.destroy();
			this.dispatchEvent(new SongsEvents(SongsEvents.ON_OUT_SONG,this));
		}
		
		public function destroy():void
		{
			TweenLite.killTweensOf(this);
			asset = null;
		}*/
		
		public function setAsset(value:MovieClip):void
		{
			asset = value;
		}
		
		/*public function getAsset():MovieClip
		{
			return asset;
		}*/
	}
}