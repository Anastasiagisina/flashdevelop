﻿package mx.messaging
{
	import flash.errors.IllegalOperationError;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.events.PropertyChangeEvent;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  A Producer sends messages to a destination.
	 */
	public class Producer extends AbstractProducer
	{
		/**
		 *  @private
		 */
		private var _subtopic : String;

		/**
		 *  Provides access to the subtopic for the remote destination that the MessageAgent uses.
		 */
		public function get subtopic () : String;
		/**
		 *  @private
		 */
		public function set subtopic (value:String) : void;

		/**
		 *  Constructs a Producer.
		 */
		public function Producer ();
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
	}
}