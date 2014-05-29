/**
 * @author kermit
 */
package utils {
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
		
	public dynamic class KeyboardControl {
		
		// Is going to hold the stage being passed to this class.
		private static var stage:Stage;
		
		// Will store the keys currently being pressed.
		private static var keysCurrentlyDown:Object;
		
		/**
		 * Constructor for KeyboardControl class.
		 * It takes a stage as parameter so we have
		 * a stage to implement keyboard listeners too.
		 * @param stage
		 */
		public function KeyboardControl(stage:Stage) {
			implementOnStage(stage);
		}
		
		/**
		 * This method implements the KeyboardControl class'
		 * functionality to a given stage.
		 * @param stage
		 */
		public function implementOnStage(stage:Stage):void {
			this.stage = stage;
			keysCurrentlyDown = new Object();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		/**
		 * This method removes the functionality of this class
		 * from the calling stage.
		 */
		public function removeFromStage():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
			keysCurrentlyDown = new Object();
			this.stage = null;
		}
		
		/**
		 * Returns true if the key passed as parameter is
		 * pressed. Else it returns false. This happens by
		 * checking if the keyCurrentlyDown has the keyCode
		 * property true.
		 * @param keyCode
		 */
		public function isDown(keyCode:uint):Boolean {
			return Boolean(keyCode in keysCurrentlyDown);
		}
		
		/**
		 * This method stores the keyCode in the keyCurrentlyDown
		 * object.
		 */
		private function keyPressed(event:KeyboardEvent):void {
			keysCurrentlyDown[event.keyCode] = true;
		}
		
		/**
		 * When a key is released, it's keyCode is deleted from
		 * the keysCurrentlyDown object.
		 */
		private function keyReleased(event:KeyboardEvent):void {
			delete keysCurrentlyDown[event.keyCode];
		}
	}
}