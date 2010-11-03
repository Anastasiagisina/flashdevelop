﻿package fl.motion.easing
{
	/**
	 *  The Bounce class defines three easing functions to implement 
	 */
	public class Bounce
	{
		/**
		 *  The <code>easeOut()</code> method starts the bounce motion fast 
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 *  The <code>easeIn()</code> method starts the bounce motion slowly 
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 *  The <code>easeInOut()</code> method combines the motion
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number) : Number;
	}
}