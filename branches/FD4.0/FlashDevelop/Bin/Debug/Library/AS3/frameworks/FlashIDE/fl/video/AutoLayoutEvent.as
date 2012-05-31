﻿package fl.video
{
	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * Flash<sup>&#xAE;</sup> Player dispatches an AutoLayoutEvent object when the video player is resized 
	 */
	public class AutoLayoutEvent extends LayoutEvent implements IVPEvent
	{
		/**
		 * Defines the value of the 
		 */
		public static const AUTO_LAYOUT : String = "autoLayout";
		private var _vp : uint;

		/**
		 * The index of the VideoPlayer object involved in this event.
		 */
		public function get vp () : uint;
		/**
		 * @private (setter)
		 */
		public function set vp (n:uint) : void;

		/**
		 * Creates an Event object that contains information about <code>autoLayout</code> events. 
		 */
		public function AutoLayoutEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldBounds:Rectangle = null, oldRegistrationBounds:Rectangle = null, vp:uint = 0);
		/**
		 * @private
		 */
		public function clone () : Event;
	}
}