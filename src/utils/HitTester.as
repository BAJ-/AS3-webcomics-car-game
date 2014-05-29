/**
 * @author Bjørn Allan Johansen
 */
package utils {
	
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
		
	public class HitTester {
		public function HitTester() {
			
		}
		
		public function hitTester(object:DisplayObject, point:Point):Boolean {
			/* First we check if the hitTestPoint method returns false. If it does, that
			 * means that we definitely do not have a hit, so we return false. But if this
			 * returns true, we still don't know 100% that we have a hit because it might
			 * be a transparent part of the image. 
			 */
			if(!object.hitTestPoint(point.x, point.y, true)) {
				return false;
			}
			else {
				/* So now we make a new BitmapData object and draw the pixels of our object
				 * in there. Then we use the hitTest method of that BitmapData object to
				 * really find out of we have a hit or not.
				 */
				var bmapData:BitmapData = new BitmapData(object.width, object.height, true, 0x00000000);
				bmapData.draw(object, new Matrix());
				
				var returnVal:Boolean = bmapData.hitTest(new Point(0,0), 0, object.globalToLocal(point));
				
				bmapData.dispose();
				
				return returnVal;
			}
		}
	}
}
