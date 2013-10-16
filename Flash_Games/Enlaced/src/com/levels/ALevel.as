package com.levels
{
	import com.hero.AHero;
	import com.objects.NextLevel;
	import com.objects.PrevLevel;
	import com.objects.Spike;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	import org.osflash.signals.Signal;
	
	public final class ALevel extends State
	{
		private var _levelSWF:MovieClip;
		private var box2D:Box2D;
		private var hero1:AHero;
		private var hero2:AHero;
		
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		
		protected var objectsArray:Array;
		
		public function ALevel(levelSWF:MovieClip = null)
		{
			super();
			this._levelSWF = levelSWF;
			lvlEnded = new Signal();
			restartLevel = new Signal();
			objectsArray = [Platform, Spike/*, Spike2, MyHero, Torch, Bat, Flashlight, Stack*/, NextLevel, PrevLevel]
		}
		
		override public function initialize():void
		{
			super.initialize();
			_ce = CitrusEngine.getInstance();
			
			//viewRoot = this._realState.view as SpriteView;
			
			box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			//addBackground();
			
			ObjectMaker2D.FromMovieClip(_levelSWF);
			
			createHero();
			setUpCamera();
			
			//addUpPart();
		}
		
		public function setUpCamera():void
		{
			trace(_levelSWF.width, _levelSWF.height);
			view.camera.setUp(hero1, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, _levelSWF.width, _levelSWF.height), new Point(.25, .05));
			//view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			view.camera.allowZoom = true;
			//view.camera.boundsMode = ACitrusCamera.BOUNDS_MODE_ADVANCED;
			//view.camera.restrictZoom = true;
			
			//LIBERA A ROTAÇÃO DA CAMERA
			view.camera.allowRotation = true;
		}
		
		public function createHero():void
		{
			hero1 = getObjectByName("Hero1") as AHero;
			hero1.name = "Hero1";
			
			hero2 = getObjectByName("Hero2") as AHero;
			hero2.name = "Hero2";
			/*hero1.setState(this);
			hero1.setCam(view.camera);
			hero1.setViewRoot(viewRoot.viewRoot);
			//hero.setCamPos(view.camera.camPos);
			hero1.setWorld(this.box2D.world);
			hero1.setWorldScale(this.box2D.scale);
			hero1.setInitialPos(new Point(hero.x, hero.y));
			hero1.init();*/
		}
		
		override public function update(timeDelta:Number):void
		{
			//if(!isPaused){
				super.update(timeDelta);
				box2D.world.Step(1/30, 10, 10);
				hero2.x = hero1.x;
			//}
		}
	}
}