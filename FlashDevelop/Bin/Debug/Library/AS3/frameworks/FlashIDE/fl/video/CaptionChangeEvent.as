﻿package fl.video
{
	import flash.events.Event;

	/**
	 * The CaptionChangeEvent is dispatched any time a caption is added or removed from the caption target text field.
	 */
	public class CaptionChangeEvent extends Event
	{
		/**
		 * Defines the value of the 
		 */
		public static const CAPTION_CHANGE : String = "captionChange";
		private var _added : Boolean;
		private var _captionCuePointObject : Object;

		/**
		 *  A Boolean value that determines whether the caption was added or removed.
		 */
		public function get added () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set added (b:Boolean) : void;
		/**
		 * The cue point object for the caption that was added or removed.
		 */
		public function get captionCuePointObject () : Object;
		/**
		 * @private (setter)
		 */
		public function set captionCuePointObject (o:Object) : void;

		/**
		 * Creates an Event object that contains information about <code>captionChange</code> events.
		 */
		public function CaptionChangeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, added:Boolean = true, captionCuePointObject:Object = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}