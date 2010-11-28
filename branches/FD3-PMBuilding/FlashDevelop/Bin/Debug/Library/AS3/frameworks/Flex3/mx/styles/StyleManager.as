﻿package mx.styles
{
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import mx.core.Singleton;
	import mx.core.mx_internal;

	/**
	 *  The StyleManager class manages the following:
	 */
	public class StyleManager
	{
		/**
		 *  The <code>getColorName()</code> method returns this value if the passed-in
		 */
		public static const NOT_A_COLOR : uint = 0xFFFFFFFF;
		/**
		 *  @private
		 */
		private static var implClassDependency : StyleManagerImpl;
		/**
		 *  @private
		 */
		private static var _impl : IStyleManager2;

		/**
		 *  @private
		 */
		private static function get impl () : IStyleManager2;
		/**
		 *  @private
		 */
		static function get stylesRoot () : Object;
		static function set stylesRoot (value:Object) : void;
		/**
		 *  @private
		 */
		static function get inheritingStyles () : Object;
		static function set inheritingStyles (value:Object) : void;
		/**
		 *  @private
		 */
		static function get typeSelectorCache () : Object;
		static function set typeSelectorCache (value:Object) : void;
		/**
		 *  Returns an Array of all the CSS selectors that are registered with the StyleManager.
		 */
		public static function get selectors () : Array;

		/**
		 *  @private
		 */
		static function initProtoChainRoots () : void;
		/**
		 *  Gets the CSSStyleDeclaration object that stores the rules
		 */
		public static function getStyleDeclaration (selector:String) : CSSStyleDeclaration;
		/**
		 *  Sets the CSSStyleDeclaration object that stores the rules
		 */
		public static function setStyleDeclaration (selector:String, styleDeclaration:CSSStyleDeclaration, update:Boolean) : void;
		/**
		 *  Clears the CSSStyleDeclaration object that stores the rules
		 */
		public static function clearStyleDeclaration (selector:String, update:Boolean) : void;
		/**
		 *  @private
		 */
		static function styleDeclarationsChanged () : void;
		/**
		 *  Adds to the list of styles that can inherit values
		 */
		public static function registerInheritingStyle (styleName:String) : void;
		/**
		 *  Tests to see if a style is inheriting.
		 */
		public static function isInheritingStyle (styleName:String) : Boolean;
		/**
		 *  Test to see if a TextFormat style is inheriting.
		 */
		public static function isInheritingTextFormatStyle (styleName:String) : Boolean;
		/**
		 *  Adds to the list of styles which may affect the measured size
		 */
		public static function registerSizeInvalidatingStyle (styleName:String) : void;
		/**
		 *  Tests to see if a style changes the size of a component.
		 */
		public static function isSizeInvalidatingStyle (styleName:String) : Boolean;
		/**
		 *  Adds to the list of styles which may affect the measured size
		 */
		public static function registerParentSizeInvalidatingStyle (styleName:String) : void;
		/**
		 *  Tests to see if the style changes the size of the component's parent container.
		 */
		public static function isParentSizeInvalidatingStyle (styleName:String) : Boolean;
		/**
		 *  Adds to the list of styles which may affect the appearance
		 */
		public static function registerParentDisplayListInvalidatingStyle (styleName:String) : void;
		/**
		 *  Tests to see if this style affects the component's parent container in
		 */
		public static function isParentDisplayListInvalidatingStyle (styleName:String) : Boolean;
		/**
		 *  Adds a color name to the list of aliases for colors.
		 */
		public static function registerColorName (colorName:String, colorValue:uint) : void;
		/**
		 *  Tests to see if the given String is an alias for a color value. For example,
		 */
		public static function isColorName (colorName:String) : Boolean;
		/**
		 *  Returns the numeric RGB color value that corresponds to the
		 */
		public static function getColorName (colorName:Object) : uint;
		/**
		 *  Converts each element of the colors Array from a color name
		 */
		public static function getColorNames (colors:Array) : void;
		/**
		 *  Determines if a specified parameter is a valid style property. For example:
		 */
		public static function isValidStyleValue (value:*) : Boolean;
		/**
		 *  Loads a style SWF.
		 */
		public static function loadStyleDeclarations (url:String, update:Boolean = true, trustContent:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null) : IEventDispatcher;
		/**
		 *  Unloads a style SWF.
		 */
		public static function unloadStyleDeclarations (url:String, update:Boolean = true) : void;
	}
}