package
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundManagerEnglish
	{
		public static var instance:SoundManagerEnglish;
		public static var okToCreate:Boolean;
		
		public static var cowSound:CowSound;
		public static var dogSound:DogSound;
		public static var birdSound:BirdSound;
		public static var pigSound:PigSound;
		public static var chickenSound:ChickenSound;
		public static var horseSound:HorseSound;
		public static var sheepSound:SheepSound;
		public static var correctSound:CorrectSound;
		public static var wrongSound:ErrorSound;
		
		public static var WRONG:String = "wrong";
		public static var CORRECT:String = "correct";
		
		public static var soundTransform:SoundTransform;
		public static var channel:SoundChannel;
		public static var soundsArray:Array = new Array();
		private static var isMuted:Boolean;
		
		public function SoundManagerEnglish()
		{
			if(okToCreate == false){
				trace("SoundManager não pode ter mais de duas instancias");
			}else{
				addSound();
			}
		}
		
		public static function getInstance():SoundManagerEnglish
		{
			if(instance == null){
				okToCreate = true;
				instance = new SoundManagerEnglish();
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
			
			horseSound = new HorseSound();
			horseSound.name = "horse";
			soundsArray.push(horseSound);
			sheepSound = new SheepSound();
			sheepSound.name = "sheep";
			soundsArray.push(sheepSound);
			cowSound = new CowSound();
			cowSound.name = "cow";
			soundsArray.push(cowSound);
			birdSound = new BirdSound();
			birdSound.name = "bird";
			soundsArray.push(birdSound);
			pigSound = new PigSound();
			pigSound.name = "pig";
			soundsArray.push(pigSound);
			dogSound = new DogSound();
			dogSound.name = "dog";
			soundsArray.push(dogSound);
			chickenSound = new ChickenSound();
			chickenSound.name = "chicken";
			soundsArray.push(chickenSound);
			correctSound = new CorrectSound();
			correctSound.name = "correct";
			soundsArray.push(correctSound);
			wrongSound = new ErrorSound();
			wrongSound.name = "wrong";
			soundsArray.push(wrongSound);
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