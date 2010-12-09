﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The StateChangeEvent class represents an event that is dispatched when the 
	 */
	public class StateChangeEvent extends Event
	{
		/**
		 *  The StateChangeEvent.CURRENT_STATE_CHANGE constant defines the
		 */
		public static const CURRENT_STATE_CHANGE : String = "currentStateChange";
		/**
		 *  The StateChangeEvent.CURRENT_STATE_CHANGING constant defines the
		 */
		public static const CURRENT_STATE_CHANGING : String = "currentStateChanging";
		/**
		 *  The name of the view state that the component is entering.
		 */
		public var newState : String;
		/**
		 *  The name of the view state that the component is exiting.
		 */
		public var oldState : String;

		/**
		 *  Constructor.
		 */
		public function StateChangeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldState:String = null, newState:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}