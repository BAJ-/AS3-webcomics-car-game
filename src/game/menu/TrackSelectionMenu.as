/**
 * @author Bjorn Allan Johansen
 * @date 11.09.2011
 * @version 1.0
 */
package game.menu {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
	import utils.SpringBehaviour;
		
	public class TrackSelectionMenu extends Sprite{
		
		// Track graphics being embeded \\
		
		// The square where the selected track is displayed.
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/selectSquare.svg")]
    	private var SelectSquareClass:Class;
    	private var _selectSquare:Sprite = new SelectSquareClass();
		
		// The background graphics for the track selection menu.
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/trackMenu.svg")]
    	private var TrackMenuClass:Class;
    	private var _trackMenu:Sprite = new TrackMenuClass();
		
		// Track one.
		[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/track1.svg")]
    	private var TrackOneClass:Class;
    	private var _track1:Sprite = new TrackOneClass();
    	
    	// Road one.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/road1.svg")]
    	private var RoadOneClass:Class;
    	private var _road1:Sprite = new RoadOneClass();
    	
    	// Track two.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/track2.svg")]
    	private var TrackTwoClass:Class;
    	private var _track2:Sprite = new TrackTwoClass();
    	
    	// Road two.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/road2.svg")]
    	private var RoadTwoClass:Class;
    	private var _road2:Sprite = new RoadTwoClass();
    	
    	// Track three.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/track3.svg")]
    	private var TrackTreClass:Class;
    	private var _track3:Sprite = new TrackTreClass();
    	
    	// Road three.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/road3.svg")]
    	private var RoadTreClass:Class;
    	private var _road3:Sprite = new RoadTreClass();
    	
    	// Small track display picture for Track One.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/t1select.svg")]
    	private var T1SelectClass:Class;
    	private var _t1Select:Sprite = new T1SelectClass();
    	
    	// Small track display picture for Track Two.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/t2select.svg")]
    	private var T2SelectClass:Class;
    	private var _t2Select:Sprite = new T2SelectClass();
    	
    	// Small track display picture for Track Three.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/t3select.svg")]
    	private var T3SelectClass:Class;
    	private var _t3Select:Sprite = new T3SelectClass();
    	
    	// The "start game" button.
    	[Embed(source="/home/kermit/FlashWorkspace/WebcomicstripCarGame/src/game/svg/startGame.svg")]
    	private var StartGameKeyClass:Class;
    	private var _startGameKey:Sprite = new StartGameKeyClass();
    	
    	private var _trackOneContainer:Sprite = new Sprite();
    	private var _trackTwoContainer:Sprite = new Sprite();
    	private var _trackTreContainer:Sprite = new Sprite();
    	
    	private var OurSelectedTrack:Class;
    	
    	private var RoadForSelectedTrack:Class;
		
		// Variable to indicate if a track has been selected or not.
		private var _trackIsSelected:Boolean;
		
		// Initilizing SpringBehaviour objects.
		private var _track1Spring:SpringBehaviour;
		private var _track2Spring:SpringBehaviour;
		private var _track3Spring:SpringBehaviour;
			
		// Creating a stage variable.
		private var _stageRef:Stage;
		
		// We want the track images to be 25% of their original size.
		private const TRACK_ROAD_SCALE:Number = 0.25;
		// Track images gab.
		private const TRACK_ROAD_IMAGES_GAB:Number = 60;
		// Their width will then be 160.
		private const TRACK_ROAD_WIDTH:Number = 160;
		// Defining a button margen.
		private const BUTTON_MARGEN:Number = 80;
		
		// SPRING BEHAVIOUR CONSTANTS \\
		// Spring strength
		private const SPRING_STRENGTH:Number = 0.7;
		private const VELOCITY_X:Number = 0.2;
		private const VELOCITY_Y:Number = 0.2;
		private const FRICTION:Number = 0.7;
		private const TARGET_X:Number = 1;
		private const TARGET_Y:Number = 1;
		
		/**
		 * Constructor for the TrackSelectionMenu Class.
		 * @param stageRef Stage
		 */
		public function TrackSelectionMenu(stageRef:Stage) {
			
			// Setting stage reference.
			this._stageRef = stageRef;
			
			this._trackIsSelected = false;
			
			startTrackMenu();
		}
		
		/**
		 * This method sets up the track selection menu by running the
		 * setupTracks method, adding the necessary listeners and
		 * placing the _startGameKey.
		 */
		private function startTrackMenu():void {
			this._trackMenu.x = 0;
			this._trackMenu.y = 0;
			this._stageRef.addChild(this._trackMenu);
			
			this._selectSquare.scaleX = 1.1;
			this._selectSquare.scaleY = 1.1;
			this._selectSquare.x = (this._stageRef.stageWidth - this._selectSquare.width)/2;
			this._selectSquare.y = (this._stageRef.stageHeight - this._selectSquare.height/2)/2;
			this._stageRef.addChild(this._selectSquare);
			
			setupTracks();
			this._trackOneContainer.addEventListener(MouseEvent.CLICK, trackSelectRespond);
			this._trackTwoContainer.addEventListener(MouseEvent.CLICK, trackSelectRespond);
			this._trackTreContainer.addEventListener(MouseEvent.CLICK, trackSelectRespond);
			
			addEventListener(Event.ENTER_FRAME, trackSpringOne);
			addEventListener(Event.ENTER_FRAME, trackSpringTwo);
			addEventListener(Event.ENTER_FRAME, trackSpringTre);
			
			// Place the "start game" button.
			this._startGameKey.x = this._stageRef.stageWidth/2 - this._startGameKey.width/2;
			this._startGameKey.y = this._stageRef.stageHeight - BUTTON_MARGEN;
			this._stageRef.addChild(this._startGameKey);
			this._startGameKey.addEventListener(MouseEvent.CLICK, startGameRespond);
		}
		
		/**
		 * This method sets up the tracks on the screen and append them
		 * all with their own SpringBehaviour Object.
		 */
		private function setupTracks():void {
			/*
			 * Here we scale all the images so that they are 25% their original size,
			 * and center them in the container.
			 */
			for each(var trackRoadObject:Sprite in [this._road1, this._track1, this._road2, this._track2, this._road3, this._track3]) {
				trackRoadObject.scaleX = TRACK_ROAD_SCALE;
				trackRoadObject.scaleY = TRACK_ROAD_SCALE;
				trackRoadObject.x = -TRACK_ROAD_WIDTH/2;
				trackRoadObject.y = -TRACK_ROAD_WIDTH/2;
			}
			
			this._trackOneContainer.addChild(this._road1);
			this._trackOneContainer.addChild(this._track1);
			this._trackTwoContainer.addChild(this._road2);
			this._trackTwoContainer.addChild(this._track2);
			this._trackTreContainer.addChild(this._road3);
			this._trackTreContainer.addChild(this._track3);
			
			this._trackOneContainer.x = (this._stageRef.stageWidth - TRACK_ROAD_IMAGES_GAB - 2*TRACK_ROAD_WIDTH)/2;
			this._trackOneContainer.y = this._stageRef.stageHeight/4;
			this._stageRef.addChild(this._trackOneContainer);
			
			this._trackTwoContainer.x = (this._stageRef.stageWidth)/2;
			this._trackTwoContainer.y = this._stageRef.stageHeight/4;
			this._stageRef.addChild(this._trackTwoContainer);
			
			this._trackTreContainer.x = (this._stageRef.stageWidth + TRACK_ROAD_IMAGES_GAB + 2*TRACK_ROAD_WIDTH)/2;
			this._trackTreContainer.y = this._stageRef.stageHeight/4;
			this._stageRef.addChild(this._trackTreContainer);
			
			this._track1Spring = new SpringBehaviour(SPRING_STRENGTH, VELOCITY_X, VELOCITY_Y, FRICTION, TARGET_X, TARGET_Y, this._trackOneContainer.scaleX, this._trackOneContainer.scaleY);
			this._track2Spring = new SpringBehaviour(SPRING_STRENGTH, VELOCITY_X, VELOCITY_Y, FRICTION, TARGET_X, TARGET_Y, this._trackTwoContainer.scaleX, this._trackTwoContainer.scaleY);
			this._track3Spring = new SpringBehaviour(SPRING_STRENGTH, VELOCITY_X, VELOCITY_Y, FRICTION, TARGET_X, TARGET_Y, this._trackTreContainer.scaleX, this._trackTreContainer.scaleY);
			
			for each(var container:Sprite in [_trackOneContainer, _trackTwoContainer, _trackTreContainer, _startGameKey]) {
				container.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond, false, 0, true);
			}
			
			for each(var trackSelect:Sprite in [_t1Select, _t2Select, _t3Select]) {
				trackSelect.x = (this._stageRef.stageWidth - 160)/2;
				trackSelect.y = (this._stageRef.stageHeight - 58)/2;
				trackSelect.visible = false;
				this._stageRef.addChild(trackSelect);
			}
		}
		
		/**
		 * This method is activated when the mouse passes over one of the
		 * object on the screen, and takes the appropriate actions.
		 * @param evt MouseEvent
		 */
		private function mouseOverRespond(evt:MouseEvent):void {
			Mouse.cursor = "button";
			switch(evt.currentTarget) {
				case _trackOneContainer:
					this._track1Spring.reset();
					this._trackOneContainer.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
					this._trackOneContainer.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond, false, 0, true);
					break;
				case _trackTwoContainer:
					this._track2Spring.reset();
					this._trackTwoContainer.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
					this._trackTwoContainer.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond, false, 0, true);
					break;
				case _trackTreContainer:
					this._track3Spring.reset();
					this._trackTreContainer.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
					this._trackTreContainer.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond, false, 0, true);
					break;
				case _startGameKey:
					this._startGameKey.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
					this._startGameKey.addEventListener(MouseEvent.ROLL_OUT, mouseOutRespond, false, 0, true);
			}
		}
		
		/**
		 * This method is activated whenever the mouse exits one of the
		 * objects on the stage.
		 * @param evt MouseEvent
		 */
		private function mouseOutRespond(evt:MouseEvent):void {
			Mouse.cursor = "auto";
			for each(var container:Sprite in [_trackOneContainer, _trackTwoContainer, _trackTreContainer, _startGameKey]) {
				container.removeEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
				container.addEventListener(MouseEvent.ROLL_OVER, mouseOverRespond, false, 0, true);
			}
		}
		
		/**
		 * This method runs the spring object that affects
		 * _trackOneContainer and roadOneContainer.
		 * @param evt Event
		 */
		private function trackSpringOne(evt:Event):void {
			this._track1Spring.run();
			this._trackOneContainer.scaleY = this._track1Spring.newPosX;
			this._trackOneContainer.scaleX = this._track1Spring.newPosY;
		}
		
		/**
		 * This method runs the spring object that affects
		 * _trackTwoContainer and _roadTwoContainer.
		 * @param evt Event
		 */
		private function trackSpringTwo(evt:Event):void {
			this._track2Spring.run();
			this._trackTwoContainer.scaleY = this._track2Spring.newPosX;
			this._trackTwoContainer.scaleX = this._track2Spring.newPosY;
		}
		
		/**
		 * This method runs the spring object that affects
		 * _trackTreContainer and roadTreContainer.
		 * @param evt Event
		 */
		private function trackSpringTre(evt:Event):void {
			this._track3Spring.run();
			this._trackTreContainer.scaleY = this._track3Spring.newPosX;
			this._trackTreContainer.scaleX = this._track3Spring.newPosY;
		}
		
		/**
		 * This method is run when one of the tracks are clicked.
		 * Depending on which track is clicked, it responds.
		 * @param evt MouseEvent
		 */
		private function trackSelectRespond(evt:MouseEvent):void {
			
			this._t1Select.visible = false;
			this._t2Select.visible = false;
			this._t3Select.visible = false;
			
			switch(evt.currentTarget) {
				case _trackOneContainer:
					this.OurSelectedTrack = this.TrackOneClass;
					this.RoadForSelectedTrack = this.RoadOneClass;
					this._t1Select.visible = true;
					break;
				case _trackTwoContainer:
					this.OurSelectedTrack = this.TrackTwoClass;
					this.RoadForSelectedTrack = this.RoadTwoClass;
					this._t2Select.visible = true;
					break;
				case _trackTreContainer:
					this.OurSelectedTrack = this.TrackTreClass;
					this.RoadForSelectedTrack = this.RoadTreClass;
					this._t3Select.visible = true;
					break;
			}
		}
		
		/**
		 * This method is run when the _startGameKey is clicked,
		 * and will set everything up so the game is ready to run.
		 * @param evt MouseEvent
		 */
		private function startGameRespond(evt:MouseEvent):void {
			clearStage();
			this._trackIsSelected = true;
		}
		
		/**
		 * This method returns the selected track class.
		 * @return OurSelectedTrack Class
		 */
		public function get selectedTrack():Class {
			return this.OurSelectedTrack;
		}
		
		/**
		 * This method returns the road the follows the
		 * selected track class.
		 * @return RoadForSelectedTrack Class
		 */
		public function get trackRoad():Class {
			return this.RoadForSelectedTrack;
		}
		
		/**
		 * This method returns true or false depending
		 * on if a track has been selected.
		 * @return _trackIsSelected Boolean
		 */
		public function get trackIsSelected():Boolean {
			return this._trackIsSelected;
		}
		
		private function clearStage():void {
			for each (var container:Sprite in [_trackOneContainer, _trackTwoContainer, _trackTreContainer, _startGameKey]) {
				container.removeEventListener(MouseEvent.CLICK, trackSelectRespond);
				container.removeEventListener(MouseEvent.ROLL_OVER, mouseOverRespond);
				container.removeEventListener(MouseEvent.ROLL_OUT, mouseOutRespond);
			}
			removeEventListener(Event.ENTER_FRAME, trackSpringOne);
			removeEventListener(Event.ENTER_FRAME, trackSpringTwo);
			removeEventListener(Event.ENTER_FRAME, trackSpringTre);
			this._trackOneContainer.removeChild(this._track1);
			this._trackOneContainer.removeChild(this._road1);
			this._trackTwoContainer.removeChild(this._track2);
			this._trackTwoContainer.removeChild(this._road2);
			this._trackTreContainer.removeChild(this._track3);
			this._trackTreContainer.removeChild(this._road3);
			
			for each (var containerNull:Sprite in [_track1, _road1, _track2, _road2, _track3, _road3]) {
				containerNull = null;
			}
			
			for each (var containerRemove:Sprite in [_selectSquare, _trackMenu, _t1Select, _t2Select, _t3Select, _startGameKey, _trackOneContainer, _trackTwoContainer, _trackTreContainer]) {
				this._stageRef.removeChild(containerRemove);
				containerRemove = null;
			}
			
			this._track1Spring = null;
			this._track2Spring = null;
			this._track3Spring = null;
			
			for each (var containerClassNull:Class in [SelectSquareClass, TrackMenuClass, T1SelectClass, T2SelectClass, T3SelectClass, StartGameKeyClass]) {
				containerClassNull = null;
			}
		}
	}

}