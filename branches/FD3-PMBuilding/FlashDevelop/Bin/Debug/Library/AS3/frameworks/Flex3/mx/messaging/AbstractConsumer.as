﻿package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;
	import mx.logging.Log;
	import mx.messaging.channels.PollingChannel;
	import mx.messaging.events.ChannelEvent;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when a message is received by the Consumer.
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 

	/**
	 *  The AbstractConsumer is the base class for both the Consumer and
	 */
	public class AbstractConsumer extends MessageAgent
	{
		/**
		 *  @private
		 */
		private var _currentAttempt : int;
		/**
		 *  @private
		 */
		private var _resubscribeTimer : Timer;
		/**
		 *  Flag indicating whether this consumer should be subscribed or not.
		 */
		protected var _shouldBeSubscribed : Boolean;
		/**
		 *  @private
		 */
		private var _subscribeMsg : CommandMessage;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _resubscribeAttempts : int;
		/**
		 *  @private
		 */
		private var _resubscribeInterval : int;
		/**
		 *  @private
		 */
		private var _subscribed : Boolean;
		/**
		 *  @private
		 */
		private var _timestamp : Number;

		/**
		 *  @private
		 */
		public function set destination (value:String) : void;
		/**
		 *  The number of resubscribe attempts that the Consumer makes in the event
		 */
		public function get resubscribeAttempts () : int;
		/**
		 *  @private
		 */
		public function set resubscribeAttempts (value:int) : void;
		/**
		 *  The number of milliseconds between resubscribe attempts.
		 */
		public function get resubscribeInterval () : int;
		/**
		 *  @private
		 */
		public function set resubscribeInterval (value:int) : void;
		/**
		 *  Indicates whether the Consumer is currently subscribed. The <code>propertyChange</code>
		 */
		public function get subscribed () : Boolean;
		/**
		 *  Contains the timestamp of the most recent message this Consumer
		 */
		public function get timestamp () : Number;
		/**
		 *  @private
		 */
		public function set timestamp (value:Number) : void;

		/**
		 *  Constructs a Consumer.
		 */
		public function AbstractConsumer ();
		/**
		 *  @private
		 */
		function setClientId (value:String) : void;
		/**
		 *  @private
		 */
		protected function setSubscribed (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function acknowledge (ackMsg:AcknowledgeMessage, msg:IMessage) : void;
		/**
		 *  Disconnects the Consumer from its remote destination.
		 */
		public function disconnect () : void;
		/**
		 *  @private
		 */
		public function fault (errMsg:ErrorMessage, msg:IMessage) : void;
		/**
		 *  @private
		 */
		public function channelConnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private
		 */
		public function channelDisconnectHandler (event:ChannelEvent) : void;
		/**
		 *  @private
		 */
		public function channelFaultHandler (event:ChannelFaultEvent) : void;
		/**
		 *  Requests any messages that are queued for this Consumer on the server.
		 */
		public function receive (timestamp:Number = 0) : void;
		/**
		 *  Subscribes to the remote destination.
		 */
		public function subscribe (clientId:String = null) : void;
		/**
		 *  Unsubscribes from the remote destination. In the case of durable JMS
		 */
		public function unsubscribe (preserveDurable:Boolean = false) : void;
		/**
		 *  @private
		 */
		function messageHandler (event:MessageEvent) : void;
		/**
		 *  Returns a subscribe message.
		 */
		protected function buildSubscribeMessage () : CommandMessage;
		/**
		 *  Returns an unsubscribe message.
		 */
		protected function buildUnsubscribeMessage (preserveDurable:Boolean) : CommandMessage;
		/**
		 *  @private
		 */
		protected function resubscribe (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		protected function startResubscribeTimer () : void;
		/**
		 * @private
		 */
		protected function stopResubscribeTimer () : void;
	}
}