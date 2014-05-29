/**
 * This is the main class of the Webcomicstrips.net Racing game. It's a
 * top view classical racing game of 10 laps. The player choose a car
 * to begin with, and then it just about going around the track as fast
 * as possible.
 * First of this Class starts the Webcomicstrips.net intro animation.
 * When that's finished, the car selection menu is started. When the
 * player has selected a car and presses the "start game" buttom, the
 * track object will be started. Now this Class waits and listens for
 * the game to finish. When it's finish it starts op the "race results"
 * display, where the player can se her or his race results, and choose
 * to restart the game. If the "restart game" buttom is pressed, the
 * car selection menu will be displayed again, and the game is starting
 * over.
 *
 * @author Bjorn Allan Johansen
 * @version 1.0 
 */
package game {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import game.animation.WebcomicstripsIntro;
	import game.menu.CarMenu;
	import game.menu.AboutUs;
	import game.menu.TrackSelectionMenu;
	import game.menu.RaceResult;
	import flash.text.TextField;
		
	[SWF(width="640", height="480", frameRate="60", backgroundColor="#FFFFFF")]
	public class Main extends Sprite {

		// Webcomicstrips intro object which will be used to run the intro.
		private var _intro:WebcomicstripsIntro;
		
		// Car selection menu Object.
		private var _carMenu:CarMenu;

		private var _aboutUs:AboutUs;

		// Track selection menu Object.
		private var _trackSelectionMenu:TrackSelectionMenu;
		
		// Race Object.
		private var _race:Race;
		
		// RaceResult Object.
		private var _raceResult:RaceResult;
		
		/**
		 * Constructor for class Main.
		 */
		public function Main() {

			// Starts the Webcomicstrips.net introduction.
			this._intro = new WebcomicstripsIntro(stage)
			this._intro.runIntro();
			addEventListener(Event.ENTER_FRAME, waitForIntroToFinish);
		}
		
		/**
		 * This method waits for the intro to finish. When that happens
		 * it starts the car selection menu, by running the carMenu
		 * method.
		 * @param event Event
		 */
		private function waitForIntroToFinish(event:Event):void {
		
			if(this._intro.isFinish) {
				removeEventListener(Event.ENTER_FRAME, waitForIntroToFinish);
				/*
				 * We no longer need the intro, so we set it to null
				 * so that it can be terminated by Flash garbage
				 * collection.
				 */
				this._intro = null;
				carMenu();
			}
			 
		}
		
		/**
		 * This method starts up the car selection menu, and
		 * adds an event listener to the waitForCarSelect
		 * method.
		 */
		private function carMenu():void {
			this._carMenu = new CarMenu(stage);
			this._carMenu.runCarMenu();
			addEventListener(Event.ENTER_FRAME, waitForCarSelect);
		}
		
		/**
		 * This method waits for the player to select a car
		 * whereafter it starts the track selection menu
		 * by running the trackMenu method.
		 * @param evt Event
		 */
		private function waitForCarSelect(evt:Event):void {
			if(this._carMenu.carIsSelected) {
				removeEventListener(Event.ENTER_FRAME, waitForCarSelect);
				trackMenu();
			}
			if(this._carMenu.aboutUsIsClicked) {
				removeEventListener(Event.ENTER_FRAME, waitForCarSelect);
				aboutUsScreen();
			}
		}
		
		private function aboutUsScreen():void {
			this._aboutUs = new AboutUs(stage);
			this._aboutUs.runInfo();
			addEventListener(Event.ENTER_FRAME, waitForAboutUsBackKey);
		}
		
		private function waitForAboutUsBackKey(evt:Event):void {
			if(this._aboutUs.backIsClicked) {
				removeEventListener(Event.ENTER_FRAME, waitForAboutUsBackKey);
				this._aboutUs = null;
				this._carMenu.unPause();
				addEventListener(Event.ENTER_FRAME, waitForCarSelect);
			}
		}
		
		/**
		 * This method starts the track selection menu and adds
		 * a listener to the waitForTrackSelect method.
		 */
		private function trackMenu():void {
				this._trackSelectionMenu = new TrackSelectionMenu(stage);
				addEventListener(Event.ENTER_FRAME, waitForTrackSelect);
		}
		
		/**
		 * This method waits for at track to be selected. When that
		 * happens, its starts the game, by running the startGame
		 * method.
		 * @param evt Event
		 */
		private function waitForTrackSelect(evt:Event):void {
			if(this._trackSelectionMenu.trackIsSelected) {
				removeEventListener(Event.ENTER_FRAME, waitForTrackSelect);
				startGame();
			}
		}
		
		/**
		 * This method starts the game by creating an instance of the
		 * Race Class. It also adds an event listener to the
		 * waitForRaceToFinish method.
		 * @param evt Event
		 */
		private function startGame():void {
			this._race = new Race(stage, this._carMenu.selectedCar, this._trackSelectionMenu.selectedTrack, this._trackSelectionMenu.trackRoad);
			this._trackSelectionMenu = null;
			this._carMenu = null;
			addEventListener(Event.ENTER_FRAME, waitForRaceToFinish);
		}
		
		/**
		 * This method waits for the race to finish, whereafter it
		 * starts the result menu by running the startResultMenu method.
		 */
		private function waitForRaceToFinish(evt:Event):void {
			if(this._race.raceIsFinish) {
				removeEventListener(Event.ENTER_FRAME, waitForRaceToFinish);
				startResultMenu();
			}
		}
		
		/**
		 * This method starts up the _raceResult Object. That will start
		 * the menu that shows that stats from the race, and
		 * give the player the oppotunity to restart the game.
		 * It also adds a listener to the waitForRespond method.
		 * @param evt Event
		 */
		private function startResultMenu():void {
				this._raceResult = new RaceResult(stage, this._race.lapTimeArray, this._race.totalTime, this._race.bestTime, this._race.theCar);
				addEventListener(Event.ENTER_FRAME, waitForRespond);
				this._race = null;
		}
		
		/**
		 * This method listens for the player to choose to restart
		 * the game. If nothing is done, the result menu will
		 * keep being displayed. If the game is restarted,
		 * the eventListener is removed from this method and
		 * a new one is added to the startMenu method.
		 * @param evt Event
		 */
		private function waitForRespond(evt:Event):void {
			if(this._raceResult.restartRace) {
				removeEventListener(Event.ENTER_FRAME, waitForRespond);
				carMenu();
			}
		}
	}
}