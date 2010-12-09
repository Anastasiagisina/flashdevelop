﻿package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.net.Responder;
	import flash.utils.Timer;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The MessageResponder class handles a successful result or fault from a message
	 */
	public class MessageResponder extends Responder
	{
		/**
		 *  @private
		 */
		private var _requestTimedOut : Boolean;
		/**
		 *  @private
		 */
		private var _requestTimer : Timer;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _agent : MessageAgent;
		/**
		 *  @private
		 */
		private var _channel : Channel;
		/**
		 *  @private
		 */
		private var _message : IMessage;

		/**
		 *  Provides access to the MessageAgent that sent the message.
		 */
		public function get agent () : MessageAgent;
		/**
		 *  Provides access to the Channel used to send the message.
		 */
		public function get channel () : Channel;
		/**
		 *  Provides access to the sent Message.
		 */
		public function get message () : IMessage;
		/**
		 * @private
		 */
		public function set message (value:IMessage) : void;

		/**
		 *  Constructs a MessageResponder to handle the response for the specified
		 */
		public function MessageResponder (agent:MessageAgent, message:IMessage, channel:Channel = null);
		/**
		 *  @private 
		 */
		public function startRequestTimeout (requestTimeout:int) : void;
		/**
		 *  Called by the channel that created this MessageResponder when a
		 */
		public function result (message:IMessage) : void;
		/**
		 *  Called by the channel that created this MessageResponder when a fault
		 */
		public function status (message:IMessage) : void;
		/**
		 *  Constructs an ErrorMessage that can be passed to the associated 
		 */
		protected function createRequestTimeoutErrorMessage () : ErrorMessage;
		/**
		 *  Subclasses must override this method to perform custom processing of
		 */
		protected function resultHandler (message:IMessage) : void;
		/**
		 *  Subclasses must override this method to handle a request timeout and 
		 */
		protected function requestTimedOut () : void;
		/**
		 *  Subclasses must override this method to perform custom processing of
		 */
		protected function statusHandler (message:IMessage) : void;
		/**
		 *  @private
		 */
		private function timeoutRequest (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function releaseTimer () : void;
	}
}