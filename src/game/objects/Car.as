/**
 * @author Bjorn Allan Johansen
 * @version as3 v1.5: 11-08-2011
 */
package game.objects {
	
	import utils.Vector2D;
	import flash.geom.Point;
		
	public class Car {
		
		// As the car has direction it's position is a 2D vector.
		private var carPosition:Vector2D;
		
		// The cars velocity is represented by a 2D vector.
		private var carVelocity:Vector2D;
		
		// The cars acceleration is represented by a 2D vector.
		private var carAcceleration:Vector2D;
		
		// Collision point for the car.
		private var _pointSouth:Point;
		private var _pointNorth:Point;
		private var _pointWest:Point;
		private var _pointEast:Point;
		
		private var carMaxSpeed:Number;
		
		private var carOrientation:Number;
		
		private var carWidth:Number;
		private var carLength:Number;
		
		// Class constants \\
		private const accelerationConstant:Number = 0.2;
		private const carMinSpeed:Number = 0.3;
		private const turnAngleConstant:Number = 1.2;
		private const breakSpeedScaling:Number = 0.85;
		private const frictionSpeedScaling:Number = 0.96;
			
		/**
		 * Constructor for the class Car. It constructs a Car
		 * at the given position with the given orientation.
		 * The orientation is as follows:
		 *			  NORTH(90)
		 *				  |
		 * WEST(180)------+------EAST(0)
		 *				  |
		 *			  SOUTH(270)
		 *
		 * @param xPos
		 * @param yPos
		 * @param orientationDegree
		 * @param maxSpeed
		 * @param width
		 * @param length
		 */
		public function Car(xPos:Number, yPos:Number, orientationDegree:Number, maxSpeed:Number, width:Number, length:Number) {
				
			this.carWidth = width;
			this.carLength = length;
			
			// Setting the collision points for the car.
			_pointWest = new Point(0, -this.carWidth/2);
			_pointEast = new Point(0, this.carWidth/2);
			_pointNorth = new Point(this.carLength/2, 0);
			_pointSouth = new Point(-this.carLength/2, 0);
			
			// Setting the cars maximum speed.
			this.carMaxSpeed = maxSpeed;
			
			// The car starts standing still.
			carVelocity = new Vector2D(0, 0);
			
			// Setting the cars position on the screen
			carPosition = new Vector2D(xPos, yPos)
			
			// giving the car orientation
			this.carOrientation = orientationDegree;
			
			// Declaring the acceleration vector and adjusting it to the cars orientation.
			carAcceleration = new Vector2D(accelerationConstant, 0);
			carAcceleration.rotateDegree(carOrientation);
		}
		
		// Car get methods \\
		
		public function get southPoint():Point {
			return _pointSouth;
		}
		
		public function get northPoint():Point {
			return _pointNorth;
		}
		
		public function get westPoint():Point {
			return _pointWest;
		}
		
		public function get eastPoint():Point {
			return _pointEast;
		}
		
		/**
		 * Implicit getter method, that returns the cars
		 * speed, which corrorspond to the length of the
		 * carVelocity vector.
		 * @return carVelocity.length
		 */
		public function get speed():Number {
			return carVelocity.length;
		}
		
		/**
		 * Implicit getter method, that returns the orientation
		 * of the car. That is, the number of degrees it diverts
		 * counter clockwise from facing stright east.
		 */
		public function get orientation():Number {
			return carOrientation;
		}
		
		public function get x():Number {
			return carPosition.x;
		}
		
		public function get y():Number {
			return carPosition.y;
		}
		
		/**
		 * This method returns the carPosition Vector.
		 * @return carPosition
		 */
		public function get position():Vector2D {
			return carPosition;
		}
		
		/**
		 * This method returns the carVelocity Vector.
		 * @return carVelocity
		 */
		public function get velocity():Vector2D {
			return carVelocity;
		}
		
		/**
		 * @return carMaxSpeed
		 */
		public function get maxSpeed():Number {
			return carMaxSpeed;
		}
		
		/**
		 * @return carMinSpeed
		 */
		private function get minSpeed():Number {
			return carMinSpeed;
		}
		
		/**
		 * @return carWidth
		 */
		public function get width():Number {
			return carWidth;
		}
		
		/**
		 * @return carHeight
		 */
		public function get length():Number {
			return carLength;
		}
		
		/**
		 * TEST
		 */
		public function get accX():Number {
			return carAcceleration.x;
		}
		
		public function get accY():Number {
			return carAcceleration.y;
		}
		
		public function get accLength():Number {
			return carAcceleration.length;
		}
		
		
		/**
		 * Method that calculates and returns
		 * the angle for which the car can turn to
		 * the right. As the calculation shows, the
		 * angle depends on how fast the car is moving.
		 */
		public function get carTurnAngleRight():Number {
			return (turnAngleConstant * this.speed);
		}
		
		/**
		 * Method that calculates and returns the
		 * angle for which the car can turn to the
		 * left. Notice the minus signe in front of
		 * the turnAngleConstant. It is needed because
		 * turning left corrospond to negative rotation.
		 */
		public function get carTurnAngleLeft():Number {
			return (-turnAngleConstant * this.speed);
		}
		
		// Change method \\
		
		/**
		 * This method rotates a point by making it a Vector2D object,
		 * rotating it and then returning a new point.
		 * @param point Point
		 * @param degree Number
		 * @return Point
		 */
		private function rotatePoint(point:Point, degrees:Number):Point {
			var vectorAsPoint:Vector2D = new Vector2D(point.x, point.y);
			vectorAsPoint.rotateDegree(degrees);
			return new Point(vectorAsPoint.x, vectorAsPoint.y);
		}
		
		/**
		 * This private method changes the cars orientation the given
		 * amount of degrees. Changing it to move to the left is done
		 * by calling this method with a positive orientationChange number,
		 * and moving its orientation towards the right is done by calling
		 * it with a negative number.
		 * @param orientationChange
		 */
		private function changeCarOrientation(orientationChange:Number):void {
			this.carOrientation += orientationChange;
		}
		
		// Car movement methods \\
		
		/**
		 * This method moves the car by adding the car's
		 * position vector by it's velocity vector.
		 */
		public function move():void {
			carPosition.add(carVelocity);
		}
		
		/**
		 * This method first checks if the
		 * cars velocity is less than the cars
		 * maximum speed. If so it accelerate the
		 * car by adding the carAcceleration vector
		 * to the carVelocity vector.
		 * If the car is at it's maximum speed,
		 * the carVelocity vector is unchanged.
		 */
		public function accelerate():void {
			if(this.speed < carMaxSpeed) {
				carVelocity.add(carAcceleration);
			} else {
				// Do nothing.
			}
		}
		
		/**
		 * This method first checkes that the car
		 * is moving faster than its minimum speed.
		 * If so, the cars velocity is decreased
		 * by subtracting the carAcceleration vector
		 * from the carVelocity vector.
		 * If on the other hand the car is moving
		 * slower than it's minimum speed, the
		 * carVelocity vector is set to (0, 0),
		 * indicating that the car is no longer
		 * moving.
		 */
		public function pushBreak():void {
			if(this.speed > carMinSpeed) {
				carVelocity.scale(this.breakSpeedScaling);
			} else {
				carVelocity.x = 0;
				carVelocity.y = 0;
			}
		}
		
		/**
		 * This method represents road friction and air
		 * resistance. I have defined it as half the
		 * acceleration.
		 */
		public function frictionAirResistance():void {
			if(this.speed > carMinSpeed) {
				carVelocity.scale(this.frictionSpeedScaling);
			} else {
				carVelocity.x = 0;
				carVelocity.y = 0;
			}
		}
		
		/**
		 * This method turns the car to the left, by
		 * changing the cars orientation, rotating
		 * the vectors carVelocity and carAcceleration
		 * accordingly to the carTurnAngleLeft.
		 */
		public function turnLeft():void {
			if(this.speed > carMinSpeed) {
				changeCarOrientation(this.carTurnAngleLeft);
				carVelocity.rotateDegree(this.carTurnAngleLeft);
				carAcceleration.rotateDegree(this.carTurnAngleLeft);
			} else {
				// Do nothing.
			}
		}
		
		/**
		 * This method turns the car to the right, by
		 * changing the cars orientation, rotating
		 * the vectors carVelocity and carAcceleration
		 * accordingly to the carTurnAngle.
		 */
		public function turnRight():void {
			if(this.speed > carMinSpeed) {
				changeCarOrientation(this.carTurnAngleRight);
				carVelocity.rotateDegree(this.carTurnAngleRight);
				carAcceleration.rotateDegree(this.carTurnAngleRight);
			} else {
				// Do nothing
			}
		}
	}
}