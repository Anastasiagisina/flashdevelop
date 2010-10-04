﻿package mx.messaging.events
{
	import flash.events.Event;
	import mx.messaging.messages.ErrorMessage;

	/**
	 * The MessageFaultEvent class is used to propagate fault messages within the messaging system.
	 */
	public class MessageFaultEvent extends Event
	{
		/**
		 *  The FAULT event type; dispatched for a message fault.
		 */
		public static const FAULT : String = "fault";
		/**
		 *  The ErrorMessage for this event.
		 */
		public var message : ErrorMessage;

		/**
		 *  Provides access to the destination specific failure code.
		 */
		public function get faultCode () : String;
		/**
		 *  Provides destination specific details of the failure.
		 */
		public function get faultDetail () : String;
		/**
		 *  Provides access to the destination specific reason for the failure.
		 */
		public function get faultString () : String;
		/**
		 *  Provides access to the root cause of the failure, if one exists.
		 */
		public function get rootCause () : Object;

		/**
		 *  Utility method to create a new MessageFaultEvent that doesn't bubble and
		 */
		public static function createEvent (msg:ErrorMessage) : MessageFaultEvent;
		/**
		 *  Constructs an instance of a fault message event for the specified message
		 */
		public function MessageFaultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, message:ErrorMessage = null);
		/**
		 *  Clones the MessageFaultEvent.
		 */
		public function clone () : Event;
		/**
		 *  Returns a string representation of the MessageFaultEvent.
		 */
		public function toString () : String;
	}
}