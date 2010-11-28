﻿package mx.rpc.soap
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import mx.core.mx_internal;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.soap.types.ICustomSOAPType;
	import mx.rpc.wsdl.WSDLConstants;
	import mx.rpc.wsdl.WSDLEncoding;
	import mx.rpc.wsdl.WSDLOperation;
	import mx.rpc.wsdl.WSDLMessage;
	import mx.rpc.wsdl.WSDLMessagePart;
	import mx.rpc.xml.Schema;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.SchemaDatatypes;
	import mx.rpc.xml.SchemaMarshaller;
	import mx.rpc.xml.XMLEncoder;

	/**
	 * A SOAPEncoder is used to create SOAP 1.1 formatted requests for a web service
	 */
	public class SOAPEncoder extends XMLEncoder implements ISOAPEncoder
	{
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		private var _ignoreWhitespace : Boolean;
		private var isSOAPEncoding : Boolean;
		private var log : ILogger;
		private var _wsdlOperation : WSDLOperation;

		/**
		 * Determines whether the encoder should ignore whitespace when
		 */
		public function get ignoreWhitespace () : Boolean;
		public function set ignoreWhitespace (value:Boolean) : void;
		/**
		 * @private
		 */
		protected function get inputEncoding () : WSDLEncoding;
		public function get schemaConstants () : SchemaConstants;
		public function get soapConstants () : SOAPConstants;
		public function get wsdlOperation () : WSDLOperation;
		public function set wsdlOperation (value:WSDLOperation) : void;

		public function SOAPEncoder ();
		/**
		 * Creates a SOAP encodes request to an operation from the given input
		 */
		public function encodeRequest (args:* = null, headers:Array = null) : XML;
		/**
		 * A SOAP Envelope element is the root element of a SOAP message. It
		 */
		protected function encodeEnvelope (args:*, headers:Array) : XML;
		/**
		 * Appends SOAP Header to the SOAP Envelope
		 */
		protected function encodeHeaders (headers:Array, envelopeXML:XML) : void;
		/**
		 * Appends a header element to top SOAP Header tag
		 */
		protected function encodeHeaderElement (header:Object, headersXML:XML) : void;
		/**
		 * Encodes the SOAP Body. Currently assumes only one operation sub-element.
		 */
		protected function encodeBody (inputParams:*, envelopeXML:XML) : void;
		/**
		 * Encodes a WSDL operation using document literal format.
		 */
		protected function encodeOperationAsDocumentLiteral (inputParams:Object, bodyXML:XML) : void;
		/**
		 * Encodes a WSDL operation using RPC literal format.
		 */
		protected function encodeOperationAsRPCLiteral (inputParams:Object, bodyXML:XML) : void;
		/**
		 * Encodes a WSDL message part using RPC encoded format.
		 */
		protected function encodeOperationAsRPCEncoded (inputParams:*, bodyXML:XML) : void;
		/**
		 * Encodes an input message for a WSDL operation. The provided input
		 */
		protected function encodeMessage (inputParams:*, operationXML:XML) : void;
		/**
		 * A WSDL message part may either refer to an XML Schema type (that is, a
		 */
		protected function encodePartValue (part:WSDLMessagePart, value:*) : XMLList;
		/**
		 * Looks to see whether a pre-encoded SOAP request has been passed to the
		 */
		protected function preEncodedCheck (value:*) : Object;
		/**
		 * SOAP specific override to handle special wrapped-style document-literal 
		 */
		public function encode (value:*, name:QName = null, type:QName = null, definition:XML = null) : XMLList;
		/**
		 * SOAP specific override to intercept SOAP encoded types such as base64.
		 */
		public function encodeType (type:QName, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * This override intercepts encoding a complexType with complexContent based
		 */
		public function encodeComplexRestriction (restriction:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * This override tries to determine the XSI type for the encoded value if
		 */
		protected function deriveXSIType (parent:XML, type:QName, value:*) : void;
	}
}