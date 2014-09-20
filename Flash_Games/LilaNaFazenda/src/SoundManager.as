package
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundManager
	{
		public static var instance:SoundManager;
		public static var okToCreate:Boolean;
		
		public static var initSound:SoundInitScreen;
		public static var creditsSound:SoundCredits;
		public static var initChannel:SoundChannel;
		public static var creditsChannel:SoundChannel;
		public static var soundTransform:SoundTransform;
		private static var isMuted:Boolean;
		
		public function SoundManager()
		{
			if(okToCreate == false){
				trace("SoundManager não pode ter mais de duas instancias");
			}else{
				addSound();
			}
		}
		
		public static function getInstance():SoundManager
		{
			if(instance == null){
				okToCreate = true;
				instance = new SoundManager();
				okToCreate = false;
			}
			return instance;
		}
		
		public function addSound():void
		{
			soundTransform = new SoundTransform();
			soundTransform.volume = .1;
			
			initSound = new SoundInitScreen();
			initChannel = new SoundChannel();
			initChannel = initSound.play();
			initChannel.soundTransform = soundTransform;
			initChannel.stop();
			
			creditsSound = new SoundCredits();
			creditsChannel = new SoundChannel();
			creditsChannel = creditsSound.play();
			creditsChannel.soundTransform = soundTransform;
			creditsChannel.stop();
		}
		
		public static function playInit():void
		{
			if(!isMuted){
				creditsChannel.stop();
				initChannel = initSound.play();
				initChannel.soundTransform = soundTransform;
			}
		}
		
		public static function playCredits():void
		{
			if(!isMuted){
				initChannel.stop();
				creditsChannel = creditsSound.play();
				creditsChannel.soundTransform = soundTransform;
			}
		}
		
		public static function stopAll():void
		{
			creditsChannel.stop();
			initChannel.stop();
		}
		
		public static function setIsMuted(value:Boolean):void
		{
			isMuted = value;
			if(value){
				creditsChannel.stop();
				initChannel.stop();
			}else{
				playInit();
			}
		}
	}
}