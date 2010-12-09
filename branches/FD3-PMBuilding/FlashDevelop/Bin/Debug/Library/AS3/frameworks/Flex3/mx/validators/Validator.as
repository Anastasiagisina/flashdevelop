﻿package mx.validators
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import mx.binding.BindingManager;
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;
	import mx.events.ValidationResultEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when validation succeeds.
	 */
	[Event(name="valid", type="mx.events.ValidationResultEvent")] 
	/**
	 *  Dispatched when validation fails.
	 */
	[Event(name="invalid", type="mx.events.ValidationResultEvent")] 

	/**
	 *  The Validator class is the base class for all Flex validators. 
	 */
	public class Validator extends EventDispatcher implements IMXMLObject
	{
		/**
		 *  A string containing the upper- and lower-case letters
		 */
		protected static const ROMAN_LETTERS : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		/**
		 *  A String containing the decimal digits 0 through 9.
		 */
		protected static const DECIMAL_DIGITS : String = "0123456789";
		/**
		 *  @private
		 */
		private var document : Object;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var _listener : Object;
		/**
		 *  @private
		 */
		private var _property : String;
		/**
		 *  If <code>true</code>, specifies that a missing or empty 
		 */
		public var required : Boolean;
		/**
		 *  @private
		 */
		private var _resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _source : Object;
		/**
		 *  An Array of Strings containing the names for the properties contained 
		 */
		protected var subFields : Array;
		/**
		 *  @private
		 */
		private var _trigger : IEventDispatcher;
		/**
		 *  @private
		 */
		private var _triggerEvent : String;
		/**
		 *  @private
		 */
		private var _requiredFieldError : String;
		/**
		 *  @private
		 */
		private var requiredFieldErrorOverride : String;

		/**
		 *  Contains the trigger object, if any,
		 */
		protected function get actualTrigger () : IEventDispatcher;
		/**
		 *  Contains an Array of listener objects, if any,  
		 */
		protected function get actualListeners () : Array;
		/**
		 *  Setting this value to <code>false</code> will stop the validator
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 This behavior has been removed.
		 */
		public function get listener () : Object;
		/**
		 *  @private
		 */
		public function set listener (value:Object) : void;
		/**
		 *  A String specifying the name of the property
		 */
		public function get property () : String;
		/**
		 *  @private
		 */
		public function set property (value:String) : void;
		/**
		 *  @copy mx.core.UIComponent#resourceManager
		 */
		protected function get resourceManager () : IResourceManager;
		/**
		 *  Specifies the object containing the property to validate. 
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;
		/**
		 *  Specifies the component generating the event that triggers the validator. 
		 */
		public function get trigger () : IEventDispatcher;
		/**
		 *  @private
		 */
		public function set trigger (value:IEventDispatcher) : void;
		/**
		 *  Specifies the event that triggers the validation. 
		 */
		public function get triggerEvent () : String;
		/**
		 *  @private
		 */
		public function set triggerEvent (value:String) : void;
		/**
		 *  Error message when a value is missing and the 
		 */
		public function get requiredFieldError () : String;
		/**
		 *  @private
		 */
		public function set requiredFieldError (value:String) : void;

		/**
		 *  Invokes all the validators in the <code>validators</code> Array.
		 */
		public static function validateAll (validators:Array) : Array;
		/**
		 *  @private
		 */
		private static function findObjectFromString (doc:Object, value:String) : Object;
		/**
		 *  @private
		 */
		private static function trimString (str:String) : String;
		/**
		 *  Constructor.
		 */
		public function Validator ();
		/**
		 *  Called automatically by the MXML compiler when the Validator
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  This method is called when a Validator is constructed,
		 */
		protected function resourcesChanged () : void;
		/**
		 *  @private
		 */
		private function addTriggerHandler () : void;
		/**
		 *  @private
		 */
		private function removeTriggerHandler () : void;
		/**
		 *  Sets up all of the listeners for the 
		 */
		protected function addListenerHandler () : void;
		/**
		 *  Disconnects all of the listeners for the 
		 */
		protected function removeListenerHandler () : void;
		/**
		 *  Returns <code>true</code> if <code>value</code> is not null. 
		 */
		protected function isRealValue (value:Object) : Boolean;
		/**
		 *  Performs validation and optionally notifies
		 */
		public function validate (value:Object = null, suppressEvents:Boolean = false) : ValidationResultEvent;
		/**
		 *  Returns the Object to validate. Subclasses, such as the 
		 */
		protected function getValueFromSource () : Object;
		/**
		 *  @private 
		 */
		private function processValidation (value:Object, suppressEvents:Boolean) : ValidationResultEvent;
		/**
		 *  Executes the validation logic of this validator, 
		 */
		protected function doValidation (value:Object) : Array;
		/**
		 *  @private 
		 */
		private function validateRequired (value:Object) : ValidationResult;
		/**
		 *  Returns a ValidationResultEvent from the Array of error results. 
		 */
		protected function handleResults (errorResults:Array) : ValidationResultEvent;
		/**
		 *  @private
		 */
		private function triggerHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function resourceManager_changeHandler (event:Event) : void;
	}
}