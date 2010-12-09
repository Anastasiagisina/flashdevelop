﻿package mx.messaging.channels
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.core.mx_internal;
	import mx.messaging.FlexClient;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.amfx.AMFXDecoder;
	import mx.messaging.channels.amfx.AMFXEncoder;
	import mx.messaging.channels.amfx.AMFXHeader;
	import mx.messaging.channels.amfx.AMFXResult;
	import mx.messaging.config.ConfigMap;
	import mx.messaging.config.ServerConfig;
	import mx.messaging.errors.MessageSerializationError;
	import mx.messaging.events.ChannelFaultEvent;
	import mx.messaging.messages.AbstractMessage;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.MessagePerformanceInfo;
	import mx.messaging.messages.MessagePerformanceUtils;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import mx.core.mx_internal;
	import mx.messaging.MessageAgent;
	import mx.messaging.MessageResponder;
	import mx.messaging.channels.HTTPChannel;
	import mx.messaging.channels.amfx.AMFXDecoder;
	import mx.messaging.channels.amfx.AMFXHeader;
	import mx.messaging.channels.amfx.AMFXResult;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;

	/**
	 *  The HTTPChannel class provides the HTTP support for messaging.
	 */
	public class HTTPChannel extends PollingChannel
	{
		/**
		 *  @private
		 */
		private var _appendToURL : String;
		/**
		 *  @private
		 */
		private var _connectLoader : ChannelRequestLoader;
		/**
		 *  @private
		 */
		private var _encoder : AMFXEncoder;
		/**
		 *  @private
		 */
		private var _pendingRequest : ChannelRequestLoader;
		/**
		 *  @private
		 */
		private var _messageQueue : Array;
		/**
		 *  @private
		 */
		private static const APPEND_TO_URL_HEADER : String = "AppendToGatewayUrl";

		/**
		 *  Reports whether the channel is actively polling.
		 */
		public function get polling () : Boolean;
		/**
		 *  Indicates whether this channel will piggyback poll requests along
		 */
		public function get piggybackingEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set piggybackingEnabled (value:Boolean) : void;
		/**
		 *  Indicates whether this channel is enabled to poll.
		 */
		public function get pollingEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set pollingEnabled (value:Boolean) : void;
		/**
		 *  Provides access to the polling interval for this Channel.
		 */
		public function get pollingInterval () : Number;
		/**
		 *  @private
		 */
		public function set pollingInterval (value:Number) : void;
		/**
		 *  Returns the protocol for this channel (http).
		 */
		public function get protocol () : String;
		/**
		 * @private
		 */
		function get appendToURL () : String;
		/**
		 *  @private
		 */
		function set appendToURL (value:String) : void;

		/**
		 *  Creates an new HTTPChannel instance.
		 */
		public function HTTPChannel (id:String = null, uri:String = null);
		/**
		 *  @private
		 */
		public function applySettings (settings:XML) : void;
		/**
		 *  @private
		 */
		protected function connectTimeoutHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		protected function getPollSyncMessageResponder (agent:MessageAgent, msg:CommandMessage) : MessageResponder;
		/**
		 *  @private
		 */
		protected function getDefaultMessageResponder (agent:MessageAgent, msg:IMessage) : MessageResponder;
		/**
		 *  @private
		 */
		protected function internalConnect () : void;
		/**
		 *  @private
		 */
		protected function internalDisconnect (rejected:Boolean = false) : void;
		/**
		 *  @private
		 */
		protected function internalSend (msgResp:MessageResponder) : void;
		/**
		 *  @private
		 */
		function connectionError (msg:ErrorMessage) : void;
		/**
		 *  @private
		 */
		function createURLRequest (message:IMessage) : URLRequest;
		/**
		 * @private
		 */
		protected function internalPingComplete (msg:AsyncMessage) : void;
		/**
		 *  @private
		 */
		private function AppendToGatewayUrl (value:String) : void;
		private function decodePacket (event:Event) : AMFXResult;
		/**
		 *  @private
		 */
		private function processHeaders (packet:AMFXResult) : void;
		/**
		 *  @private
		 */
		private function pingCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function pingErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function requestProcessedHandler (loader:ChannelRequestLoader, event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class HTTPWrapperResponder
	{
		/**
		 *  @private
		 */
		private var _wrappedResponder : MessageResponder;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;

		/**
		 *  @private
		 */
		public function HTTPWrapperResponder (wrappedResponder:MessageResponder);
		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function errorHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class HTTPMessageResponder extends MessageResponder
	{
		/**
		 *  @private
		 */
		private var decoder : AMFXDecoder;
		/**
		 * @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  The loader associated with this responder.
		 */
		public var urlLoader : ChannelRequestLoader;

		/**
		 *  @private
		 */
		public function HTTPMessageResponder (agent:MessageAgent, msg:IMessage, channel:HTTPChannel);
		/**
		 *  @private
		 */
		protected function resultHandler (response:IMessage) : void;
		/**
		 *  @private
		 */
		protected function requestTimedOut () : void;
		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function errorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function ioErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function securityErrorHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class ChannelRequestLoader
	{
		/**
		 *  @private
		 */
		private var _urlLoader : URLLoader;
		/**
		 *  @private
		 */
		public var errorCallback : Function;
		/**
		 *  @private
		 */
		public var ioErrorCallback : Function;
		/**
		 *  @private
		 */
		public var securityErrorCallback : Function;
		/**
		 *  @private
		 */
		public var completeCallback : Function;
		/**
		 *  @private
		 */
		public var requestProcessedCallback : Function;

		/**
		 *  @private
		 */
		public function ChannelRequestLoader ();
		/**
		 *  @private
		 */
		public function load (request:URLRequest) : void;
		/**
		 *  @private
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		public function setErrorCallbacks (callback:Function) : void;
		/**
		 *  @private
		 */
		private function callRequestProcessedCallback (event:Event) : void;
		/**
		 *  @private
		 */
		private function callEventCallback (callback:Function, event:Event) : void;
		/**
		 *  @private
		 */
		private function errorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function ioErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function securityErrorHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function completeHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class PollSyncHTTPMessageResponder extends HTTPMessageResponder
	{
		/**
		 *  @private
		 */
		public function PollSyncHTTPMessageResponder (agent:MessageAgent, msg:IMessage, channel:HTTPChannel);
		/**
		 *  @private
		 */
		protected function resultHandler (response:IMessage) : void;
	}
	/**
	 *  Helper class for sending a fire-and-forget disconnect message.
	 */
	internal class HTTPFireAndForgetResponder extends MessageResponder
	{
		public function HTTPFireAndForgetResponder (message:IMessage);
	}
}