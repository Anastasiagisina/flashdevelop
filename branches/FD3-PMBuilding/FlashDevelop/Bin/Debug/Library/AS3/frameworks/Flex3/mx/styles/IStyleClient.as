﻿package mx.styles
{
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  This interface describes the properties and methods that an object 
	 */
	public interface IStyleClient extends ISimpleStyleClient
	{
		/**
		 *  The name of the component class.
		 */
		public function get className () : String;
		/**
		 *  An object containing the inheritable styles for this component.
		 */
		public function get inheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set inheritingStyles (value:Object) : void;
		/**
		 *  An object containing the noninheritable styles for this component.
		 */
		public function get nonInheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set nonInheritingStyles (value:Object) : void;
		/**
		 *  The style declaration used by this object.
		 */
		public function get styleDeclaration () : CSSStyleDeclaration;
		/**
		 *  @private
		 */
		public function set styleDeclaration (value:CSSStyleDeclaration) : void;

		/**
		 *  Gets a style property that has been set anywhere in this
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  Sets a style property on this component instance.
		 */
		public function setStyle (styleProp:String, newValue:*) : void;
		/**
		 *  Deletes a style property from this component instance.
		 */
		public function clearStyle (styleProp:String) : void;
		/**
		 *  Returns an Array of CSSStyleDeclaration objects for the type selector
		 */
		public function getClassStyleDeclarations () : Array;
		/**
		 *  Propagates style changes to the children of this component.
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  Sets up the internal style cache values so that the <code>getStyle()</code> 
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  Registers the EffectManager as one of the event listeners for each effect event.
		 */
		public function registerEffects (effects:Array) : void;
	}
}