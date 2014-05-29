/**
 * This Class simulate the behaviour given by Hook's law. This law
 * descripe the behaviour of springs.
 * @author Bjorn Allan Johansen
 * @date 09-09-2011
 * @version 1.0
 */
package utils {
	public class SpringBehaviour {
		
		/*
		 * This variable represents the springs strength. Some
		 * springs are very easy to pull and bounch back with
		 * little force, while others are harder to pull and
		 * therefore bounce back with great force. The springs
		 * strength is normally a fraction of 1, say 0.2 or 0.5
		 * or whatever fraction fits the spring behaviour you
		 * are trying to simulate. 
		 */
		private var _springStrength:Number;
				
		/*
		 * These two variables represent the velocity of which the
		 * spring is moving on the x-axis and y-axis respectivly.
		 */
		private var _velocityX:Number;
		private var _velocityY:Number;
		
		/*
		 * These two variables will store the initial start velocity,
		 * so that we have the posibility to reset the behaviour at
		 * any given point.
		 */
		private var _startVelocityX:Number;
		private var _startVelocityY:Number;
		
		/*
		 * This variable represents friction that will dampen the
		 * springs movement over time. This is also represented as
		 * a fraction of 1 where 0.95 is a good value in most cases.
		 */
		private var _friction:Number;
		
		/*
		 * These two variables represent the target point the spring
		 * will pull the object too. This can of course be interpreted
		 * in many ways. Forexample it doesn't have to be a position,
		 * but could be a size/scale of the object.
		 */
		private var _targetX:Number;
		private var _targetY:Number;
		
		/*
		 * These variables represent the position that the object being
		 * affected by the spring has.
		 */
		private var _posX:Number;
		private var _posY:Number;
		
		/**
		 * The constructor for the SpringBehaviour Class.
		 * @param springStrength Number
		 * @param velocityX Number
		 * @param velocityY Number
		 * @param friction Number
		 * @param targetX Number
		 * @param targetY Number
		 * @param currentX Number
		 * @param currentY Number
		 */
		public function SpringBehaviour(springStrength:Number, velocityX:Number, velocityY:Number, friction:Number, targetX:Number, targetY:Number, currentX:Number, currentY:Number) {
			// Initilizing the variables.
			this._springStrength = springStrength;
			this._velocityX = velocityX;
			this._velocityY = velocityY;
			this._startVelocityX = velocityX;
			this._startVelocityY = velocityY;
			this._friction = friction;
			this._targetX = targetX;
			this._targetY = targetY;
			this._posX = currentX;
			this._posY = currentY;
		}
		
		/**
		 * This is the method that allows the users of this
		 * Class to run their numbers through Hooks Law once.
		 */
		public function run():void {
			hooksLaw();
		}
		
		/**
		 * This method resets the created object to its original
		 * settings.
		 */
		public function reset():void {
			this._velocityX = this._startVelocityX;
			this._velocityY = this._startVelocityY;
		}
		
		/**
		 * This method is where the actual calculations take
		 * place. It's here Hooks Law go in to action. As
		 * this method is written, it will calculate the next
		 * position of the object being affected by the spring.
		 * To get animation this of course have to be repeated.
		 */
		private function hooksLaw():void {
			/*
			 * These two lines make good sense when you think about it.
			 * What they do is calculate the distance between where we
			 * want to end up and where we actually are, and multiplying
			 * it with the strength of the spring. This gives us the
			 * increase in velocity on each axis, which in other words
			 * is the acceleration.
			 */
			var accelerationX:Number = (this._targetX - this._posX) * _springStrength;
			var accelerationY:Number = (this._targetY - this._posY) * _springStrength;
			
			/*
			 * When we understand that, it makes sense to add this to
			 * the velocity, which is what we do next.
			 */
			this._velocityX += accelerationX;
			this._velocityY += accelerationY;
			
			/*
			 * Now the next two lines calculate the new position of the
			 * object being affected by the spring.
			 */
			this._posX += Math.sin(this._velocityX)/2;
			this._posY += Math.sin(this._velocityY)/2;
			
			/*
			 * These two lines inact friction in the simulation and
			 * thereby damper the velocity of the object.
			 */
			this._velocityX *= this._friction;
			this._velocityY *= this._friction;
		}
		
		/**
		 * This method returns the new x-axis position calculated
		 * using Hooks Law.
		 * @return _posX Number
		 */
		public function get newPosX():Number {
			return this._posX;
		}
		
		/**
		 * This method returns the new y-axis position calculated
		 * using Hooks Law.
		 * @return _posY Number
		 */
		public function get newPosY():Number {
			return this._posY;
		}
		
	}

}