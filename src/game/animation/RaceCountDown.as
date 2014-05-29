/**
 * @author kermit
 */
package game.animation {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
		
	public class RaceCountDown extends Sprite{
		
		// Stage reference variable.
		private var _stageRef:Stage;
		
		// Variable used to count down.
		private var _countDownCounter:uint;
		
		// This variable holds true when the countdown is at Go.
		private var _countDownAtGo:Boolean;
		
		// This variable holds true when the countdown is finish. 
		private var _countDownIsFinish:Boolean;
		
		// Countdown graphics.
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/countDown3.svg")]
		private var CountDown3:Class;
		private var _countDown3:Sprite = new CountDown3();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/countDown2.svg")]
		private var CountDown2:Class;
		private var _countDown2:Sprite = new CountDown2();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/countDown1.svg")]
		private var CountDown1:Class;
		private var _countDown1:Sprite = new CountDown1();
		
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/countDownGO.svg")]
		private var CountDownGO:Class;
		private var _countDownGO:Sprite = new CountDownGO();
			
		public function RaceCountDown(stageRef:Stage) {
			
			// Setting stage reference.
			this._stageRef = stageRef;
			
			this._countDownCounter = 3;
			
			this._countDownAtGo = false;
			
			this._countDownIsFinish = false;
			
			setCountDownParameters();
		}
		
		/**
		 * This method starts the countdown by adding an EventListener
		 * to the method startGameCountDown.
		 */
		public function start():void {
			addEventListener(Event.ENTER_FRAME, startGameCountDown);
		}
		
		/**
		 * Implicit get method that returns the _countDownAtGo
		 * Boolean.
		 * @return _countDownAtGo Boolean
		 */
		public function get countDownAtGo():Boolean {
			return this._countDownAtGo;
		}
		
		/**
		 * Implicit get method that returns the _countDownIsFinish
		 * Boolean.
		 * @return _countDownIsFinish Boolean
		 */
		public function get countDownIsFinish():Boolean {
			return this._countDownIsFinish;
		}
		
		/**
		 * This method sets up everything to do with the race count down.
		 */
		private function setCountDownParameters():void {
			// Add the count down number 3 to the stage.
			_countDown3.x = this._stageRef.stageWidth/2 - _countDown3.width/2;
			_countDown3.y = this._stageRef.stageHeight/2 - _countDown3.height/2;
			_countDown3.scaleX = 5;
			_countDown3.scaleY = 5;
			this._stageRef.addChild(_countDown3);
			
			// Add the count down number 2 to the stage at sets it to be
			// transparent as it is not in use yet.
			_countDown2.alpha = 0;
			_countDown2.scaleX = 5;
			_countDown2.scaleY = 5;
			this._stageRef.addChild(_countDown2);
			
			// Add the count down number 1 to the stage at sets it to be
			// transparent as it is not in use yet.
			_countDown1.alpha = 0;
			_countDown1.scaleX = 5;
			_countDown1.scaleY = 5;
			this._stageRef.addChild(_countDown1);
			
			_countDownGO.alpha = 0;
			_countDownGO.scaleX = 5;
			_countDownGO.scaleY = 5;
			this._stageRef.addChild(_countDownGO);
		}
				
		/**
		 * This method counts down to race start.
		 * @param evt Event
		 */
		private function startGameCountDown(evt:Event):void {
			// If the countDownCounter is 3 this will run.
			if(_countDownCounter == 3) {
				_countDown3.alpha -= 0.015;
				_countDown3.scaleX -= .05;
				_countDown3.scaleY -= .05;
				_countDown3.x = this._stageRef.stageWidth/2 - _countDown3.width/2;
				_countDown3.y = this._stageRef.stageHeight/2 - _countDown3.height/2;
				// If the alpha value is under 0, we are finish fading out the number
				// and therefore removes the object _countDown3 and decrease the counter.
				if(_countDown3.alpha < 0) {
					this._stageRef.removeChild(_countDown3);
					_countDown3 = null;
					_countDownCounter--;
					_countDown2.alpha = 1;
				}
			}
			if(_countDownCounter == 2) {
				_countDown2.alpha -= 0.015;
				_countDown2.scaleX -= .05;
				_countDown2.scaleY -= .05;
				_countDown2.x = this._stageRef.stageWidth/2 - _countDown2.width/2;
				_countDown2.y = this._stageRef.stageHeight/2 - _countDown2.height/2;
				if(_countDown2.alpha < 0) {
					this._stageRef.removeChild(_countDown2);
					_countDown2 = null;
					_countDownCounter--;
					_countDown1.alpha = 1;
				}
			}
			if(_countDownCounter == 1) {
				_countDown1.alpha -= 0.015;
				_countDown1.scaleX -= .05;
				_countDown1.scaleY -= .05;
				_countDown1.x = this._stageRef.stageWidth/2 - _countDown1.width/2;
				_countDown1.y = this._stageRef.stageHeight/2 - _countDown1.height/2;
				if(_countDown1.alpha < 0) {
					this._countDownAtGo = true;
					this._stageRef.removeChild(_countDown1);
					_countDown1 = null;
					_countDownCounter--;
					_countDownGO.alpha = 1;
				}
			}
			// If the counter is 0, we are finish counting down, and so we show
			// the GO image.
			if(_countDownCounter ==  0) {
				_countDownGO.alpha -= 0.05;
				_countDownGO.scaleX -= .05;
				_countDownGO.scaleY -= .05;
				_countDownGO.x = this._stageRef.stageWidth/2 - _countDownGO.width/2;
				_countDownGO.y = this._stageRef.stageHeight/2 - _countDownGO.height/2;
				if(_countDownGO.alpha < 0) {
					this._stageRef.removeChild(_countDownGO);
					_countDownGO = null;
					this._countDownIsFinish = true;
					removeEventListener(Event.ENTER_FRAME, startGameCountDown);
				}
			}
		}
		
	}
}