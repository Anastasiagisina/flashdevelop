﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  Request sent from one SystemManager to a SystemManager in another 
	 */
	public class EventListenerRequest extends SWFBridgeRequest
	{
		/**
		 *  Request to add an event listener.
		 */
		public static const ADD_EVENT_LISTENER_REQUEST : String = "addEventListenerRequest";
		/**
		 *  Request to remove an event listener.
		 */
		public static const REMOVE_EVENT_LISTENER_REQUEST : String = "removeEventListenerRequest";
		/**
		 *  @private
		 */
		private var _priority : int;
		/**
		 *  @private
		 */
		private var _useCapture : Boolean;
		/**
		 *  @private
		 */
		private var _eventType : String;
		/**
		 *  @private
		 */
		private var _useWeakReference : Boolean;

		/**
		 *  The <code>priority</code> parameter
		 */
		public function get priority () : int;
		/**
		 *  The <code>useCapture</code> parameter
		 */
		public function get useCapture () : Boolean;
		/**
		 *  The type of the event to listen to.
		 */
		public function get eventType () : String;
		/**
		 *  The <code>useWeakReference</code> parameter
		 */
		public function get useWeakReference () : Boolean;

		/**
		 *  Marshals an event by copying the relevant parameters
		 */
		public static function marshal (event:Event) : EventListenerRequest;
		/**
		 *  Creates a new request to add or remove an event listener.
		 */
		public function EventListenerRequest (type:String, bubbles:Boolean = false, cancelable:Boolean = true, eventType:String = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}