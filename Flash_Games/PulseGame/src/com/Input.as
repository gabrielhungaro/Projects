package com
{
	import flash.ui.Keyboard;

	public class Input
	{
		public static var keyboard1:uint;
		public static var keyboard2:uint;
		public static var keyboard3:uint;
		public static var keyboard4:uint;
		public static var keyboard5:uint;
		public static var keyboard6:uint;
		private var withControl:Boolean;
		
		public function Input(control:Boolean)
		{
			withControl = control;
			if(withControl){
				keyboard1 = Keyboard.W;
				keyboard2 = Keyboard.A;
				keyboard3 = Keyboard.S;
				keyboard4 = Keyboard.D;
				keyboard5 = Keyboard.F;
				keyboard6 = Keyboard.G;
			}else{
				keyboard1 = Keyboard.A;
				keyboard2 = Keyboard.S;
				keyboard3 = Keyboard.D;
				keyboard4 = Keyboard.J;
				keyboard5 = Keyboard.K;
				keyboard6 = Keyboard.L;
			}
		}
	}
}