package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width="1280", height="1200")] 
	public class SiteBattle extends Sprite
	{
		private var _home:Home;
		private var _faq:Faq;
		private var _galery:Galery;
		private var _howWork:HowWork;
		private var _myMoview:MyMovies;
		private var _rankingGalery:RankingGalery;
		private var _register:Register;
		private var _rules:Rules;
		private var _sendYouMovie:SendYouMovie;
		private var _header:Header;
		private var _footer:Footer;
		private var _pageContainer:MovieClip;
		private var _headerContainer:MovieClip;
		private var _listOfPages:Array;
		private var _actualPage:MovieClip;
		
		private var HOME:String = "home";
		private var HOW_WORK:String = "howWork";
		private var FAQ:String = "faq";
		private var GALERY:String = "galery";
		private var MY_MOVIE:String  = "myMovie";
		private var RANKING_GALERY:String = "rankingGalery";
		private var REGISTER:String = "reginter";
		private var RULES:String = "rules";
		private var SEND_MOVIE:String = "sendMovie";
		
		public function SiteBattle()
		{
			createContainers();
			createPages();
			createHeaderAndFooter();
		}
		
		private function createContainers():void
		{
			_pageContainer = new MovieClip();
			this.addChild(_pageContainer);
			_headerContainer = new MovieClip();
			this.addChild(_headerContainer);
		}
		
		private function createPages():void
		{
			_listOfPages = new Array();
			_home = new Home();
			_home.name = HOME;
			_home.visible = true;
			_pageContainer.addChild(_home);
			_home.btnEnjoy.addEventListener(MouseEvent.CLICK, goRegister);
			_home.btnEnjoy.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_home.btnEnjoy.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_home.btnEnjoy.buttonMode = true;
			_listOfPages.push(_home);
			_actualPage = _home;
			
			_howWork = new HowWork();
			_howWork.name = HOW_WORK;
			_howWork.visible = false;
			_pageContainer.addChild(_howWork);
			_listOfPages.push(_howWork);
			
			_faq = new Faq();
			_faq.name = FAQ;
			_faq.visible = false;
			_pageContainer.addChild(_faq);
			_listOfPages.push(_faq);
			
			_galery = new Galery();
			_galery.name = GALERY;
			_galery.visible = false;
			_pageContainer.addChild(_galery);
			_listOfPages.push(_galery);
			
			_myMoview = new MyMovies();
			_myMoview.name = MY_MOVIE;
			_myMoview.visible = false;
			_pageContainer.addChild(_myMoview);
			_listOfPages.push(_myMoview);
			
			_rankingGalery = new RankingGalery();
			_rankingGalery.name = RANKING_GALERY;
			_rankingGalery.visible = false;
			_pageContainer.addChild(_rankingGalery);
			_listOfPages.push(_rankingGalery);
			
			_register = new Register();
			_register.name = REGISTER;
			_register.visible = false;
			_pageContainer.addChild(_register);
			_listOfPages.push(_register);
			
			_rules = new Rules();
			_rules.name = RULES;
			_rules.visible = false;
			_pageContainer.addChild(_rules);
			_listOfPages.push(_rules);
			
			_sendYouMovie = new SendYouMovie();
			_sendYouMovie.name = SEND_MOVIE;
			_sendYouMovie.visible = false;
			_pageContainer.addChild(_sendYouMovie);
			_listOfPages.push(_sendYouMovie);
		}
		
		private function createHeaderAndFooter():void
		{
			_header = new Header();
			_headerContainer.addChild(_header);
			_header.btnBattle.addEventListener(MouseEvent.CLICK, goHome);
			_header.btnBattle.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_header.btnBattle.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_header.btnBattle.buttonMode = true;
			
			_header.btnHowWork.addEventListener(MouseEvent.CLICK, goHowWork);
			_header.btnHowWork.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_header.btnHowWork.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_header.btnHowWork.buttonMode = true;
			
			_header.btnGalery.addEventListener(MouseEvent.CLICK, goGalery);
			_header.btnGalery.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_header.btnGalery.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_header.btnGalery.buttonMode = true;
			
			_header.btnMyVideo.addEventListener(MouseEvent.CLICK, goMyMovie);
			_header.btnMyVideo.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_header.btnMyVideo.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_header.btnMyVideo.buttonMode = true;
			
			_header.btnSendYouVideo.addEventListener(MouseEvent.CLICK, goSendMovie);
			_header.btnSendYouVideo.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_header.btnSendYouVideo.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_header.btnSendYouVideo.buttonMode = true;
			
			_footer = new Footer();
			_headerContainer.addChild(_footer);
			_footer.y = _actualPage.height;
			_footer.btnRules.addEventListener(MouseEvent.CLICK, goRules);
			_footer.btnRules.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_footer.btnRules.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_footer.btnRules.buttonMode = true;
			
			_footer.btnFaq.addEventListener(MouseEvent.CLICK, goFaq);
			_footer.btnFaq.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_footer.btnFaq.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_footer.btnFaq.buttonMode = true;
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY -= .1;
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.scaleX = event.currentTarget.scaleY += .1;
		}
		
		private function goHome(event:MouseEvent = null):void
		{
			changePage(HOME);
		}
		
		private function goHowWork(event:MouseEvent = null):void
		{
			changePage(HOW_WORK);
		}
		
		private function goFaq(event:MouseEvent = null):void
		{
			changePage(FAQ);
		}
		
		private function goGalery(event:MouseEvent = null):void
		{
			changePage(GALERY);
		}
		
		private function goRankingGalery(event:MouseEvent = null):void
		{
			changePage(RANKING_GALERY);
		}
		
		private function goRegister(event:MouseEvent = null):void
		{
			changePage(REGISTER);
		}
		
		private function goSendMovie(event:MouseEvent = null):void
		{
			changePage(SEND_MOVIE);
		}
		
		private function goRules(event:MouseEvent = null):void
		{
			changePage(RULES);
		}
		
		private function goMyMovie(event:MouseEvent = null):void
		{
			changePage(MY_MOVIE);
		}
		
		private function changePage(page:String):void
		{
			for(var i:int = 0; i < _listOfPages.length; i++){
				if(_listOfPages[i].name == page){
					_listOfPages[i].visible = true;
					_actualPage = _listOfPages[i];
				}else{
					_listOfPages[i].visible = false;
				}
			}
			_footer.y = _actualPage.height;
		}
	}
}