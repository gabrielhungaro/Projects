package
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundManagerMath
	{
		public static var instance:SoundManagerMath;
		public static var okToCreate:Boolean;
		
		public static var backgroundSound:MathematicBackgroundSound;
		
		public static var BACKGROUND:String = "background";
		
		public static var soundTransform:SoundTransform;
		public static var channel:SoundChannel;
		public static var soundsArray:Array = new Array();
		private static var isMuted:Boolean;
		
		public function SoundManagerMath()
		{
			if(okToCreate == false){
				trace("SoundManager não pode ter mais de duas instancias");
			}else{
				addSound();
			}
		}
		
		public static function getInstance():SoundManagerMath
		{
			if(instance == null){
				okToCreate = true;
				instance = new SoundManagerMath();
				okToCreate = false;
			}
			return instance;
		}
		
		public function addSound():void
		{
			soundTransform = new SoundTransform();
			channel = new SoundChannel();
			soundTransform.volume = .1;
			channel.soundTransform = soundTransform;
			
			backgroundSound = new MathematicBackgroundSound();
			backgroundSound.name = "background";
			soundsArray.push(backgroundSound);
		}
		
		public static function playByName(soundName:String):void
		{
			if(!isMuted){
				for (var i:int = 0; i < soundsArray.length; i++) 
				{
					if(soundsArray[i]){
						if(soundsArray[i].name == soundName){
							channel.stop();
							channel = soundsArray[i].play();
							channel.soundTransform = soundTransform;
						}
					}
				}
			}
		}
		
		public static function stopAll():void
		{
			channel.stop();
		}
		
		public static function setIsMuted(value:Boolean):void
		{
			isMuted = value
		}
	}
}