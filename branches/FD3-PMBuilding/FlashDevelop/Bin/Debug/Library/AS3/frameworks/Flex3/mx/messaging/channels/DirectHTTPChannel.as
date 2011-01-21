﻿package mx.messaging.channels
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import mx.core.mx_internal;
	import mx.messaging.Channel;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.errors.ChannelError;
	import mx.messaging.errors.InvalidChannelError;
	import mx.messaging.errors.MessageSerializationError;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.events.HTTPStatusEvent;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import mx.core.mx_internal;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.events.HTTPStatusEvent;

	/**
	 *  @private
	 */
	public class DirectHTTPChannel extends Channel
	{
		/**
		 * @private
		 */
		local var clientId : String;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 * @private
		 */
		private static var clientCounter : uint;

		/**
		 *  Indicates if this channel is connected.
		 */
		public function get connected () : Boolean;
		/**
		 *  Indicates the protocol used by this channel.
		 */
		public function get protocol () : String;
		/**
		 *  @private
		 */
		function get realtime () : Boolean;

		/**
		 *  Constructs an instance of a DirectHTTPChannel.
		 */
		public function DirectHTTPChannel (id:String, uri:String = "");
		/**
		 *  @private
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  Returns the appropriate MessageResponder for the Channel.
		 */
		protected function getMessageResponder (agent:MessageAgent, message:IMessage) : MessageResponder;
		/**
		 *  Because this channel doesn't participate in hunting we will always assume
		 */
		protected function internalConnect () : void;
		protected function internalSend (msgResp:MessageResponder) : void;
		/**
		 override
		 */
		function createURLRequest (message:IMessage) : URLRequest;
		public function setCredentials (credentials:String, agent:MessageAgent = null, charset:String = null) : void;
	}
	/**
	 *  @private
	 */
	internal class DirectHTTPMessageResponder extends MessageResponder
	{
		/**
		 * @private
		 */
		private var clientId : String;
		/**
		 * @private
		 */
		private var lastStatus : int;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  The URLLoader associated with this responder.
		 */
		public var urlLoader : URLLoader;

		/**
		 *  Constructs a DirectHTTPMessageResponder.
		 */
		public function DirectHTTPMessageResponder (agent:MessageAgent, msg:IMessage, channel:DirectHTTPChannel, urlLoader:URLLoader);
		/**
		 *  @private
		 */
		public function errorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function securityErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function httpStatusHandler (event:HTTPStatusEvent) : void;
		/**
		 *  Handle a request timeout by closing our associated URLLoader and
		 */
		protected function requestTimedOut () : void;
	}
}