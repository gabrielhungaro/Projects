package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Jigsaw extends Sprite
	{
		public function Jigsaw()
		{
			inicio();
			
			
		}
		
		private function inicio():void{
			trace("inicio");
			for(var i:int=1; 1<=30; i++){
				var pecas:MovieClip = getChildByName("peca" + i);
				trace(pecas);
				
				//pecas.x = Math.floor(Math.random()*(250) + 300);
				//pecas.y = Math.floor(Math.random()*(250));
				
				pecas.buttonMode = true;
				
				pecas.addEventListener(MouseEvent.MOUSE_DOWN, clicar);
				pecas.addEventListener(MouseEvent.MOUSE_UP, soltar);
				pecas.addEventListener(MouseEvent.MOUSE_DOWN, trazerParaFrente);
				
			}
		}
		
		private function clicar(obj:Event):void{
			obj.target.startDrag();
		}
		
		private function soltar(obj:Event):void{
			obj:target.stopDrag();
			
			var espaco = "espaco" + obj.target.name.substring(4,6);
			
			var alvo = getChildByName(espaco);
			
			if(obj.target.hitTestPoint(alvo.x + 50, alvo.y + 50, true)){
				obj.target.mouseEnabled = false;
				
				obj.target.x=getChildByName(espaco).x;
				obj.target.y=getChildByName(espaco).y;
				
				removeEventListener(MouseEvent.MOUSE_DOWN, clicar);
				removeEventListener(MouseEvent.MOUSE_UP, soltar);
			}
		}
		
		private function trazerParaFrente(obj:MouseEvent):void{
			this.addChild(obj.currentTarget as DisplayObject);
		}
	}
}