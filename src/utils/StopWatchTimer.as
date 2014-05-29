/**
 * @author Bjørn Allan Johansen
 */
package utils {
	
	import flash.utils.getTimer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class StopWatchTimer extends Sprite{
		
		private var _startTime:uint;
		private var _minutes:uint;
		private var _seconds:uint;
		private var _hundreds:uint;
		private var _milliseconds:uint;
		
		private var _minutesString:String;
		private var _secondsString:String;
		private var _hundredsString:String;
		
		//private var _stageRef:Stage;
		
		private const _msPerMinute:uint = 60000;
		private const _msPerSecond:uint = 1000;
		private const _msPerHundreds:uint = 10;
		
		/**
		 * Constructor for the class Timer.
		 */
		public function StopWatchTimer() {
			//this._stageRef = stageRef;
			this._milliseconds = 0;
			this._minutes = 0;
			this._seconds = 0;
			this._hundreds = 0;
		}
		
		/**
		 * Method that starts the timer.
		 */
		public function startTimer():void {
			_startTime = getTimer();
			addEventListener(Event.ENTER_FRAME, timeTicker);
		}
		
		public function resetTimer():void {
			this.stopTimer();
			this.startTimer();
		}
		
		/**
		 * Ticks time.
		 */
		private function timeTicker(evt:Event):void {
			_milliseconds = getTimer() - _startTime;
			setMinutes();
			setSeconds();
			setHundreds();
		}
		
		/**
		 * Method that stops the timer.
		 */
		public function stopTimer():void {
			removeEventListener(Event.ENTER_FRAME, timeTicker);
		}
		
		/**
		 * Returns the number of minutes passed since
		 * the timer was started.
		 * @return _minutes uint
		 */
		public function get minutes():uint {
			return _minutes;
		}
		
		/**
		 * Returns the number of seconds passed minus the
		 * number of minutes passed, since the timer was
		 * started.
		 * @return _seconds uint
		 */
		public function get seconds():uint {
			return _seconds;
		}
		
		/**
		 * Returns the number of hundreds of seconds passed
		 * minus the number of seconds and minutes passed since
		 * the timer was started.
		 * since the timer started.
		 * @return _hundreds
		 */
		public function get hundreds():uint {
			return _hundreds;
		}
		
		/**
		 * Returns the total number of milliseconds passed since
		 * the timer was started.
		 * @return _milliseconds uint
		 */
		public function get millisecondsTotal():uint {
			return _milliseconds;
		}
		
		/**
		 * Sets the _minutes variable.
		 */
		private function setMinutes():void {
			_minutes = Math.floor(_milliseconds/_msPerMinute);
			if(_minutes < 10) {
				_minutesString = "0" + _minutes;
			} else {
				_minutesString = String(_minutes);
			}
		}
		
		/**
		 * Sets the _seconds variable.
		 */
		private function setSeconds():void {
			_seconds = Math.floor( (_milliseconds - _minutes*_msPerMinute)/_msPerSecond);
			if(_seconds < 10) {
				_secondsString = "0" + _seconds;
			} else {
				_secondsString = String(_seconds);
			}
		}
		
		/**
		 * Sets the _hundreds variable.
		 */
		private function setHundreds():void {
			_hundreds = Math.floor( (_milliseconds - _seconds*_msPerSecond - _minutes*_msPerMinute) / _msPerHundreds);
			if(_hundreds < 10) {
				_hundredsString = "0" + _hundreds;
			} else {
				_hundredsString = String(_hundreds);
			}
		}
		
		/**
		 * Returns the time as a string.
		 */
		override public function toString():String {
			if(_minutesString == null || _secondsString == null || _hundredsString == null) {
				_minutesString = "00";
				_secondsString = "00";
				_hundredsString = "00";
			}
			return _minutesString + ":" + _secondsString + "." + _hundredsString;
		}
	}
}
