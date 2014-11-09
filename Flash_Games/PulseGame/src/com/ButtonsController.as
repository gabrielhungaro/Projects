package com
{
	import com.greensock.TweenMax;
	
	import net.eriksjodin.arduino.Arduino;

	public class ButtonsController
	{
		public static var arduino:Arduino;
		private static var withControl:Boolean;
		
		public function ButtonsController(arduino:Arduino)
		{
			ButtonsController.arduino = arduino;
		}
		
		public static function earthQuakeButton(button:int, timeVibrating:Number):void
		{
			if(withControl){
				arduino.writeDigitalPin(button, 1);
				TweenMax.delayedCall(timeVibrating-0.1, function pararVibracao():void{arduino.writeDigitalPin(button, 0)});//, [button]);
			}
		}
		
		public static function setControl(value:Boolean):void
		{
			withControl = value;
		}
	}
}