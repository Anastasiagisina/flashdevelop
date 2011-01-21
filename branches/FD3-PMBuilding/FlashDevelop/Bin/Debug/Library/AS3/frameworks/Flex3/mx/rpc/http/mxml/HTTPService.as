﻿package mx.rpc.http.mxml
{
	import flash.events.ErrorEvent;
	import flash.events.ErrorEvent;
	import mx.core.mx_internal;
	import mx.core.IMXMLObject;
	import mx.managers.CursorManager;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.AsyncMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.AsyncDispatcher;
	import mx.rpc.Fault;
	import mx.rpc.http.HTTPService;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.mxml.Concurrency;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.validators.Validator;

	/**
	 * You use the <code>&lt;mx:HTTPService&gt;</code> tag to represent an
	 */
	public class HTTPService extends mx.rpc.http.HTTPService implements IMXMLSupport
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _concurrency : String;
		private var document : Object;
		private var id : String;
		private var _showBusyCursor : Boolean;

		/**
		 * Value that indicates how to handle multiple calls to the same service. The default
		 */
		public function get concurrency () : String;
		/**
		 *  @private
		 */
		public function set concurrency (c:String) : void;
		/**
		 * If <code>true</code>, a busy cursor is displayed while a service is executing. The default
		 */
		public function get showBusyCursor () : Boolean;
		public function set showBusyCursor (sbc:Boolean) : void;

		/**
		 * Creates a new HTTPService. This constructor is usually called by the generated code of an MXML document.
		 */
		public function HTTPService (rootURL:String = null, destination:String = null);
		/**
		 * @private
		 */
		public function cancel (id:String = null) : AsyncToken;
		/**
		 * Called after the implementing object has been created and all
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 * Executes an HTTPService request. The parameters are optional, but if specified should
		 */
		public function send (parameters:Object = null) : AsyncToken;
		function invoke (message:IMessage, token:AsyncToken = null) : AsyncToken;
		/**
		 * Kill the busy cursor, find the matching call object and pass it back
		 */
		function preHandle (event:MessageEvent) : AsyncToken;
		/**
		 * If this event is a fault, and the event type does not
		 */
		function dispatchRpcEvent (event:AbstractEvent) : void;
	}
}