﻿package mx.rpc.xml
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import mx.collections.ArrayCollection;
	import mx.utils.DescribeTypeCache;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	import mx.collections.IList;

	/**
	 * Encodes an ActionScript Object graph to XML based on an XML Schema.
	 */
	public class XMLEncoder extends SchemaProcessor implements IXMLEncoder
	{
		private var _strictNillability : Boolean;
		private var _xmlSpecialCharsFilter : Function;

		/**
		 *
		 */
		public function get strictNillability () : Boolean;
		/**
		 *
		 */
		public function set strictNillability (strict:Boolean) : void;
		/**
		 * Function to be used for escaping XML special characters in simple content.
		 */
		public function get xmlSpecialCharsFilter () : Function;
		/**
		 *
		 */
		public function set xmlSpecialCharsFilter (func:Function) : void;

		public function XMLEncoder ();
		/**
		 * Encodes an ActionScript value as XML.
		 */
		public function encode (value:*, name:QName = null, type:QName = null, definition:XML = null) : XMLList;
		/**
		 * All content:
		 */
		public function encodeAll (definition:XML, parent:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * Encodes any complex object values as attributes using the XML schema
		 */
		public function encodeAnyAttribute (definition:XML, parent:XML, name:QName, value:* = undefined, restriction:XML = null) : void;
		/**
		 * Encodes elements based on wildcard rules.
		 */
		public function encodeAnyElement (definition:XML, siblings:XMLList, name:QName, value:*, isRequired:Boolean = true, encodedVals:Dictionary = null) : Boolean;
		/**
		 * An attribute must be based on a simple type and thus will have simple
		 */
		public function encodeAttribute (definition:XML, parent:XML, name:QName, value:* = undefined, restriction:XML = null) : void;
		/**
		 * An <code>attributeGroup</code> definition may include a number of
		 */
		public function encodeAttributeGroup (definition:XML, parent:XML, name:QName, value:* = undefined, restriction:XML = null) : void;
		/**
		 * choice:
		 */
		public function encodeChoice (definition:XML, parent:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * Derivation by restriction takes an existing type as the base and creates
		 */
		public function encodeComplexContent (definition:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * complexContent:
		 */
		public function encodeComplexExtension (definition:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * complexContent:
		 */
		public function encodeComplexRestriction (restriction:XML, parent:XML, name:QName, value:*) : void;
		public function encodeComplexType (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Used to encode a local element definition (inside a model group).
		 */
		public function encodeGroupElement (definition:XML, siblings:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * Element content:
		 */
		public function encodeElementTopLevel (definition:XML, elementQName:QName, value:*) : XML;
		/**
		 * The <code>group</code> element allows partial (or complete) content
		 */
		public function encodeGroupReference (definition:XML, parent:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * sequence:
		 */
		public function encodeSequence (definition:XML, siblings:XMLList, name:QName, value:*, isRequired:Boolean = true) : Boolean;
		/**
		 * <code>simpleContent</code> specifies that the content will be simple text
		 */
		public function encodeSimpleContent (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * A <code>simpleType</code> may declare a list of space separated
		 */
		public function encodeSimpleList (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * simpleType:
		 */
		public function encodeSimpleRestriction (restriction:XML, parent:XML, name:QName, value:*) : void;
		/**
		 * <simpleType
		 */
		public function encodeSimpleType (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * <union
		 */
		public function encodeSimpleUnion (definition:XML, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Allow instance specific overrides for concrete type information as
		 */
		public function encodeType (type:QName, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Sets the xsi:nil attribute when necessary
		 */
		public function encodeXSINil (definition:XML, name:QName, value:*, isRequired:Boolean = true) : XML;
		/**
		 * @private
		 */
		public function getAttribute (parent:*, name:*) : *;
		/**
		 * @private
		 */
		public function hasAttribute (parent:*, name:*) : Boolean;
		/**
		 * @private
		 */
		public function setAttribute (parent:XML, name:*, value:*) : void;
		/**
		 * @private
		 */
		public function getProperties (value:*) : Array;
		/**
		 * Returns a single XML node with the given name
		 */
		public function createElement (name:*) : XML;
		/**
		 * @private
		 */
		public function getSimpleValue (parent:*, name:*) : *;
		/**
		 * Determines whether a value should be representable as a single, simple
		 */
		public function isSimpleValue (value:*) : Boolean;
		/**
		 * @private
		 */
		public function getValue (parent:*, name:*) : *;
		/**
		 * @private
		 */
		public function hasValue (parent:*, name:*) : Boolean;
		/**
		 * @private
		 */
		public function containsNodeByName (list:XMLList, name:QName, strict:Boolean = false) : Boolean;
		/**
		 * Looks up value by name on a complex parent object, considering that the
		 */
		public function resolveNamedProperty (parent:*, name:*) : *;
		/**
		 * Assigns value to an XML node.
		 */
		public function setValue (parent:*, value:*) : void;
		/**
		 * Appends a value (or list of values) directly as
		 */
		public function appendValue (parent:XMLList, value:*) : void;
		/**
		 * Checks to see whether a value defines a custom XSI type to be used
		 */
		protected function getXSIType (value:*) : QName;
		/**
		 * Record custom XSI type information for this XML node by adding an
		 */
		protected function setXSIType (parent:XML, type:QName) : void;
		/**
		 * @private
		 */
		protected function deriveXSIType (parent:XML, type:QName, value:*) : void;
		/**
		 * @private
		 */
		private function escapeXML (value:Object) : String;
	}
}