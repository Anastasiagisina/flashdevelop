﻿package mx.rpc.events
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.IMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;

	/**
	 * This event is dispatched when an RPC call has a fault.
	 */
	public class FaultEvent extends AbstractEvent
	{
		/**
		 * The FAULT event type.
		 */
		public static const FAULT : String = "fault";
		private var _fault : Fault;
		private var _headers : Object;
		private var _statusCode : int;

		/**
		 * The Fault object that contains the details of what caused this event.
		 */
		public function get fault () : Fault;
		/**
		 * In certain circumstances, headers may also be returned with a fault to
		 */
		public function get headers () : Object;
		/**
		 * @private
		 */
		public function set headers (value:Object) : void;
		/**
		 * If the source message was sent via HTTP, this property provides access
		 */
		public function get statusCode () : int;

		/**
		 * Creates a new FaultEvent. The fault is a required parameter while the call and message are optional.
		 */
		public function FaultEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, fault:Fault = null, token:AsyncToken = null, message:IMessage = null);
		/**
		 * Because this event can be redispatched we have to implement clone to
		 */
		public function clone () : Event;
		/**
		 * Returns a string representation of the FaultEvent.
		 */
		public function toString () : String;
		/**
		 * Have the token apply the fault.
		 */
		function callTokenResponders () : void;
		/**
		 *  Given a MessageFaultEvent, this method constructs and
		 */
		public static function createEventFromMessageFault (value:MessageFaultEvent, token:AsyncToken = null) : FaultEvent;
		/**
		 *  Given a Fault, this method constructs and
		 */
		public static function createEvent (fault:Fault, token:AsyncToken = null, msg:IMessage = null) : FaultEvent;
	}
}