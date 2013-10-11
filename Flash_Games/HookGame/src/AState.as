package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import citrus.core.IState;
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	public class AState extends State implements IState
	{
		private var box2D:Box2D;
		private var heroBox:Hero;
		public function AState()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			var platform:Platform = new Platform("plat", {x:stage.stageWidth/2, y:760, width:1024, height: 20});
			add(platform);
			
			heroBox = new Hero("Hero", {x:50, y:50, width:30, height:70});
			add(heroBox);
			
			createRandomBox();
			
			setupCamera();
		}
		
		private function createRandomBox():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function setupCamera():void
		{
			view.camera.setUp(heroBox, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), new Point(.2, .2));
		}
	}
}