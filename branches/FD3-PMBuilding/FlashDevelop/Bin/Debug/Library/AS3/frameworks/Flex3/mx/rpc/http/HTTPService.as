﻿package mx.rpc.http
{
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import mx.core.mx_internal;
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.messaging.config.LoaderConfig;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AbstractInvoker;
	import mx.rpc.AsyncDispatcher;
	import mx.rpc.AsyncRequest;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.rpc.xml.SimpleXMLEncoder;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	import mx.utils.URLUtil;

	/**
	 *  Dispatched when an HTTPService call returns successfully.
	 */
	[Event(name="result", type="mx.rpc.events.ResultEvent")] 
	/**
	 *  Dispatched when an HTTPService call fails.
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")] 
	/**
	 *  The invoke event is fired when an HTTPService call is invoked so long as
	 */
	[Event(name="invoke", type="mx.rpc.events.InvokeEvent")] 

	/**
	 * You use the <code>&lt;mx:HTTPService&gt;</code> tag to represent an
	 */
	public class HTTPService extends AbstractInvoker
	{
		/**
		 *  The result format "e4x" specifies that the value returned is an XML instance, which can be accessed using ECMAScript for XML (E4X) expressions.
		 */
		public static const RESULT_FORMAT_E4X : String = "e4x";
		/**
		 *  The result format "flashvars" specifies that the value returned is text containing name=value pairs
		 */
		public static const RESULT_FORMAT_FLASHVARS : String = "flashvars";
		/**
		 *  The result format "object" specifies that the value returned is XML but is parsed as a tree of ActionScript objects. This is the default.
		 */
		public static const RESULT_FORMAT_OBJECT : String = "object";
		/**
		 *  The result format "array" is similar to "object" however the value returned is always an Array such
		 */
		public static const RESULT_FORMAT_ARRAY : String = "array";
		/**
		 *  The result format "text" specifies that the HTTPService result text should be an unprocessed String.
		 */
		public static const RESULT_FORMAT_TEXT : String = "text";
		/**
		 *  The result format "xml" specifies that results should be returned as an flash.xml.XMLNode instance pointing to
		 */
		public static const RESULT_FORMAT_XML : String = "xml";
		/**
		 *  Indicates that the data being sent by the HTTP service is encoded as application/xml.
		 */
		public static const CONTENT_TYPE_XML : String = "application/xml";
		/**
		 *  Indicates that the data being sent by the HTTP service is encoded as application/x-www-form-urlencoded.
		 */
		public static const CONTENT_TYPE_FORM : String = "application/x-www-form-urlencoded";
		/**
		 *  Indicates that the HTTPService object uses the DefaultHTTP destination.
		 */
		public static const DEFAULT_DESTINATION_HTTP : String = "DefaultHTTP";
		/**
		 *  Indicates that the HTTPService object uses the DefaultHTTPS destination.
		 */
		public static const DEFAULT_DESTINATION_HTTPS : String = "DefaultHTTPS";
		/**
		 *  Indicates that the useProxy property was set to false but a url was not provided.
		 */
		public static const ERROR_URL_REQUIRED : String = "Client.URLRequired";
		/**
		 *  Indicates that an XML formatted result could not be parsed into an XML instance
		 */
		public static const ERROR_DECODING : String = "Client.CouldNotDecode";
		/**
		 *  Indicates that an input parameter could not be encoded as XML.
		 */
		public static const ERROR_ENCODING : String = "Client.CouldNotEncode";
		/**
		 *  @private
		 */
		private static var _directChannelSet : ChannelSet;
		/**
		 *  @private
		 */
		private var _log : ILogger;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  Type of content for service requests. 
		 */
		public var contentType : String;
		/**
		 *  Custom HTTP headers to be sent to the third party endpoint. If multiple headers need to
		 */
		public var headers : Object;
		/**
		 *  HTTP method for sending the request. Permitted values are <code>GET</code>, <code>POST</code>, <code>HEAD</code>,
		 */
		public var method : String;
		/**
		 *  Object of name-value pairs used as parameters to the URL. If
		 */
		public var request : Object;
		/**
		 *  @private
		 */
		private var _resultFormat : String;
		/**
		 *  @private
		 */
		local var _rootURL : String;
		/**
		 *  @private
		 */
		private var _url : String;
		/**
		 *  @private
		 */
		private var _useProxy : Boolean;
		/**
		 *  ActionScript function used to decode a service result from XML.
		 */
		public var xmlDecode : Function;
		/**
		 *  ActionScript function used to encode a service request as XML.
		 */
		public var xmlEncode : Function;

		/**
		 *  Provides access to the ChannelSet used by the service. The
		 */
		public function get channelSet () : ChannelSet;
		/**
		 *  @private
		 */
		public function set channelSet (value:ChannelSet) : void;
		/**
		 *  An HTTPService destination name in the services-config.xml file. When
		 */
		public function get destination () : String;
		/**
		 *  @private
		 */
		public function set destination (value:String) : void;
		/**
		 *  Provides access to the request timeout in seconds for sent messages. 
		 */
		public function get requestTimeout () : int;
		/**
		 *  @private
		 */
		public function set requestTimeout (value:int) : void;
		/**
		 *  Value that indicates how you want to deserialize the result
		 */
		public function get resultFormat () : String;
		/**
		 *  @private
		 */
		public function set resultFormat (value:String) : void;
		/**
		 *  The URL that the HTTPService object should use when computing relative URLs.
		 */
		public function get rootURL () : String;
		/**
		 *  @private
		 */
		public function set rootURL (value:String) : void;
		/**
		 *  Location of the service. If you specify the <code>url</code> and a non-default destination,
		 */
		public function get url () : String;
		/**
		 *  @private
		 */
		public function set url (value:String) : void;
		/**
		 *  Specifies whether to use the Flex proxy service. The default value is <code>false</code>. If you
		 */
		public function get useProxy () : Boolean;
		/**
		 *  @private
		 */
		public function set useProxy (value:Boolean) : void;

		/**
		 *  Creates a new HTTPService. If you expect the service to send using relative URLs you may
		 */
		public function HTTPService (rootURL:String = null, destination:String = null);
		/**
		 *  Logs the user out of the destination. 
		 */
		public function logout () : void;
		/**
		 *  Executes an HTTPService request. The parameters are optional, but if specified should
		 */
		public function send (parameters:Object = null) : AsyncToken;
		/**
		 *  Disconnects the service's network connection.
		 */
		public function disconnect () : void;
		/**
		 *  Sets the credentials for the destination accessed by the service.
		 */
		public function setCredentials (username:String, password:String, charset:String = null) : void;
		/**
		 *  The username and password to authenticate a user when accessing
		 */
		public function setRemoteCredentials (remoteUsername:String, remotePassword:String, charset:String = null) : void;
		/**
		 *  @private
		 */
		function processResult (message:IMessage, token:AsyncToken) : Boolean;
		private function decodeArray (o:Object) : Object;
		private function decodeParameterString (source:String) : Object;
		private function getDirectChannelSet () : ChannelSet;
	}
}