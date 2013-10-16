package
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	
	import citrus.core.IState;
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Crate;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import nape.constraint.DistanceJoint;
	
	public class AState extends State implements IState
	{
		private var box2D:Box2D;
		private var heroBox:Hero;
		private var numberOfBoxs:int = 12;
		private var worldScale:Number = 30;
		private var distanceJoint:b2DistanceJoint;
		private var isHooked:Boolean;
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
			stage.addEventListener(MouseEvent.MOUSE_DOWN, fireHook);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHook);
			debugDraw();
		}
		
		private function createRandomBox():void
		{
			for (var i:int = 0; i < numberOfBoxs; i++) 
			{
				var crate:Platform = new Platform("box", {x:Math.random()*stage.stageWidth+20,
													y:Math.random()*stage.stageHeight+20,
													width:Math.random()*30+15,
													height:Math.random()*30+15});
				//crate.
				add(crate);
			}
		}
		
		private function setupCamera():void
		{
			view.camera.setUp(heroBox, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), new Point(.2, .2));
		}
		
		private function debugDraw():void
		{
			
		}
		
		protected function fireHook(event:MouseEvent):void
		{
			if(distanceJoint){
				box2D.world.DestroyJoint(distanceJoint);
			}
			box2D.world.QueryPoint(queryCallback, new b2Vec2(mouseX/worldScale, mouseY/worldScale));
		}
		
		private function queryCallback(fixture:b2Fixture):Boolean
		{
			var touchedBody:b2Body = fixture.GetBody();
			if(touchedBody.GetType() == b2Body.b2_staticBody){
				var distanceJointDef:b2DistanceJointDef = new b2DistanceJointDef();
				distanceJointDef.Initialize(heroBox.body, touchedBody, heroBox.body.GetWorldCenter(), new b2Vec2(mouseX/worldScale, mouseY/worldScale));
				distanceJointDef.collideConnected = true;
				distanceJoint = box2D.world.CreateJoint(distanceJointDef) as b2DistanceJoint;
				isHooked = true;
			}
			return false;
		}
		
		protected function releaseHook(event:MouseEvent):void
		{
			if(distanceJoint){
				box2D.world.DestroyJoint(distanceJoint);
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			manageHook();
		}
		
		private function manageHook():void
		{
			if(isHooked){
				heroBox.body.SetAwake(true);
				distanceJoint.SetLength(distanceJoint.GetLength()*.99);
			}
		}
	}
}