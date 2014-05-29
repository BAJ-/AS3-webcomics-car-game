/**
 * This class represents a 2 dimensional vector.
 * Method names ending with 'New', returns results as a new vector.
 * This class uses implicit get/set methods.
 * 
 * @author Bjorn Allan Johansen
 * @version as3 v1.0: 11-08-2011
 */
package utils {
	public class Vector2D {
		
		// Variables of Vector values representing coordinates.
		private var _x:Number;
		private var _y:Number;
		
		// Variables to temporary storage of coordinates.
		private var _currentX:Number;
		private var _currentY:Number;
		
		/**
		 * Constructor for class Vector.
		 * Creates the Vector (x0, y0).
		 */
		public function Vector2D(x0:Number, y0:Number) {
			this._x = x0;
			this._y = y0;
		}
		
		// Vector implicit getter methods \\
		
		/**
		 * Implicit getter function that returns
		 * this Vector's x coordinate.
		 * @return vx
		 */
		public function get x():Number {
			return this._x;
		}
		
		/**
		 * Implicit getter function that returns
		 * this Vector's y coordinate.
		 * @return vy
		 */
		public function get y():Number {
			return this._y;
		}
		
		/**
		 * Implicit getter function that returns
		 * this Vector's length.
		 * @return Vector length.
		 */
		public function get length():Number {
				return Math.sqrt( this.dotProduct(this) );
				//return Math.sqrt(this.x*this.x + this.y*this.y);
		}
		
		// Vector implicit setter methods \\
		
		/**
		 * Implicit setter function that sets
		 * a given new x value.
		 * @param newX Number
		 */
		public function set x(newX:Number):void {
			this._x = newX;
		}
		
		/**
		 * Implicit setter function that sets
		 * a given new y value.
		 * @param y Number
		 */
		public function set y(newY:Number):void {
			this._y = newY;
		}
		
		// Clone method \\
		
		/**
		 * This method returns a clone of the given Vector
		 * @return Vector clone
		 */
		public function cloneVector():Vector2D {
			return new Vector2D(this.x, this.y);
		}
		
		// Vector addition methods \\
		
		/**
		 * This method adds two vectors together making
		 * the calling vector the result vector.
		 * @param v Vector
		 */
		public function add(v:Vector2D):void {
			// Stores current coordinates 
			_currentX = this.x;
			_currentY = this.y;
			
			this.x = _currentX + v.x;
			this.y = _currentY + v.y;
		}
		
		/**
		 * This method adds two vectors together and
		 * return the result as a new vector.
		 * @param v Vector2D
		 * @return Vector2D which is the sum of the two vectors
		 */
		public function addNew(v:Vector2D):Vector2D {
			return new Vector2D(this.x + v.x, this.y + v.y);
		}
		
		/**
		 * This method subtracts the given vector from the
		 * calling vector.
		 * @param v Vector2D
		 */
		public function sub(v:Vector2D):void {
			// Stores current coordinates
			_currentX = this.x;
			_currentY = this.y;
			
			this.x = _currentX - v.x;
			this.y = _currentY - v.y;
		}
		
		/**
		 * This method does the same as the sub method
		 * except that it returns the result as a new
		 * Vector2D.
		 * @param v Vector2D
		 * @return Vector2D which is the difference between
		 *         the calling vector and the given vector.
		 */
		public function subNew(v:Vector2D):Vector2D {
			return new Vector2D(this.x - v.x, this.y - v.y);
		}
		
		// Vector dot product method \\
		
		public function dotProduct(v:Vector2D):Number {
			return ( (this.x * v.x) + (this.y * v.y) );
		}
		
		// Vector rotation methods \\
		
		/**
		 * This method rotates a calling vector a
		 * given angle in ratians.
		 * @param radians
		 */
		public function rotateRadian(radians:Number):void {
			// Storing current coordinates
			_currentX = this.x;
			_currentY = this.y;
			
			this.x = (Math.cos(radians) * _currentX) - (Math.sin(radians) * _currentY);
			this.y = (Math.sin(radians) * _currentX) + (Math.cos(radians) * _currentY);
		}
		
		/**
		 * This method does the same as the rotateRadian method, except that
		 * it returns the result as a new Vector.
		 */
		public function rotateRadianNew(radians:Number):Vector2D {
			return new Vector2D( ((Math.cos(radians) * this.x) - (Math.sin(radians) * this.y)),
							   ((Math.sin(radians) * this.x) + (Math.cos(radians) * this.y)) );
		}
		
		/**
		 * This method rotates a calling vector a
		 * given angle in degrees.
		 * @param radians
		 */
		public function rotateDegree(degrees:Number):void {
			// Storing current coordinates
			var _currentX:Number = this.x;
			var _currentY:Number = this.y;
			this.x = (Math.cos(degrees * Math.PI/180) * _currentX) - (Math.sin(degrees * Math.PI/180) * _currentY);
			this.y = (Math.sin(degrees * Math.PI/180) * _currentX) + (Math.cos(degrees * Math.PI/180) * _currentY);
		}
		
		/**
		 * This method does the same as the rotateDegree method, except that
		 * it returns the result as a new Vector.
		 */
		public function rotateDegreeNew(degrees:Number):Vector2D {
			return new Vector2D( ((Math.cos(degrees * Math.PI/180) * this.x) - (Math.sin(degrees * Math.PI/180) * this.y)),
							   ((Math.sin(degrees * Math.PI/180) * this.x) + (Math.cos(degrees * Math.PI/180) * this.y)) );
		}
		
		 // Vector vertical/horizontal flip methods \\
		// Vector flipping is special case rotation  \\
		
		/**
		 * This method flips the given vector vertically
		 * by changing sign of the x coordinate.
		 * The resulting vector is the given vector. 
		 */
		public function verticalFlip():void {
			_currentX = this.x;
			this.x = -_currentX;
		}
		
		/**
		 * This method does the same as the verticalFlip method,
		 * except that it returns the result as a new Vector.
		 * @return Vector vertically flipped.
		 */
		public function verticalFlipNew():Vector2D {
			return new Vector2D(-this.x, this.y);
		}
		
		/**
		 * This method flips the given vector horizontally,
		 * by changing sign of the y coordinate.
		 * The resulting vector is the given vector.
		 */
		public function horizontalFlip():void {
			_currentY = this.y;
			this.y = -_currentY;
		}
		
		/**
		 * This method does the same as the horizontalFlip method,
		 * except that it returns the result as a new Vector
		 * @return Vector horizontally flipped.
		 */
		public function horizontalFlipNew():Vector2D {
			return new Vector2D(this.x, -this.y);
		}
		
		// Vector scaling methods \\
		
		/**
		 * This method scales the given vector by a given
		 * factor scaleFactor.
		 * The result vector is the given vector.
		 * @param scaleFactor 
		 */
		public function scale(scaleFactor:Number):void {
			_currentX = this.x;
			_currentY = this.y;
			
			this.x = _currentX * scaleFactor;
			this.y = _currentY * scaleFactor;
		}
		
		/**
		 * This method does the same as the scale method except
		 * that it returns the result as a new vector.
		 * @param scaleFactor
		 * @return Vector scaled
		 */
		public function scaleNew(scaleFactor:Number):Vector2D {
			return new Vector2D(this.x*scaleFactor, this.y*scaleFactor);
		}
	}
}