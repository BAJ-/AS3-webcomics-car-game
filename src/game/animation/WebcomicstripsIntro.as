/**
 * @author Bjorn Allan Johansen
 */
package game.animation {
	
		import flash.display.Sprite;
		import flash.display.Stage;
		import flash.events.Event;
		import flash.text.TextField;
		
	public class WebcomicstripsIntro extends Sprite{
		
		// Images used for intro animation
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/webcomicstrips.svg")]
    	private var webcomicstripsClass:Class;
    	private var _webcomicstripsSVG:Sprite = new webcomicstripsClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/i.svg")]
    	private var iClass:Class;
    	private var _iSVG:Sprite = new iClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/dot.svg")]
    	private var dotClass:Class;
    	private var _dotSVG:Sprite = new dotClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/presents.svg")]
    	private var presentsClass:Class;
    	private var _presentsSVG:Sprite = new presentsClass();
    	
    	// Variables used to make the iWobble method work.
    	private var _vy:Number = 1;
		private var _k:Number = 0.5;
		private var _damp:Number = 0.9;  
		private var _scaleY:Number = 4;
		private var _iTargetY:Number = 178;
		private var _frameCounter:Number = 0;
		
		// End position for the dotSVG image.
		private var _dotTargetY:Number = 156;
		
		// Stage reference.
		private var _stageRef:Stage;
		
		// Variable to hold the frame rate of the Class that calls this.
		private var _callingClassFrameRate:int;
		
		// Boolean to indicate if the intro is finish or not.
		private var _introFinish:Boolean = false;
		
    	/**
    	 * Constructor for class WebcomicstripsIntro.
    	 * @param stageref Stage
    	 */
		public function WebcomicstripsIntro(stageref:Stage) {
			
			// Stage reference.
			this._stageRef = stageref;
			
			// Saving the calling Class' frame rate.
			this._callingClassFrameRate = this._stageRef.frameRate;
			
			// Setting the frame rate that this animation is designed for.
			this._stageRef.frameRate = 60;
				
			// Setting up images for intro animation
			this._webcomicstripsSVG.x = 20;
			this._webcomicstripsSVG.y = 150;
			this._webcomicstripsSVG.width = 600;
			this._webcomicstripsSVG.height = 100;
			this._webcomicstripsSVG.alpha = 0;
			this._stageRef.addChild(this._webcomicstripsSVG);
			
			this._iSVG.x = 282;
			this._iSVG.y = 173;
			this._iSVG.width = 10;
			this._iSVG.height = 55;
			this._iSVG.alpha = 0;
			this._stageRef.addChild(this._iSVG);
			
			this._dotSVG.x = 281;
			this._dotSVG.y = -20;
			this._dotSVG.width = 13;
			this._dotSVG.height = 19;
			this._stageRef.addChild(this._dotSVG);
			
			this._presentsSVG.x = 250;
			this._presentsSVG.y = 250;
			this._presentsSVG.width = 100;
			this._presentsSVG.height = 30;
			this._presentsSVG.alpha = 0;
			this._stageRef.addChild(this._presentsSVG);
			
		}
		
		/**
		 * Returns true when the intro animation is finish,
		 * else it returns false.
		 * @return _introFinish Boolean.
		 */
		public function get isFinish():Boolean {
			return _introFinish;
		}
		
		/**
		 * Starts the webcomicstrips.net intro by
		 * adding an event listener to fadeIn.
		 * The intro rolls from there.
		 */
		public function runIntro():void {
			addEventListener(Event.ENTER_FRAME, fadeIn);
		}
		
		/**
		 * This method fades in the webcomicstrips.net
		 * text. When the fade in is completed (ie the
		 * images alpha value equals 1), the event
		 * listener is removed from this function and a
		 * new one is added to the method dotDown.
		 * @param event Event.
		 */
		private function fadeIn(event:Event):void {
			
			this._webcomicstripsSVG.alpha += 0.005;
			this._iSVG.alpha += 0.005;
				
			/*
			 * When the sprites alpha value equals one
			 * it is solid, and we are finish fading in.
			 */
			if(this._webcomicstripsSVG.alpha == 1) {
				removeEventListener(Event.ENTER_FRAME, fadeIn);
				addEventListener(Event.ENTER_FRAME, dotDown);
			}
		}
		
		/**
		 * This method is called after the method fadIn, and
		 * it moves down the dot to its place over the i in
		 * comics. When this is done, the event listner is
		 * removed and a new one is added to the method iWobble.
		 * @param event Event
		 */
		private function dotDown(event:Event):void {
			
			// Moving down the dotSVG image.
			this._dotSVG.y += 4;
			
			/*
			 * When the dot hits the target on the
			 * y-axis, we are finish moving the dot.
			 */
			if(this._dotSVG.y == this._dotTargetY) {
				removeEventListener(Event.ENTER_FRAME, dotDown);
				addEventListener(Event.ENTER_FRAME, iWobble);
			}
		}
		
		/**
		 * This method is called by the dotDown method. It
		 * makes the i in "comics" wobble for 120 frames
		 * where after it removes the event listener and
		 * adds a new one to the presentsGame method.
		 * @param event Event
		 */
		private function iWobble(event:Event):void {
			
			// Moves the I down in place.
			if(this._iSVG.y < this._iTargetY) {
				this._iSVG.y += 0.5;
			}
			// This counter 
			this._frameCounter++;
			var ay:Number = (this._scaleY - this._iSVG.scaleY) * _k;
			this._vy += ay;
			this._iSVG.scaleY += Math.sin(_vy)/2;
			this._vy *= this._damp;
			
			// After 120 frames the wobble stops.
			if(this._frameCounter > 120) {
				removeEventListener(Event.ENTER_FRAME, iWobble);
				addEventListener(Event.ENTER_FRAME, presentsGame);
			}
		}
		
		/**
		 * This method presents the game.
		 * @param event Event
		 */
		private function presentsGame(event:Event):void {
			
			this._presentsSVG.alpha += 0.01;
			
			if(this._presentsSVG.alpha == 1) {
				removeEventListener(Event.ENTER_FRAME, presentsGame);
				addEventListener(Event.ENTER_FRAME, fadeOut);
			}
		}
		
		/**
		 * This method fades out everything from the
		 * introduction and runs the gameName method,
		 * the final step before the game starts.
		 * @param event Event.
		 */
		private function fadeOut(event:Event):void {
			
			this._webcomicstripsSVG.alpha -= 0.005;
			this._iSVG.alpha -= 0.005;
			this._dotSVG.alpha -= 0.005;
			
			if(this._webcomicstripsSVG.alpha < 0.5) {
				this._presentsSVG.alpha -= 0.005;
			}
			
			if(this._presentsSVG.alpha == 0) {
				removeEventListener(Event.ENTER_FRAME, fadeOut);
				//addEventListener(Event.ENTER_FRAME, gameName);
				gameName();
			}
		}
		
		/**
		 * The gameName method is where the name of the game
		 * being started is being introduced. When this is
		 * finished, the method sets the _introFinish variable
		 * to true and runs the destroy method.
		 */
		private function gameName():void {
			this._introFinish = true;
			
			// Setting the frame rate back to it's original state.
			this._stageRef.frameRate = this._callingClassFrameRate;
			destroy();
		}
		
		/**
		 * "Garbage collection" as3 style.
		 * We remove everything from the stage.
		 */
		private function destroy():void {
			this._stageRef.removeChild(this._webcomicstripsSVG);
			this._stageRef.removeChild(this._iSVG);
			this._stageRef.removeChild(this._dotSVG);
			this._stageRef.removeChild(this._presentsSVG);
		}
	}
}
