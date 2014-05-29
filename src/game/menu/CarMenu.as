/**
 * @author kermit
 */
package game.menu {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
		
	public class CarMenu extends Sprite{
		
		/**
		 * We load all the car images and put them each in their own Sprite.
		 */
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/fb1.svg")]
    	private var fb1CarClass:Class;
    	private var _fb1CarUnrotated:Sprite = new fb1CarClass();
    	private var _fb1Selected:Sprite = new fb1CarClass();

		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/fb2.svg")]
    	private var fb2CarClass:Class;
    	private var _fb2CarUnrotated:Sprite = new fb2CarClass();
    	private var _fb2Selected:Sprite = new fb2CarClass();

    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/eco1.svg")]
    	private var ec1CarClass:Class;
    	private var _ec1CarUnrotated:Sprite = new ec1CarClass();
    	private var _ec1Selected:Sprite = new ec1CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/eco2.svg")]
    	private var ec2CarClass:Class;
    	private var _ec2CarUnrotated:Sprite = new ec2CarClass();
    	private var _ec2Selected:Sprite = new ec2CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/gr1.svg")]
    	private var gr1CarClass:Class;
    	private var _gr1CarUnrotated:Sprite = new gr1CarClass();
    	private var _gr1Selected:Sprite = new gr1CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/gr2.svg")]
    	private var gr2CarClass:Class;
    	private var _gr2CarUnrotated:Sprite = new gr2CarClass();
    	private var _gr2Selected:Sprite = new gr2CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/pan1.svg")]
    	private var pa1CarClass:Class;
    	private var _pa1CarUnrotated:Sprite = new pa1CarClass();
    	private var _pa1Selected:Sprite = new pa1CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/pan2.svg")]
    	private var pa2CarClass:Class;
    	private var _pa2CarUnrotated:Sprite = new pa2CarClass();
    	private var _pa2Selected:Sprite = new pa2CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/rs1.svg")]
    	private var rs1CarClass:Class;
    	private var _rs1CarUnrotated:Sprite = new rs1CarClass();
    	private var _rs1Selected:Sprite = new rs1CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/rs2.svg")]
    	private var rs2CarClass:Class;
    	private var _rs2CarUnrotated:Sprite = new rs2CarClass();
    	private var _rs2Selected:Sprite = new rs2CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/sb1.svg")]
    	private var sb1CarClass:Class;
    	private var _sb1CarUnrotated:Sprite = new sb1CarClass();
    	private var _sb1Selected:Sprite = new sb1CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/sb2.svg")]
    	private var sb2CarClass:Class;
    	private var _sb2CarUnrotated:Sprite = new sb2CarClass();
    	private var _sb2Selected:Sprite = new sb2CarClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/carMenu.svg")]
    	private var CarMenuClass:Class;
    	private var _carMenuImage:Sprite = new CarMenuClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/aboutUs.svg")]
    	private var AboutUsClass:Class;
    	private var _aboutUsImage:Sprite = new AboutUsClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/continue.svg")]
    	private var ContinueKeyClass:Class;
    	private var _continueKey:Sprite = new ContinueKeyClass();
		
		/*
    	 * This Array will be used to hold the car images
    	 * so we easily can add them to the car selection
    	 * menu.
    	 */
    	private var _carImageArray:Array = new Array();
    	
    	// MovieClip to hold the car selection menu.
    	private var _menuRing:MovieClip;
		
		// Stage reference.
		private var _stageRef:Stage;
		
		// Boolean to tell if a car is selected.
		private var _carSelected:Boolean = false;
		
		// Boolean that tells if the player click the "about us" button.
		private var _aboutUsClicked:Boolean = false;
		
		// The class of the selected car.
		private var _ourSelectedCar:Class;
		
		// Key margen constant.
		private const SIDE_MARGEN:Number = 40;
		private const BUTTOM_MARGEN:Number = 80;
		
		/**
		 * Constructor for the class CarMenu.
		 * @param stageRef Stage
		 */
		public function CarMenu(stageref:Stage) {
			
			this._stageRef = stageref;
			
			/*
			 * Store all the car images in the carImageArray.
			 * This array is used to create the car selection
			 * menu at the begining of the game.
			 */
			storeImagesInArray();
			
			// Places the selected cars images.
			placeSelectedCars();
		}
		
		/**
		 * This method runs the carSelection method which
		 * starts the car menu.
		 */
		public function runCarMenu():void {
			carSelection();
		}
		
		/**
		 * Returns true if a car has been selected. This is
		 * used by the calling class so it knows when to
		 * proceed.
		 */
		public function get carIsSelected():Boolean {
			return this._carSelected;
		}
		
		/**
		 * Returns the class of the selected car.
		 * @return _ourSelectedCar Class
		 */
		public function get selectedCar():Class {
			if(carIsSelected) {
				return this._ourSelectedCar; 
			} else {
				return null;
			}
		}
		
		/**
		 * Returns true if the player clicks the "about us" button.
		 * @return _aboutUsClicked Boolean
		 */
		public function get aboutUsIsClicked():Boolean {
			return this._aboutUsClicked;
		}
		
		/**
		 * This method stores all the images in an array, so
		 * they are easy to access for the car selection menu.
		 */
		private function storeImagesInArray():void {
			for each(var carUnrotated:Sprite in [this._fb1CarUnrotated, this._fb2CarUnrotated, this._ec1CarUnrotated, this._ec2CarUnrotated, this._gr1CarUnrotated, this._gr2CarUnrotated, this._sb1CarUnrotated, this._sb2CarUnrotated, this._pa1CarUnrotated, this._pa2CarUnrotated, this._rs1CarUnrotated, this._rs2CarUnrotated]) {
				this._carImageArray.push(carUnrotated);
			}
		}
		
		/**
		 * Places the selected car images and the start
		 * game image.
		 */
		private function placeSelectedCars():void {
			
			// Background.
			this._carMenuImage.x = 0;
			this._carMenuImage.y = 0;
			this._stageRef.addChild(this._carMenuImage);
				
			for each(var container:Sprite in [_fb1Selected, _fb2Selected, _ec1Selected, _ec2Selected, _gr1Selected, _gr2Selected, _pa1Selected, _pa2Selected, _rs1Selected, _rs2Selected, _sb1Selected, _sb2Selected]) {
				container.x = this._stageRef.stageWidth/2 - container.width/2;
				container.y = this._stageRef.stageHeight/2;
				container.visible = false;
				this._stageRef.addChild(container);
			}
			
			this._continueKey.x = this._stageRef.stageWidth - this._continueKey.width - SIDE_MARGEN;
			this._continueKey.y = this._stageRef.stageHeight - BUTTOM_MARGEN;
			this._stageRef.addChild(this._continueKey);
			this._continueKey.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._continueKey.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			
			this._aboutUsImage.x = SIDE_MARGEN;
			this._aboutUsImage.y = this._continueKey.y;
			this._stageRef.addChild(this._aboutUsImage);
			this._aboutUsImage.addEventListener(MouseEvent.CLICK, aboutUsRespond);
			this._aboutUsImage.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._aboutUsImage.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
		}
		
		/**
		 * Method that enables the player to choose a car.
		 */
		private function carSelection():void {
			// The MovieClip that will contain the car menu.
			this._menuRing = createCarMenu();
			// Placing the menu on the screen.
			this._menuRing.x = this._stageRef.stageWidth/2 - SIDE_MARGEN;
			this._menuRing.y = this._stageRef.height/4;
			this._stageRef.addChild(this._menuRing);
			this._menuRing.addEventListener(Event.ENTER_FRAME, carMenuRoll);
		}
		
		private var _container:MovieClip;
		/**
		 * Creates the car menu by placing them in a ring
		 * where they gradually fade out into the background.
		 */
		private function createCarMenu():MovieClip {
			// The container that will contain the menu.
			_container = new MovieClip();
			_container.cars = [];
			_container.theta = 0;
			_container.thetaDest = 0;
			var step:Number = (Math.PI * 2) / this._carImageArray.length;
			for(var i:int = 0; i < this._carImageArray.length; i++) {
				var c:MovieClip = new MovieClip();
				c.addChild(this._carImageArray[i]);
				c.thetaOffset = step * i;
				_container.addChild(c);
				_container.cars.push(c);
			}
			_container.addEventListener(MouseEvent.CLICK, menuClickRespond, false, 0, true);
			_container.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond, false, 0, true);
			_container.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond, false, 0, true);
			return _container;
		}
		
		private function mouseOverRespond(mevt:MouseEvent):void {
			Mouse.cursor = "button";
		}
		
		private function mouseOutRespond(mevt:MouseEvent):void {
			Mouse.cursor = "auto";
		}
		
		/**
		 * This is the respond to any click in the car selection menu.
		 */
		private function menuClickRespond(mevt:MouseEvent):void {
			
			for each(var selected:Sprite in [_fb1Selected, _fb2Selected, _ec1Selected, _ec2Selected, _gr1Selected, _gr2Selected, _pa1Selected, _pa2Selected, _rs1Selected, _rs2Selected, _sb1Selected, _sb2Selected]) {
				selected.visible = false;
			}
			
			if(!this._continueKey.hasEventListener(MouseEvent.CLICK)) {
				this._continueKey.addEventListener(MouseEvent.CLICK, startGameClickRespond);
			}
			
			switch(mevt.target) {
				case _fb1CarUnrotated:
					this._fb1Selected.visible = true;
					break;
				case _fb2CarUnrotated:
					this._fb2Selected.visible = true;
					break;
				case _ec1CarUnrotated:
					this._ec1Selected.visible = true;
					break;
				case _ec2CarUnrotated:
					this._ec2Selected.visible = true;
					break;
				case _gr1CarUnrotated:
					this._gr1Selected.visible = true;
					break;
				case _gr2CarUnrotated:
					this._gr2Selected.visible = true;
					break;
				case _pa1CarUnrotated:
					this._pa1Selected.visible = true;
					break;
				case _pa2CarUnrotated:
					this._pa2Selected.visible = true;
					break;
				case _rs1CarUnrotated:
					this._rs1Selected.visible = true;
					break;
				case _rs2CarUnrotated:
					this._rs2Selected.visible = true;
					break;
				case _sb1CarUnrotated:
					this._sb1Selected.visible = true;
					break;
				case _sb2CarUnrotated:
					this._sb2Selected.visible = true;
					break;
			}
		}
		
		/**
		 * This method is called when the player clicks the "start game"
		 * button.
		 * @param evt MouseEvent
		 */
		private function startGameClickRespond(evt:MouseEvent):void {
			
			this._carSelected = true;
						
			if(this._fb1Selected.visible) {
				this._ourSelectedCar = fb1CarClass;
				cleanUpMain();
			} else if(this._fb2Selected.visible) {
				this._ourSelectedCar = fb2CarClass;
				cleanUpMain();
			} else if(this._ec1Selected.visible) {
				this._ourSelectedCar = ec1CarClass;
				cleanUpMain();
			} else if(this._ec2Selected.visible) {
				this._ourSelectedCar = ec2CarClass;
				cleanUpMain();
			} else if(this._gr1Selected.visible) {
				this._ourSelectedCar = gr1CarClass;
				cleanUpMain();
			} else if(this._gr2Selected.visible) {
				this._ourSelectedCar = gr2CarClass;
				cleanUpMain();
			} else if(this._pa1Selected.visible) {
				this._ourSelectedCar = pa1CarClass;
				cleanUpMain();
			} else if(this._pa2Selected.visible) {
				this._ourSelectedCar = pa2CarClass;
				cleanUpMain();
			} else if(this._rs1Selected.visible) {
				this._ourSelectedCar = rs1CarClass;
				cleanUpMain();
			} else if(this._rs2Selected.visible) {
				this._ourSelectedCar = rs2CarClass;
				cleanUpMain();
			} else if(this._sb1Selected.visible) {
				this._ourSelectedCar = sb1CarClass;
				cleanUpMain();
			} else if(this._sb2Selected.visible) {
				this._ourSelectedCar = sb2CarClass;
				cleanUpMain();
			}
		}
		
		/**
		 * This method starts the "about us" screen where the
		 * player can read about www.webcomicstrips.net and
		 * find a link to our homepage.
		 * @param mevt MouseEvent
		 */
		private function aboutUsRespond(mevt:MouseEvent):void {
			this._aboutUsClicked = true;
			pause();
		}
		
		/**
		 * This method is used to pause the car menu and hiding all
		 * the elements.
		 */
		public function pause():void {
			this._menuRing.removeEventListener(Event.ENTER_FRAME, carMenuRoll);
			this._menuRing.removeEventListener(MouseEvent.CLICK, menuClickRespond);
			this._continueKey.removeEventListener(MouseEvent.CLICK, startGameClickRespond);
			this._aboutUsImage.removeEventListener(MouseEvent.CLICK, aboutUsRespond);
			for each(var container:Sprite in [_fb1Selected, _fb2Selected, _ec1Selected, _ec2Selected, _gr1Selected, _gr2Selected, _pa1Selected, _pa2Selected, _rs1Selected, _rs2Selected, _sb1Selected, _sb2Selected, _continueKey, _aboutUsImage, _carMenuImage, _menuRing]) {
				container.visible = false;
			}
		}
		
		/**
		 * If the car menu have been paused, this method can be called
		 * to start it up again.
		 */
		public function unPause():void {
			this._menuRing.addEventListener(Event.ENTER_FRAME, carMenuRoll);
			this._menuRing.addEventListener(MouseEvent.CLICK, menuClickRespond);
			this._aboutUsImage.addEventListener(MouseEvent.CLICK, aboutUsRespond);
			
			for each(var container:Sprite in [_continueKey, _aboutUsImage, _carMenuImage, _menuRing]) {
				container.visible = true;
			}
			for each(var containerSelected:Sprite in [_fb1Selected, _fb2Selected, _ec1Selected, _ec2Selected, _gr1Selected, _gr1Selected, _pa1Selected, _pa2Selected, _rs1Selected, _rs2Selected, _sb1Selected, _sb2Selected]) {
				containerSelected.visible = false;
			}
			this._aboutUsClicked = false;
		}
		
		/**
		 * This method makes the menu roll when the mouse
		 * moves.
		 */
		private function carMenuRoll(evt:Event):void {
			var container:MovieClip = MovieClip(evt.currentTarget);
			var num:int = container.cars.length;
			for(var i:int = 0; i<num; i++) {
				var c:MovieClip = container.cars[i];
				var angle:Number = container.theta + c.thetaOffset;
				c.x = 200 * Math.cos(angle);
				c.y = 20 * Math.sin(angle);
				c.scaleX = (100 + c.y) * 0.008333333 + 0.2;
				c.scaleY = c.scaleX;
				c.alpha = 0.05 * c.y;
			}
			
			container.cars.sortOn("y", Array.NUMERIC);
			for(i = 0; i<num; i++) {
				container.addChild(container.cars[i]);
			}
			if(container.mouseX < -15) {
				container.thetaDest -= 0.05;
			}
			if(container.mouseX > 105) {
				container.thetaDest += 0.05;
			}
			container.theta += (container.thetaDest - container.theta) / 12;
		}
		
		/**
		 * This method cleans up the stage.
		 */
		private function cleanUpMain():void {
			
			this._menuRing.removeEventListener(Event.ENTER_FRAME, carMenuRoll);
			this._continueKey.removeEventListener(MouseEvent.CLICK, startGameClickRespond);
			this._aboutUsImage.removeEventListener(MouseEvent.CLICK, aboutUsRespond);
			this._aboutUsImage.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._aboutUsImage.removeEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			this._continueKey.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._continueKey.removeEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			
			_container.removeEventListener(MouseEvent.CLICK, menuClickRespond);
			_container.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			_container.removeEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			
			for each(var containerNull:Sprite in [_fb1Selected, _fb2Selected, _ec1Selected, _ec2Selected, _gr1Selected, _gr1Selected, _pa1Selected, _pa2Selected, _rs1Selected, _rs2Selected, _sb1Selected, _sb2Selected, _continueKey, _aboutUsImage, _carMenuImage, _menuRing]) {
				if(!containerNull.visible) {
					containerNull = null;
				}
			}
			
			for each(var classes:Class in [fb1CarClass, fb2CarClass, ec1CarClass, ec2CarClass, gr1CarClass, gr2CarClass, pa1CarClass, pa2CarClass, rs1CarClass, rs2CarClass, sb1CarClass, sb2CarClass]) {
				classes = null;
			}
			
			for each(var container:Sprite in [_fb1Selected, _fb2Selected, _ec1Selected, _ec2Selected, _gr1Selected, _gr1Selected, _pa1Selected, _pa2Selected, _rs1Selected, _rs2Selected, _sb1Selected, _sb2Selected, _continueKey, _aboutUsImage, _carMenuImage, _menuRing]) {
				this._stageRef.removeChild(container);
			}
			
			this._carImageArray = null;
			
			this.ContinueKeyClass = null;
			this.AboutUsClass = null;
			this.CarMenuClass = null;
			this._menuRing = null;
		}
	}
}