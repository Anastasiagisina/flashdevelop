﻿package mx.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import mx.core.IPropertyChangeNotifier;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;

	/**
	 *  This class provides the ability to track changes to an item
	 */
	flash_proxy dynamic class ObjectProxy extends Proxy implements IExternalizable
	{
		/**
		 *  A reference to the EventDispatcher for this proxy.
		 */
		protected var dispatcher : EventDispatcher;
		/**
		 *  A hashmap of property change notifiers that this proxy is 
		 */
		protected var notifiers : Object;
		/**
		 *  Indicates what kind of proxy to create
		 */
		protected var proxyClass : Class;
		/**
		 *  Contains a list of all of the property names for the proxied object.
		 */
		protected var propertyList : Array;
		/**
		 *  Indicates how deep proxying should be performed.
		 */
		private var _proxyLevel : int;
		/**
		 *  Storage for the object property.
		 */
		private var _item : Object;
		/**
		 *  @private
		 */
		private var _type : QName;
		/**
		 *  @private
		 */
		private var _id : String;

		/**
		 *  The object being proxied.
		 */
		function get object () : Object;
		/**
		 *  The qualified type name associated with this object.
		 */
		function get type () : QName;
		/**
		 *  @private
		 */
		function set type (value:QName) : void;
		/**
		 *  The unique identifier for this object.
		 */
		public function get uid () : String;
		/**
		 *  @private
		 */
		public function set uid (value:String) : void;

		/**
		 *  Initializes this proxy with the specified object, id and proxy depth.
		 */
		public function ObjectProxy (item:Object = null, uid:String = null, proxyDepth:int = -1);
		/**
		 *  Returns the specified property value of the proxied object.
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 *  Returns the value of the proxied object's method with the specified name.
		 */
		flash_proxy function callProperty (name:*, ...rest) : *;
		/**
		 *  Deletes the specified property on the proxied object and
		 */
		flash_proxy function deleteProperty (name:*) : Boolean;
		/**
		 *  @private
		 */
		flash_proxy function hasProperty (name:*) : Boolean;
		/**
		 *  @private
		 */
		flash_proxy function nextName (index:int) : String;
		/**
		 *  @private
		 */
		flash_proxy function nextNameIndex (index:int) : int;
		/**
		 *  @private
		 */
		flash_proxy function nextValue (index:int) : *;
		/**
		 *  Updates the specified property on the proxied object
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
		/**
		 *  Provides a place for subclasses to override how a complex property that
		 */
		function getComplexProperty (name:*, value:*) : *;
		/**
		 *  Since Flex only uses ObjectProxy to wrap anonymous objects,
		 */
		public function readExternal (input:IDataInput) : void;
		/**
		 *  Since Flex only serializes the inner ActionScript object that it wraps,
		 */
		public function writeExternal (output:IDataOutput) : void;
		/**
		 *  Registers an event listener object  
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 *  Removes an event listener. 
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *  Dispatches an event into the event flow. 
		 */
		public function dispatchEvent (event:Event) : Boolean;
		/**
		 *  Checks whether there are any event listeners registered 
		 */
		public function hasEventListener (type:String) : Boolean;
		/**
		 *  Checks whether an event listener is registered with this object 
		 */
		public function willTrigger (type:String) : Boolean;
		/**
		 *  Called when a complex property is updated.
		 */
		public function propertyChangeHandler (event:PropertyChangeEvent) : void;
		/**
		 *  This method creates an array of all of the property names for the 
		 */
		protected function setupPropertyList () : void;
	}
}