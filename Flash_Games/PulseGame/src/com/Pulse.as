package com
{
	import com.greensock.TweenLite;
	import com.scene.SceneManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import net.eriksjodin.arduino.Arduino;
	import net.eriksjodin.arduino.events.ArduinoEvent;
	
	[SWF(frameRate="24",height="720",width="1280")]
	
	public class Pulse extends Sprite
	{
		private var display:Sprite = new Sprite();
		private var sceneManager:SceneManager;
		private var output:Output;
		private var debugMode:Boolean = true;
		private var withControl:Boolean = false;
		
		public var facebookUserClass:FacebookUserClass;
		
		public function Pulse()
		{
			/*Security.loadPolicyFile("http://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("https://graph.facebook.com/crossdomain.xml");
			Security.loadPolicyFile("http://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile("https://profile.ak.fbcdn.net/crossdomain.xml");
			Security.loadPolicyFile('http://fbcdn-profile-a.akamaihd.net/crossdomain.xml');
			Security.loadPolicyFile('https://fbcdn-profile-a.akamaihd.net/crossdomain.xml');
			Security.loadPolicyFile('http://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml');
			Security.loadPolicyFile('https://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml');
			Security.loadPolicyFile('https://fbcdn-sphotos-a.akamaihd.net/crossdomain.xml');
			//Security.loadPolicyFile('http://douglasmendes.com/capricho/crossdomain.xml');
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");*/
			
			
			this.addChild(display);
			this.sceneManager = new SceneManager(display, this);
			//Mouse.hide();
			output = new Output();
			output.x = 660;
			output.y = 5;
			//this.addChild(output);
			
			
			this.sceneManager.setOutput(output.outputTxt);
			this.sceneManager.setControl(withControl);
			
			//Inicia Arduino
			startArduino();
			
			//initFacebook();
			trace(display.x, display.y);
		}
		
		private function initFacebook():void
		{
			//output.outputTxt.appendText("\n [ initFacebook ] - ");
			
			//facebookUserClass = new FacebookUserClass();
			//facebookUserClass.init("376649895757159", "f5ad9a1415bab8a6ed5b8e1743fb86d3", true, outputTxt);
			//facebookUserClass.init("479922798726914", "934f7055e6d22e6d1dac1867a210d901", false, output.outputTxt);
			//facebookUserClass.setPermissions("email, publish_actions, publish_stream");
			//facebookUserClass.activateCallBackFunctions(callBackInit, callBackUserLogin);
		}
		
		
		
		//ARDUINO////
		private function startArduino():void
		{
			if(withControl){
				/*this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);*/
				
				// connect to a serial proxy on port 5331
				arduino = new Arduino("127.0.0.1", 5331);
				
				// listeners for connection 
				arduino.addEventListener(Event.CONNECT,onSocketConnect); 
				arduino.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
				
				// listen for firmware (sent on startup)
				arduino.addEventListener(ArduinoEvent.FIRMWARE_VERSION, onReceiveFirmwareVersion);
				
				trace("Starting Arduino");
			}else{
				this.sceneManager.setControl(withControl);
				new Input(withControl);
			}
		}		
		
		
		public var arduino:Arduino;
		
		private var defaultPinConfig:Array = new Array(
			null,		// Pin 0   null (RX da arduino)
			null,		// Pin 1   null (TX da arduino)
			'digitalOut',  // Pin 2  Botao 1 
			'digitalOut',  // Pin 3 = Botao 2
			'digitalOut',  // Pin 4 = Botao 3
			'digitalOut',  // Pin 5 = Botao 4
			'digitalOut',  // Pin 6 = Botao 5
			'digitalOut',  // Pin 7 = Botao 6
			null,  // Pin 8   
			null,  // Pin 9 
			null,  // Pin 10  
			null,  // Pin 11  
			null,  // Pin 12  
			null  // Pin 13 led da arduino
		);
		
		/*protected function onKeyDown(event:KeyboardEvent):void
		{
			//a.writeDigitalPin(<pin number>, <0 or 1>);
			if(event.keyCode == Keyboard.NUMBER_1)
				arduino.writeDigitalPin(2, 1); //Pin 2 = Botao 1 | Mode: 1 = HIGH = Tremendo
			
			if(event.keyCode == Keyboard.NUMBER_2)
				arduino.writeDigitalPin(3, 1);
			
			if(event.keyCode == Keyboard.NUMBER_3)
				arduino.writeDigitalPin(4, 1);
			
			if(event.keyCode == Keyboard.NUMBER_4)
				arduino.writeDigitalPin(5, 1);
			
			if(event.keyCode == Keyboard.NUMBER_5)
				arduino.writeDigitalPin(6, 1);
			
			if(event.keyCode == Keyboard.NUMBER_6)
				arduino.writeDigitalPin(7, 1);
			
			trace("Apertei o botao: "+event.keyCode);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.NUMBER_1)
				arduino.writeDigitalPin(2, 0); //Pin 2 = Botao 1 | Mode: 0 = Low = Não Tremendo
			
			if(event.keyCode == Keyboard.NUMBER_2)
				arduino.writeDigitalPin(3, 0);
			
			if(event.keyCode == Keyboard.NUMBER_3)
				arduino.writeDigitalPin(4, 0);
			
			if(event.keyCode == Keyboard.NUMBER_4)
				arduino.writeDigitalPin(5, 0);
			
			if(event.keyCode == Keyboard.NUMBER_5)
				arduino.writeDigitalPin(6, 0);
			
			if(event.keyCode == Keyboard.NUMBER_6)
				arduino.writeDigitalPin(7, 0);
			
			trace("Soltei o botao: "+event.keyCode);
		}*/
		
		// == Inicia Conexao ( Nao modificar) ==================================
		
		private function errorHandler(errorEvent:IOErrorEvent):void 
		{
			trace("- O Proxy não foi iniciado.");
			withControl = false;
			this.sceneManager.setControl(withControl);
			new Input(withControl);
		}
		
		private function onSocketConnect(e:Object):void 
		{	trace("- Conexão com Proxy estabelecida. Aguarde conexao arduino.");
			arduino.requestFirmwareVersion();	
		}
		
		private function onReceiveFirmwareVersion(e:ArduinoEvent):void 
		{   
			withControl = true;
			trace("- Arduino Conectada"); 		
			for(var i:int = 2; i<defaultPinConfig.length; i++)
				if(defaultPinConfig[i] == "digitalOut") arduino.setPinMode(i, Arduino.OUTPUT);
			
			trace("Pinos configurados");
			
			arduino.enableDigitalPinReporting();
			
			new ButtonsController(arduino);
			ButtonsController.setControl(withControl);
			this.sceneManager.setControl(withControl);
			new Input(withControl);
			
			this.sceneManager.currentScene.getAsset()["feedbackArduino"].gotoAndStop(2);
		}
		
		
		//Facebook Stuff
		private function callBackInit(message:String, result:Object):void
		{
			//output.outputTxt.appendText("\n [ CALLBACK_INIT ] - " + message);
			trace("callBackInit: " + message);
			if (message == "Success")
			{
				//TweenLite.delayedCall(1, tweenCallLoadUserInfo);
			}
			else
			{
				TweenLite.delayedCall(1, tweenCallLoadLogin);
			}
		}
		
		private function tweenCallLoadLogin():void {
			facebookUserClass.loadLogin();
		}
		
		private function tweenCallLoadUserInfo():void {
			facebookUserClass.loadUserInfo();
		}
		
		private function callBackUserLogin(message:String, result:Object):void
		{
			trace("callBackUserLogin: " + message);
			if (message == "Success")
			{
				facebookUserClass.init("479922798726914", "934f7055e6d22e6d1dac1867a210d901");
			}else {
				
			}
		}
		
		/*private function callBackUserInfo(message:String, result:Object):void
		{
			trace("callBackUserInfo: " + message);
			if (message == "Success")
			{
				var usuario:Usuario = new Usuario(outputTxt);
				usuario.registerUser(facebookUserClass.getUserID(), facebookUserClass.getUserName(), facebookUserClass.getUserBirthdaySegmented(), facebookUserClass.getUserCity(), facebookUserClass.getUserSex(), facebookUserClass.getUserEmail());
				TweenLite.delayedCall(1, tweenCallLoadUserAlbum);
			}
		}*/
	}
}