﻿package fl.video
{
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 * Flash<sup>&#xAE;</sup> Player dispatches a VideoProgressEvent object when the user 
	 */
	public class VideoProgressEvent extends ProgressEvent implements IVPEvent
	{
		/**
		 * Defines the value of the <code>type</code> property of a <code>progress</code> event object.
		 */
		public static const PROGRESS : String = "progress";
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
		 * Creates an Event object that contains information about progress events. 
		 */
		public function VideoProgressEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, vp:uint = 0);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}