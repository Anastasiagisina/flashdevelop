﻿package mx.states
{
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The SetProperty class specifies a property value that is in effect only 
	 */
	public class SetProperty implements IOverride
	{
		/**
		 *  @private
		 */
		private static const PSEUDONYMS : Object;
		/**
		 *  @private
		 */
		private const RELATED_PROPERTIES : Object;
		/**
		 *  @private
		 */
		private var oldValue : Object;
		/**
		 *  @private
		 */
		private var oldRelatedValues : Array;
		/**
		 *  The name of the property to change.
		 */
		public var name : String;
		/**
		 *  The object containing the property to be changed.
		 */
		public var target : Object;
		/**
		 *  The new value for the property.
		 */
		public var value : *;

		/**
		 *  IOverride interface method; this class implements it as an empty method.
		 */
		public function initialize () : void;
		/**
		 *  @inheritDoc
		 */
		public function apply (parent:UIComponent) : void;
		/**
		 *  @inheritDoc
		 */
		public function remove (parent:UIComponent) : void;
		/**
		 *  @private
		 */
		private function setPropertyValue (obj:Object, name:String, value:*, valueForType:Object) : void;
		/**
		 *  @private
		 */
		private function toBoolean (value:Object) : Boolean;
	}
}