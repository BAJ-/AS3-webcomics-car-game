/**
 * @author Bjørn Allan Johansen
 */
package game {
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import game.objects.Car;
	import game.animation.RaceCountDown;
	import utils.KeyboardControl;
	import utils.HitTester;
	import utils.StopWatchTimer;
	import flash.utils.*;
		
	public class Race extends Sprite{
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/finishLine.svg")]
    	private var FinishLineClass:Class;
    	private var _finishLine:Sprite = new FinishLineClass();
		
		// A Class variable to hold the passed track image Class.
		private var OurTrack:Class;
    	private var _track:Sprite;
    	
    	// A Class variable to hold the passed road image Class.
    	private var TrackRoad:Class;
    	private var _trackRoad:Sprite;
    	
				
		// Stage reference.
		private var _stageRef:Stage;
		
		// Countdown graphics Object.
		private var _raceCountDown:RaceCountDown;
		
		// Keyboard control Object.
		private var _key:KeyboardControl;
		
		// The track timer.
		private var _lapTimer:StopWatchTimer = new StopWatchTimer();
		private var _totalTime:StopWatchTimer = new StopWatchTimer();
		
		// This variable tells if the timer has been started or not.
		private var _timerStarted:Boolean;
		
		// This variable is used to keep track of the laps being completed.
		private var _lapCounter:uint;
		
		/*
		 * This Object will be used to detect if our car hits the
		 * boundries of the race track.
		 */
		private var _carCollisionTester:HitTester = new HitTester();
		
		/*
		 * This variable will hold the passed car Class for
		 * further use. The passed car Class is holding the
		 * car image.
		 */
		private var _ourCarClass:Class;
		
		/*
		 * This variable will be an instance of the passed car Class,
		 * and is used to center the car image, so that
		 * we can rotate it around its center.
		 */
		private var _ourCarUnrotated:Sprite;
		
		/*
		 * This variable will hold the _ourCarUnrotated Sprite. Because
		 * the _ourCarUnrotated Sprite is centered in this _ourCarImage
		 * Sprite, we will rotate the car around its center if we rotate
		 * _ourCarImage.
		 */
		private var _ourCarImage:Sprite = new Sprite;
		
		/*
		 * A car Class Object that holds all the methods of
		 * the Car Class.
		 */
		private var _ourCar:Car;
		
		// TextField's that will be used to display times and laps.
		private var _timerText:TextField = new TextField();
		private var _lapTimerText:TextField = new TextField();
		private var _bestLapText:TextField = new TextField();
		
		// TextField that will display the current lap.
		private var _lapText:TextField = new TextField();
		
		// This TextFormat is only used to give the _lapText the correct size.
		private var _lapTextFormat:TextFormat = new TextFormat();
		
		// Shape objects that holds the checkpoints.
		private var _checkPointOneShape:Shape = new Shape();
		private var _checkPointTwoShape:Shape = new Shape();
		private var _checkPointThreeShape:Shape = new Shape();
		
		// Tells weater or not the finishline was entered.
		private var _finishLineWasEntered:Boolean;
		
		// None of the checkpoints have been crossed at the begining
		// of the race, so they are all set to false.
		private var _checkPointOnePassed:Boolean = false;
		private var _checkPointTwoPassed:Boolean = false;
		private var _checkPointThreePassed:Boolean = false;
		
		// Number of laps in the race. As we count from 0 this gives 10 laps.
		private const _numberOfLaps:uint = 9;
		
		// Will hold each lap time in the race.
		private var _lapTimeArray:Array;
		
		/*
		 * This variable will hold the best laptime so far.
		 * It is stored in milliseconds. Also it holds the
		 * time in mm:ss.hh as a String.
		 */
		private var _bestLap:Object;
		
		/*
		 * Just as the _bestLap Object this hold time information,
		 * the difference being that this holds the total race
		 * time, both in milliseconds and in String form.
		 */
		private var _totalRaceTime:Object;
		
		// Boolean to tell if the race is finish or not.
		private var _raceIsFinish:Boolean = false;
		
		// Color for a not-passed check point RED.
		private const CHECK_POINT_NOT_PASSED:int = 0xC00A00;
		// Color for at passed check point GREEN;
		private const CHECK_POINT_PASSED:int = 0x4AB900;  
				
		/**
		 * Constructor for class Race
		 * @param stageref Stage
		 * @param ourcar Class
		 */
		public function Race(stageref:Stage, passedCarClass:Class, passedTrack:Class, passedRoad:Class) {
			
			// Setting the stage reference.
			this._stageRef = stageref;
			
			/*
			 * Here we create our Car object.
			 * @param xPos
		 	 * @param yPos
		 	 * @param orientationDegree
		 	 * @param maxSpeed
		 	 * @param width
		 	 * @param length
			 */
			_ourCar = new Car(570, 330, 270, 4, 25, 39.3);
			
			 // Making keyboard control possible on stage.
			_key = new KeyboardControl(this._stageRef);
			
			// Places the road image on the stage.
			this.TrackRoad = passedRoad;
			this._trackRoad = new TrackRoad();
			this._trackRoad.x = 0;
			this._trackRoad.y = 0;
			this._stageRef.addChild(this._trackRoad);
			
			
			// Places and adding the finish line to the screen.
			this._finishLine.x = 515;
			this._finishLine.y = 310.5;
			this._finishLine.alpha = 0.5;
			this._stageRef.addChild(_finishLine);
			
			// We start on the finish line, so it's set to true.
			this._finishLineWasEntered = true;
			
			this.OurTrack = passedTrack;
			this._track = new OurTrack();
			this._track.x = 0;
			this._track.y = 0;
			// Here we draw and add checkpoints to the stage.
			drawCheckPoints(CHECK_POINT_NOT_PASSED, true, true, true);
			this._stageRef.addChild(_checkPointOneShape);
			this._stageRef.addChild(_checkPointTwoShape);
			this._stageRef.addChild(_checkPointThreeShape);
			
			// Setting the track on the stage.
			this._stageRef.addChild(this._track);
			
			// Set the text that shows the _lapTimer.
			_lapTimerText.x = 196;
			_lapTimerText.y = 118;
			_lapTimerText.text = _lapTimer.toString();
			this._stageRef.addChild(_lapTimerText);
			
			// Set the text that shows the _totalTime.
			_timerText.x = 196;
			_timerText.y = 143;
			_timerText.text = _totalTime.toString();
			this._stageRef.addChild(_timerText);
			
			// Set the text that shows the _bestLap.
			_bestLapText.x = 196;
			_bestLapText.y = 168;
			_bestLapText.text = _lapTimer.toString();
			this._stageRef.addChild(_bestLapText);
			
			// Setting _lapCounter to 0.
			this._lapCounter = 0;
			
			// Set the text that shows which lap i currently being run.
			this._lapTextFormat.size = 20;
			this._lapText.defaultTextFormat = this._lapTextFormat;
			this._lapText.x = 180;
			this._lapText.y = 185;
			this._lapText.text = "Lap: " + String(this._lapCounter + 1);
			this._stageRef.addChild(_lapText);
			
			// Array to hold the lap times.
			_lapTimeArray = new Array();
			
			// As we havent started the timer yet, this is set to false.
			this._timerStarted = false;
			
			// Saving the passedCarClass in _ourCarClass for future use.
			this._ourCarClass = passedCarClass;
			
			// Making a new instance of the class recieved.
			this._ourCarUnrotated = new passedCarClass;
			
			// Setting the cars size accordingly to the Car object created.
			this._ourCarUnrotated.width = this._ourCar.length;
			this._ourCarUnrotated.height = this._ourCar.width;
			
			// Centering our car.
			this._ourCarUnrotated.x = -this._ourCarUnrotated.width/2;
			this._ourCarUnrotated.y = -this._ourCarUnrotated.height/2;
			
			/*
			 * Adding the car to the container that's going
			 * to be used to move and rotate the car image.
			 */
			this._ourCarImage.addChild(this._ourCarUnrotated);
			
			// Placing the car container accordingly to the Car object created.
			this._ourCarImage.x = this._ourCar.x;
			this._ourCarImage.y = this._ourCar.y;
			
			/*
			 * Setting the car images orientation
			 * so that it matches the car objects
			 * orientation.
			 */
			this._ourCarImage.rotation = this._ourCar.orientation;
			
			// Adding our car image to the stage.
			this._stageRef.addChild(this._ourCarImage);
			
			// Initilizing the RaceCountDown.
			this._raceCountDown = new RaceCountDown(this._stageRef);
			
			// Starting the RaceCountDown.
			this._raceCountDown.start();
			
			// Adding listener to wait for the count down to finish.
			addEventListener(Event.ENTER_FRAME, waitForCountDown);
		}
		
		/**
		 * This method waits for the countdown to finish. Then it starts
		 * the race.
		 */
		private function waitForCountDown(evt:Event):void {
			if(this._raceCountDown.countDownAtGo && !this._timerStarted) {
				startLapTimer();
				this._timerStarted = true;
			}
			if(this._raceCountDown.countDownIsFinish) {
				removeEventListener(Event.ENTER_FRAME, waitForCountDown);
				this._raceCountDown = null;
			}
		}
		
		/**
		 * This method draws the checkpoints in their respective Shape objects.
		 * @param color Int
		 * @param drawOne Boolean
		 * @param drawTwo Boolean
		 * @param drawThree Boolean
		 */
		private function drawCheckPoints(color:int, drawOne:Boolean, drawTwo:Boolean, drawThree:Boolean):void {
			
			if(getClassName(this._track) == "TrackOneClass") {
				if(drawOne) {
					this._checkPointOneShape.graphics.clear();
					this._checkPointOneShape.graphics.moveTo(400, 200);
					this._checkPointOneShape.graphics.lineStyle(8, color);
					this._checkPointOneShape.graphics.lineTo(510, 200);
				}
				if(drawTwo) {
					this._checkPointTwoShape.graphics.clear();
					this._checkPointTwoShape.graphics.moveTo(200, 120);
					this._checkPointTwoShape.graphics.lineStyle(8, color);
					this._checkPointTwoShape.graphics.lineTo(200, 8);
				}
				if(drawThree) {
					this._checkPointThreeShape.graphics.clear();
					this._checkPointThreeShape.graphics.moveTo(200, 380);
					this._checkPointThreeShape.graphics.lineStyle(8, color);
					this._checkPointThreeShape.graphics.lineTo(200, 470);
				}
			}
			if(getClassName(this._track) == "TrackTwoClass") {
				if(drawOne) {
					this._checkPointOneShape.graphics.clear();
					this._checkPointOneShape.graphics.moveTo(360, 240);
					this._checkPointOneShape.graphics.lineStyle(8, color);
					this._checkPointOneShape.graphics.lineTo(470, 240);
				}
				if(drawTwo) {
					this._checkPointTwoShape.graphics.clear();
					this._checkPointTwoShape.graphics.moveTo(200, 120);
					this._checkPointTwoShape.graphics.lineStyle(8, color);
					this._checkPointTwoShape.graphics.lineTo(200, 8);
				}
				if(drawThree) {
					this._checkPointThreeShape.graphics.clear();
					this._checkPointThreeShape.graphics.moveTo(200, 380);
					this._checkPointThreeShape.graphics.lineStyle(8, color);
					this._checkPointThreeShape.graphics.lineTo(200, 470);
				}
			}
			if(getClassName(this._track) == "TrackTreClass") {
				if(drawOne) {
					this._checkPointOneShape.graphics.clear();
					this._checkPointOneShape.graphics.moveTo(450, 150);
					this._checkPointOneShape.graphics.lineStyle(8, color);
					this._checkPointOneShape.graphics.lineTo(560, 150);
				}
				if(drawTwo) {
					this._checkPointTwoShape.graphics.clear();
					this._checkPointTwoShape.graphics.moveTo(200, 120);
					this._checkPointTwoShape.graphics.lineStyle(8, color);
					this._checkPointTwoShape.graphics.lineTo(200, 8);
				}
				if(drawThree) {
					this._checkPointThreeShape.graphics.clear();
					this._checkPointThreeShape.graphics.moveTo(250, 380);
					this._checkPointThreeShape.graphics.lineStyle(8, color);
					this._checkPointThreeShape.graphics.lineTo(250, 470);
				}
			}
		}
		
		/**
		 * This method starts both the _totalTimer and the _lapTimer, and
		 * adds an eventlistener to the onEnterFrame method.
		 */
		private function startLapTimer():void {
			_lapTimer.startTimer();
			_totalTime.startTimer();
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		/**
		 * This method checks the _lapCounter and sees if it is equal to 0, which
		 * indicates that we are on our first lap. If that's the case, the current
		 * _lapTime is set as _bestLap and is displayed in the _bestLapText TextField.
		 * If on the other hand we are not on our first lap, it checks if the current
		 * lap time is better than the previous one stored. If so, it is set as the
		 * _bestLap and displayed in the _bestLapText TextField. If none of the above
		 * conditions are met, the method resets the _lapTimer and sets the checkpoint
		 * passed Booleans to false. Also it redraws the checkpoints so the color is
		 * corrected and increase the _lapCounter.
		 * This function is only run, when all checkpoints are passed and the car is
		 * entering the finishLine Object.
		 */
		private function finishLineCross():void {
			if(_lapCounter < 1) {
				this._bestLap = {lap: this._lapCounter, milliseconds: this._lapTimer.millisecondsTotal, asString: this._lapTimer.toString()};
				this._bestLapText.text = _lapTimer.toString();
				this._lapTimer.resetTimer();
			} else if(_lapTimer.millisecondsTotal < this._bestLap.milliseconds) {
				this._bestLap = {lap: this._lapCounter, milliseconds: this._lapTimer.millisecondsTotal, asString: this._lapTimer.toString()};
				this._bestLapText.text = _lapTimer.toString();
				this._lapTimer.resetTimer();
			}
			
			// If _lapCounter equals 10 and we hit the finish line,
			// it means that the race is finish.
			if(_lapCounter == this._numberOfLaps){
				_totalTime.stopTimer();
				_lapTimer.stopTimer();
				this._lapText.text = "Lap: " + String(this._lapCounter + 1);
				this._totalRaceTime = {milliseconds: this._totalTime.millisecondsTotal, asString: this._totalTime.toString()};
				saveLapTimeToArray();
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				finishAnimation();
			} else {
				saveLapTimeToArray();
				this._lapTimer.resetTimer();
				_checkPointOnePassed = false;
				_checkPointTwoPassed = false;
				_checkPointThreePassed = false;
				drawCheckPoints(CHECK_POINT_NOT_PASSED, true, true, true);
				_lapCounter++;
				this._lapText.text = "Lap: " + String(this._lapCounter + 1);
			}
		}
		
		/**
		 * This method saves the lap time to an array. The times are
		 * saved in an object that also contains the lap number and
		 * the lap time in String form.
		 */
		private function saveLapTimeToArray():void {
			var timeObject:Object = {lap: this._lapCounter, timeTxt: this._lapTimer.toString(), timeMill: this._lapTimer.millisecondsTotal};
			this._lapTimeArray.push(timeObject);
		}
		
		/**
		 * This method returns true if the cars northPoint hits the finishLine object.
		 * Else it returns false.
		 */
		private function finishLineIsCrossed():Boolean {
			return _carCollisionTester.hitTester(this._finishLine, this._ourCarImage.localToGlobal(_ourCar.northPoint));
		}
		
		/**
		 * This method checks if the cars northPoint hits the _checkPointOneShap Object.
		 * If so, the _checkPointOnePassed Boolean is set to true and the _checkPointOneShape
		 * line is redrawn in the color red. 
		 */
		private function isCheckPointOneCrossed():void {
			if(this._checkPointOneShape.hitTestPoint(this._ourCarImage.localToGlobal(_ourCar.northPoint).x, this._ourCarImage.localToGlobal(_ourCar.northPoint).y)) {
				_checkPointOnePassed = true;
				drawCheckPoints(CHECK_POINT_PASSED, true, false, false);
			}
		}
		
		/**
		 * This method checks if the cars northPoint hits the _checkPointTwoShap Object.
		 * If so, the _checkPointTwoPassed Boolean is set to true and the _checkPointTwoShape
		 * line is redrawn in the color red. 
		 */
		private function isCheckPointTwoCrossed():void {
			if(this._checkPointTwoShape.hitTestPoint(this._ourCarImage.localToGlobal(_ourCar.northPoint).x, this._ourCarImage.localToGlobal(_ourCar.northPoint).y)) {
				_checkPointTwoPassed = true;
				drawCheckPoints(CHECK_POINT_PASSED, false, true, false);
			}
		}
		
		/**
		 * This method checks if the cars northPoint hits the _checkPointThreeShap Object.
		 * If so, the _checkPointThreePassed Boolean is set to true and the _checkPointThreeShape
		 * line is redrawn in the color red. 
		 */
		private function isCheckPointThreeCrossed():void {
			if(this._checkPointThreeShape.hitTestPoint(this._ourCarImage.localToGlobal(_ourCar.northPoint).x, this._ourCarImage.localToGlobal(_ourCar.northPoint).y)) {
				_checkPointThreePassed = true;
				drawCheckPoints(CHECK_POINT_PASSED, false, false, true);
			}
		}
		
		/*
		 * Returns true if the north point of the car hits the opaque part of our track image.
		 */
		private function northHit():Boolean {
			return _carCollisionTester.hitTester(this._track, this._ourCarImage.localToGlobal(_ourCar.northPoint)); 
		}
		
		/*
		 * Returns true if the south point of the car hits the opaque part of our track image.
		 */
		private function southHit():Boolean {
			return _carCollisionTester.hitTester(this._track, this._ourCarImage.localToGlobal(_ourCar.southPoint));
		}
		
		/*
		 * Returns true if the west point of the car hits the opaque part of our track image.
		 */
		private function westHit():Boolean {
			return _carCollisionTester.hitTester(this._track, this._ourCarImage.localToGlobal(_ourCar.westPoint));
		}
		
		/*
		 * Returns true if the east point of the car hits the opaque part of our track image.
		 */
		private function eastHit():Boolean {
			return _carCollisionTester.hitTester(this._track, this._ourCarImage.localToGlobal(_ourCar.eastPoint));
		}
		
		/*
		 * Returns true if any of the above methods return true, else it returns false.
		 */
		private function anyHits():Boolean {
			if(northHit() || southHit() || westHit() || eastHit()) {
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * This method...
		 * @param event Event
		 */
		private function onEnterFrame(event:Event):void {
			
			// Updating the timer texts.
			_timerText.text = _totalTime.toString();
			_lapTimerText.text = _lapTimer.toString();
			
			// Checking if we are crossing a checkpoint.
			if(!this._checkPointOnePassed) {
				isCheckPointOneCrossed();
			}
			if(!this._checkPointTwoPassed) {
				isCheckPointTwoCrossed();
			}
			if(!this._checkPointThreePassed) {
				isCheckPointThreeCrossed();
			}
			
			/*
			* All checkpoints has to be passed before it counts as crossing
			* the finish line.
			*/
			if(_checkPointOnePassed && _checkPointTwoPassed && _checkPointThreePassed) {
				/* 
			 	* If we are at the finish line and we were not on the
			 	* previous frame, that means we have just entered the finish
			 	* line. If on the other hand we are on the finish line and
			 	* we also were on the previous frame, that means we already
			 	* passed the finish line. In other words, in order to maintain
			 	* that we have just entered the finish line, finishLineIsCrossed
			 	* needs to return true and _finishLineWasEntered needs to be false.
			 	*/
				if(finishLineIsCrossed() && !_finishLineWasEntered) {
					finishLineCross();
				}
			}
			
			/*
			 * Set _finishLineWasEntered so that it equals the last result
			 * of finishLineIsCrossed().
			 */
			_finishLineWasEntered = finishLineIsCrossed();
			
			/*
			 * The following executes an action depending
			 * on which of the arrow-keys are pressed or
			 * of weather the car has hit something.
			 */
			if(!anyHits()) {
				if(_key.isDown(Keyboard.UP)) {
					_ourCar.accelerate();
					_ourCarImage.rotation = _ourCar.orientation;
				} else {
					_ourCar.frictionAirResistance();
				}
			} else {
				if(this._ourCar.speed > this._ourCar.maxSpeed/2) {
					_ourCar.pushBreak();
				} else if(this._ourCar.speed < this._ourCar.maxSpeed/2) {
					_ourCar.accelerate();
				}
				if(westHit()) {
					_ourCar.turnRight();
					_ourCar.turnRight();
					_ourCarImage.rotation = _ourCar.orientation;
				} else if(eastHit()) {
					_ourCar.turnLeft();
					_ourCar.turnLeft();
					_ourCarImage.rotation = _ourCar.orientation;
				}	
			}
			if(_key.isDown(Keyboard.DOWN)) {
				_ourCar.pushBreak();
				_ourCarImage.rotation = _ourCar.orientation;
			} else if(_key.isDown(Keyboard.LEFT)) {
				_ourCar.turnLeft();
				_ourCarImage.rotation = _ourCar.orientation;
			} else if(_key.isDown(Keyboard.RIGHT)) {
				_ourCar.turnRight();
				_ourCarImage.rotation = _ourCar.orientation;
			} else if(!_key.isDown(Keyboard.UP)){
				_ourCar.frictionAirResistance();
			}
			
			// Moves the car and replaces the car image.
			_ourCar.move();
			_ourCarImage.x = _ourCar.x;
			_ourCarImage.y = _ourCar.y;
		}
		
		/**
		 * Starts the finish animation when the car has
		 * completed 10 laps.
		 */
		private function finishAnimation():void {
			clearTrack();
			this._raceIsFinish = true;
		}
		
		/**
		 * This method returns the status of the race. If 10
		 * laps has been completed it returns true, else it
		 * returns false.
		 * @return _raceIsFinish Boolean
		 */
		public function get raceIsFinish():Boolean {
			return this._raceIsFinish;
		}
		
		/**
		 * This method returns the _lapTimeArray which
		 * contains the lap times of the race.
		 * @return _lapTimeArray Array
		 */
		public function get lapTimeArray():Array {
			return _lapTimeArray;
		}
		
		/**
		 * This method returns the Object that contains
		 * information on the total race time.
		 * @return _totalRaceTime Object
		 */
		public function get totalTime():Object {
			return _totalRaceTime;
		}
		
		/**
		 * This method returns the Object that contains
		 * information on the bet lap time.
		 * @return _bestLap Object 
		 */
		public function get bestTime():Object {
			return _bestLap;
		}
		
		/**
		 * This method returns the car image Class.
		 * That is the Class that contains the image
		 * of the car being driven.
		 * @return _ourCarClass Class
		 */
		public function get theCar():Class {
			return _ourCarClass;
		}
		
		/**
		 * This method returns the name of the Class that the
		 * given object belongs too.
		 * @param obj Object
		 * @return String
		 */
		private function getClassName(obj:Object):String {
			var fullClassName:String = getQualifiedClassName(obj);
			return fullClassName.slice(fullClassName.lastIndexOf("_") + 1);
			
		}
		
		/**
		 * This method clears all children from the stage.
		 */
		private function clearTrack():void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this._stageRef.removeChild(_track);
			this._track = null;
			this._stageRef.removeChild(_finishLine);
			this._finishLine = null;
			this._stageRef.removeChild(_ourCarImage);
			this._ourCarImage = null;
			this._stageRef.removeChild(_timerText);
			this._timerText = null;
			this._stageRef.removeChild(_lapTimerText);
			this._lapTimerText = null;
			this._stageRef.removeChild(_bestLapText);
			this._bestLapText = null;
			this._stageRef.removeChild(_lapText);
			this._lapText = null;
			this._stageRef.removeChild(_checkPointOneShape);
			this._checkPointOneShape = null;
			this._stageRef.removeChild(_checkPointTwoShape);
			this._checkPointTwoShape = null;
			this._stageRef.removeChild(_checkPointThreeShape);
			this._checkPointThreeShape = null;
		}
	}
}
