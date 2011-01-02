﻿package mx.rpc.soap.mxml
{
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.IEventDispatcher;
	import mx.core.IMXMLObject;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.mxml.Concurrency;
	import mx.rpc.mxml.IMXMLSupport;
	import mx.rpc.soap.mxml.Operation;
	import mx.rpc.soap.WebService;

	/**
	 * The &lt;mx:WebService&gt; tag gives you access to the operations of SOAP-compliant
	 */
	public dynamic class WebService extends mx.rpc.soap.WebService implements IMXMLSupport
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		local var document : Object;
		local var id : String;
		private var _concurrency : String;
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
		 * Deprecated, use the appropriate destination instead, or if using a url, use <code>DefaultHTTP</code> or <code>DefaultHTTPS</code>.
		 */
		public function set protocol (protocol:String) : void;
		public function get serviceName () : String;
		public function set serviceName (sn:String) : void;
		/**
		 * If <code>true</code>, a busy cursor is displayed while a service is executing. The default
		 */
		public function get showBusyCursor () : Boolean;
		public function set showBusyCursor (sbc:Boolean) : void;

		/**
		 * Creates a new WebService component.
		 */
		public function WebService (destination:String = null);
		/**
		 * This handler is called after the document fires the creationComplete event so that
		 */
		public function creationComplete (event:Event) : void;
		/**
		 * If this event is an error or fault, and the event type does not
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 * Returns an Operation of the given name. If the Operation wasn't
		 */
		public function getOperation (name:String) : AbstractOperation;
		/**
		 * Called automatically by the MXML compiler if the WebService is setup using a tag.  If you create
		 */
		public function initialized (document:Object, id:String) : void;
	}
}