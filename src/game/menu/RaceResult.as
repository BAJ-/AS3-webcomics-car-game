/**
 * @author Bjørn Allan Johansen
 */
package game.menu {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
		
	public class RaceResult extends Sprite{
		
		// Stage reference.
		private var _stageRef:Stage;
		
		// Embed the images used by the RaceResult Class.
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/raceResults.svg")]
    	private var RaceResultsClass:Class;
    	private var _raceResultsImage:Sprite = new RaceResultsClass();
    	
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/restartGame.svg")]
    	private var RestartGameClass:Class;
    	private var _restartGameImage:Sprite = new RestartGameClass();
		
		// Boolean that tells if the game is to be restarted.
		private var _restartGame:Boolean;
		
		// Array that will hold all the lap times.
		private var _lapTimesArray:Array;
		
		// Best lap and total time text with a TextFormat.
		private var _bestLapText:TextField = new TextField();
		private var _totalTimeText:TextField = new TextField();
		private var _allTextFormat:TextFormat = new TextFormat();
		
		// Lap times text with TextFormat.
		private var _lapTimeText:TextField = new TextField();
		private var _lapTimeTextFormat:TextFormat = new TextFormat();
		
		/*
		 * Holds the total race time in milliseconds and an uint variable
		 * and also as a String formated to minutes/seconds/hundreds.
		 */
		private var _totalTime:Object;
		
		/*
		 * Holds the best lap time in milliseconds and an uint variable
		 * and also as a String formated to minutes/seconds/hundreds.
		 */
		private var _bestLap:Object;
		
		// Will be an instance of the passed car image Class.
		private var _theCarUnrotated:Sprite;
		
		// Sprite to hold and rotate the car Image.
		private var _theCar:Sprite = new Sprite();
		
		// Constants
		private const CIRCLE_CENTER:uint = 80;
		private const CAR_WIDTH:uint = 55;
		private const CAR_HEIGHT:uint = 35;
		private const BEST_TIMES_X_POSITION:uint = 512;
		
		
		/**
		 * Constructor for class RaceResult.
		 * @param stageRef Stage
		 * @param lapTimes Array
		 * @param totalTime Object
		 * @param bestLap Object
		 * @param theCarClass Class
		 */		
		public function RaceResult(stageRef:Stage, lapTimes:Array, totalTime:Object, bestLap:Object, theCarClass:Class) {
			
			// Set stage reference.
			this._stageRef = stageRef;
			
			/*
			 * We don't want to start out restarting the game,
			 * we set it to false.
			 */
			this._restartGame = false;
			
			// Setting text format for best and total time text.
			this._allTextFormat.size = 18;
			this._bestLapText.defaultTextFormat = this._allTextFormat;
			this._totalTimeText.defaultTextFormat = this._allTextFormat;
			
			// Setting text and format for lap times text.
			this._lapTimeTextFormat.size = 14
			this._lapTimeText.defaultTextFormat = this._lapTimeTextFormat;
			
			// Setting the background image for StageResults.
			this._raceResultsImage.x = 0;
			this._raceResultsImage.y = 0;
			this._stageRef.addChild(this._raceResultsImage);
			
			// Setting the restart buttom.
			this._restartGameImage.x = this._stageRef.stageWidth/2 -122.5;
			this._restartGameImage.y = 400;
			this._stageRef.addChild(this._restartGameImage);
			this._restartGameImage.addEventListener(MouseEvent.CLICK, clickRespond, false, 0, true);
			this._restartGameImage.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond, false, 0, true);
			this._restartGameImage.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond, false, 0, true);
			
			// Setting up and displaying lap times.
			this._lapTimesArray = new Array();
			this._lapTimesArray = lapTimes;
			displayLapTimes();
			
			// Setting up and displaying total time.
			this._totalTime = totalTime;
			displayTotalTime();
			
			// Setting up and displaying best lap time.
			this._bestLap = bestLap;
			displayBestLap();
			
			// Setting up and displaying the car image.
			this._theCarUnrotated = new theCarClass;
			displayCar();
		}
		
		/**
		 * This method displays the lap times on the stage.
		 */
		private function displayLapTimes():void {
			_lapTimeText.x = 100;
			_lapTimeText.y = 196;
			_lapTimeText.height = 180;
			_lapTimeText.width = 110;
			for(var i:uint = 0; i < this._lapTimesArray.length; i++) {
				if(i < this._lapTimesArray.length - 1) {
					_lapTimeText.appendText("." + (this._lapTimesArray[i].lap+1) + ": " + this._lapTimesArray[i].timeTxt + "\n");
				} else {
					_lapTimeText.appendText((this._lapTimesArray[i].lap+1) + ": " + this._lapTimesArray[i].timeTxt + "\n");
				}
			}
							   
			this._stageRef.addChild(_lapTimeText);
		}
		
		/**
		 * This method displays the total time the race took.
		 */
		private function displayTotalTime():void {
			_totalTimeText.x = BEST_TIMES_X_POSITION;
			_totalTimeText.y = 292;
			_totalTimeText.width = 100;
			_totalTimeText.height = 25;
			_totalTimeText.text = String(this._totalTime.asString);
			this._stageRef.addChild(_totalTimeText);
		}
		
		/**
		 * This method displays the best lap-time on stage.
		 */
		private function displayBestLap():void {
			_bestLapText.x = BEST_TIMES_X_POSITION;
			_bestLapText.y = 180;
			_bestLapText.width = 100;
			_bestLapText.height = 25;
			_bestLapText.text = String(this._bestLap.asString);
			this._stageRef.addChild(_bestLapText);
		}
		
		/**
		 * This method displays the car that was driven.
		 */
		private function displayCar():void {
			this._theCarUnrotated.width = CAR_WIDTH;
			this._theCarUnrotated.height = CAR_HEIGHT;
			this._theCarUnrotated.x = -this._theCarUnrotated.width/2;
			this._theCarUnrotated.y = -this._theCarUnrotated.height/2;
			this._theCar.addChild(this._theCarUnrotated);
			this._theCar.x = this._stageRef.width/2;
			this._theCar.y = CIRCLE_CENTER;
			this._stageRef.addChild(this._theCar);
			addEventListener(Event.ENTER_FRAME, rotateCar);
		}
		
		/**
		 * Method that rotates the car image.
		 */
		private function rotateCar(evt:Event):void {
			this._theCar.rotation++;
		}
		
		/**
		 * This method responds to mouse clicks on the restartRaceImage
		 * Object.
		 */
		private function clickRespond(mouseEvt:MouseEvent):void {
			clearStage();
			this._restartGame = true;
		}
		
		/**
		 * This method reacts to the mouse cursor passing over
		 * an object that has a ROLL_OVER mouse event connected
		 * to it.
		 * @param mevt MouseEvent
		 */
		private function mouseOverRespond(mevt:MouseEvent):void {
			Mouse.cursor = "button";
		}
		
		/**
		 * This method reacts to the mouse cursor passing out
		 * an object that has a ROLL_OUT mouse event connected
		 * to it.
		 * @param mevt MouseEvent
		 */
		private function mouseOutRespond(mevt:MouseEvent):void {
			Mouse.cursor = "auto";
		}
		
		/**
		 * This method returns the boolean value _restartGame,
		 * which determin if the game is to be restarted or not.
		 * @return _restartGame Boolean
		 */
		public function get restartRace():Boolean {
			return _restartGame;
		}
		
		/**
		 * This method clears the stage.
		 */
		private function clearStage():void {
			this._restartGameImage.addEventListener(MouseEvent.CLICK, clickRespond);
			this._restartGameImage.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
			this._restartGameImage.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			this._stageRef.removeChild(this._raceResultsImage);
			this._raceResultsImage = null;
			this._stageRef.removeChild(this._restartGameImage);
			this._restartGameImage = null;
			this._stageRef.removeChild(_lapTimeText);
			this._lapTimeText = null;
			this._stageRef.removeChild(_totalTimeText);
			this._totalTimeText = null;
			this._stageRef.removeChild(_bestLapText);
			this._bestLapText = null;
			this._stageRef.removeChild(this._theCar);
			this._theCarUnrotated = null;
			this._theCar = null;
			this._totalTime = null;
			this._bestLap = null;
		}
	}
}
