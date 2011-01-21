﻿package mx.rpc.xml
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import mx.utils.Base64Encoder;
	import mx.utils.Base64Decoder;
	import mx.utils.HexEncoder;
	import mx.utils.HexDecoder;
	import mx.utils.StringUtil;

	/**
	 * FIXME: Derivations and restrictions need to be considered in addition
	 */
	public class SchemaMarshaller
	{
		/**
		 * A Boolean flag to determines whether ActionScript ByteArrays should be
		 */
		public static var byteArrayAsBase64Binary : Boolean;
		/**
		 * A RegEx pattern to help replace all whitespace characters in the content
		 */
		public static var whitespaceReplacePattern : RegExp;
		/**
		 * A RegEx pattern to help collapse all consecutive whitespace characters in
		 */
		public static var whitespaceCollapsePattern : RegExp;
		/**
		 * A RegEx pattern to help trim all leading and trailing spaces in the
		 */
		public static var whitespaceTrimPattern : RegExp;
		public static const FLOAT_MAX_VALUE : Number = (Math.pow(2, 24) - 1) * Math.pow(2, 104);
		public static const FLOAT_MIN_VALUE : Number = Math.pow(2, -149);
		public static const LONG_MAX_VALUE : Number = 9223372036854775807;
		public static const LONG_MIN_VALUE : Number = -9223372036854775808;
		public static const SHORT_MAX_VALUE : Number = 32767;
		public static const SHORT_MIN_VALUE : Number = -32768;
		public static const BYTE_MAX_VALUE : Number = 127;
		public static const BYTE_MIN_VALUE : Number = -128;
		public static const ULONG_MAX_VALUE : Number = 18446744073709551615;
		public static const USHORT_MAX_VALUE : Number = 65535;
		public static const UBYTE_MAX_VALUE : Number = 255;
		private var marshallers : Object;
		private var unmarshallers : Object;
		private var constants : SchemaConstants;
		private var datatypes : SchemaDatatypes;
		private var _validating : Boolean;

		/**
		 * Determines whether this marshaller will throw errors for input that
		 */
		public function get validating () : Boolean;
		public function set validating (value:Boolean) : void;

		public function SchemaMarshaller (constants:SchemaConstants, datatypes:SchemaDatatypes);
		/**
		 * This function converts an ActionScript value to a String for XML
		 */
		public function marshall (value:*, type:QName = null, restriction:XML = null) : *;
		/**
		 * This function converts XML simple content (formatted based on a built-in
		 */
		public function unmarshall (value:*, type:QName = null, restriction:XML = null) : *;
		/**
		 * In the case of XML Schema ur-types such as <code>anyType</code> and
		 */
		public function marshallAny (value:*, type:QName = null, restriction:XML = null) : *;
		public function marshallBase64Binary (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * The boolean schema type allows the string values 'true' or
		 */
		public function marshallBoolean (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallDatetime (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * FIXME: Handle precision and exponent restrictions.
		 */
		public function marshallDecimal (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * FIXME: Handle precision and exponent restrictions.
		 */
		public function marshallDouble (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallDuration (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * FIXME: Handle precision and exponent restrictions.
		 */
		public function marshallFloat (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallGregorian (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * The schema type hexBinary represents arbitrary hex-encoded binary data.
		 */
		public function marshallHexBinary (value:*, type:QName = null, restriction:XML = null) : String;
		/**
		 * The schema type integer is dervied from the decimal type via restrictions
		 */
		public function marshallInteger (value:*, type:QName = null, restriction:XML = null) : String;
		public function marshallString (value:*, type:QName = null, restriction:XML = null) : String;
		public function unmarshallAny (value:*, type:QName = null, restriction:XML = null) : *;
		public function unmarshallBase64Binary (value:*, type:QName = null, restriction:XML = null) : ByteArray;
		public function unmarshallBoolean (value:*, type:QName = null, restriction:XML = null) : Boolean;
		public function unmarshallDate (value:*, type:QName = null, restriction:XML = null) : Object;
		/**
		 * Handles dateTime and time types.
		 */
		public function unmarshallDatetime (value:*, type:QName = null, restriction:XML = null) : Object;
		public function unmarshallDecimal (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallDouble (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallDuration (value:*, type:QName = null, restriction:XML = null) : *;
		public function unmarshallFloat (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallGregorian (value:*, type:QName = null, restriction:XML = null) : *;
		public function unmarshallHexBinary (value:*, type:QName = null, restriction:XML = null) : ByteArray;
		public function unmarshallInteger (value:*, type:QName = null, restriction:XML = null) : Number;
		public function unmarshallString (value:*, type:QName = null, restriction:XML = null) : String;
		public static function guessSimpleType (value:*) : *;
		private static function specialNumber (value:Number) : String;
		/**
		 * For simple types with the whitespace restriction <code>collapse</code>
		 */
		private static function whitespaceCollapse (value:*) : String;
		/**
		 * For simple types with the whitespace restriction <code>replace</code>
		 */
		private static function whitespaceReplace (value:*) : String;
		private function registerMarshallers () : void;
	}
}