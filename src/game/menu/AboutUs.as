/**
 * @author Bjørn Allan Johansen
 */
package game.menu {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
		
	public class AboutUs extends Sprite{
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/back.svg")]
    	private var BackClass:Class;
    	private var _backKey:Sprite = new BackClass();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/aboutUsScreen.svg")]
    	private var AboutUsClass:Class;
    	private var _aboutUs:Sprite = new AboutUsClass();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/webcomicstrips.svg")]
    	private var WebComicStripsClass:Class;
    	private var _webComicStrips:Sprite = new WebComicStripsClass();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/i.svg")]
    	private var IClass:Class;
    	private var _iImage:Sprite = new IClass();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/dot.svg")]
    	private var DotClass:Class;
    	private var _dot:Sprite = new DotClass();
		
		// Stage reference.
		private var _stageRef:Stage;
		
		// Boolean to tell if the "back" key has been clicked.
		private var _backKeyIsClicked:Boolean = false;
		
		private const LEFT_MARGEN:Number = 40;
		private const BUTTOM_MARGEN:Number = 80;
		
		/**
		 * Constructor for the AboutUs Class.
		 * @param stageRef Stage
		 */
		public function AboutUs(stageRef:Stage) {
			this._stageRef = stageRef;
		}
		
		/**
		 * This method starts up the "about us" screen.
		 */
		public function runInfo():void {
			this._aboutUs.x = 0;
			this._aboutUs.y = 0;
			this._stageRef.addChild(this._aboutUs);
			
			this._backKey.x = LEFT_MARGEN;
			this._backKey.y = this._stageRef.height - BUTTOM_MARGEN;
			this._stageRef.addChild(this._backKey);
			
			this._webComicStrips.scaleX = 1.5;
			this._webComicStrips.scaleY = 2;
			this._webComicStrips.x = this._stageRef.stageWidth/2 - this._webComicStrips.width/2;
			this._webComicStrips.y = this._stageRef.stageWidth/10;
			this._stageRef.addChild(this._webComicStrips);
			
			this._iImage.scaleX = 1.5;
			this._iImage.scaleY = 2;
			this._iImage.x = 292;
			this._iImage.y = 81;
			this._stageRef.addChild(this._iImage);
			
			this._dot.scaleX = 1.5;
			this._dot.scaleY = 2;
			this._dot.x = 292;
			this._dot.y = 62;
			this._stageRef.addChild(this._dot);
			
			this._backKey.addEventListener(MouseEvent.CLICK, backClickRespond);
			this._webComicStrips.addEventListener(MouseEvent.CLICK, webcomicstripsClickRespond);
			this._backKey.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._webComicStrips.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._backKey.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			this._webComicStrips.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
		}
		
		private function mouseOverRespond(mevt:MouseEvent):void {
			Mouse.cursor = "button";
		}
		
		private function mouseOutRespond(mevt:MouseEvent):void {
			Mouse.cursor = "auto";
		}
		
		private function webcomicstripsClickRespond(mevt:MouseEvent):void {
			var req:URLRequest = new URLRequest("http://www.webcomicstrips.net/");
			navigateToURL(req, "_blank");
		}
		
		/**
		 * This method is the respond method for when the "back"
		 * key is clicked.
		 * @param mevt MouseEvent
		 */
		private function backClickRespond(mevt:MouseEvent):void {
			this._backKeyIsClicked = true;
			clearStage();
		}
		
		/**
		 * This method returns the _backKeyIsClicked Boolean.
		 * It will return true if the "back" key has been clicked,
		 * else it will return false.
		 * @return _backKeyIsClicked Boolean
		 */
		public function get backIsClicked():Boolean {
			return this._backKeyIsClicked;
		}
		
		/**
		 * This method clears the stage.
		 */
		private function clearStage():void {
			this._backKey.removeEventListener(MouseEvent.CLICK, backClickRespond);
			this._backKey.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._backKey.removeEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			this._stageRef.removeChild(this._backKey);
			this._stageRef.removeChild(this._aboutUs);
			this._stageRef.removeChild(this._webComicStrips);
			this._stageRef.removeChild(this._iImage);
			this._stageRef.removeChild(this._dot);
			BackClass = null;
			AboutUsClass = null;
			WebComicStripsClass = null;
			IClass = null;
			DotClass = null;
		}
	}
}
