﻿package mx.styles
{
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.utils.Timer;
	import flash.utils.describeType;
	import mx.core.FlexVersion;
	import mx.core.mx_internal;
	import mx.events.ModuleEvent;
	import mx.events.StyleEvent;
	import mx.managers.SystemManager;
	import mx.managers.SystemManagerGlobals;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.styles.IStyleModule;
	import flash.events.EventDispatcher;
	import mx.events.ModuleEvent;
	import mx.events.StyleEvent;
	import mx.modules.IModuleInfo;
	import mx.styles.IStyleModule;

	/**
	 *  @private
	 */
	public class StyleManagerImpl implements IStyleManager2
	{
		/**
		 *  @private
		 */
		private static var inheritingTextFormatStyles : Object;
		/**
		 *  @private
		 */
		private static var sizeInvalidatingStyles : Object;
		/**
		 *  @private
		 */
		private static var parentSizeInvalidatingStyles : Object;
		/**
		 *  @private
		 */
		private static var parentDisplayListInvalidatingStyles : Object;
		/**
		 *  @private
		 */
		private static var colorNames : Object;
		/**
		 *  @private
		 */
		private static var instance : IStyleManager2;
		/**
		 *  @private
		 */
		private var _selectors : Object;
		/**
		 *  @private
		 */
		private var styleModules : Object;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _stylesRoot : Object;
		/**
		 *  @private
		 */
		private var _inheritingStyles : Object;
		/**
		 *  @private
		 */
		private var _typeSelectorCache : Object;

		/**
		 *  @private
		 */
		public function get stylesRoot () : Object;
		public function set stylesRoot (value:Object) : void;
		/**
		 *  @private
		 */
		public function get inheritingStyles () : Object;
		public function set inheritingStyles (value:Object) : void;
		/**
		 *  @private
		 */
		public function get typeSelectorCache () : Object;
		public function set typeSelectorCache (value:Object) : void;
		/**
		 *  @review
		 */
		public function get selectors () : Array;

		/**
		 *  @private
		 */
		public static function getInstance () : IStyleManager2;
		/**
		 *  @private
		 */
		public function StyleManagerImpl ();
		/**
		 *  @private
		 */
		public function initProtoChainRoots () : void;
		/**
		 *  Gets the CSSStyleDeclaration object that stores the rules
		 */
		public function getStyleDeclaration (selector:String) : CSSStyleDeclaration;
		/**
		 *  Sets the CSSStyleDeclaration object that stores the rules
		 */
		public function setStyleDeclaration (selector:String, styleDeclaration:CSSStyleDeclaration, update:Boolean) : void;
		/**
		 *  Clears the CSSStyleDeclaration object that stores the rules
		 */
		public function clearStyleDeclaration (selector:String, update:Boolean) : void;
		/**
		 *  @private
		 */
		public function styleDeclarationsChanged () : void;
		/**
		 *  Adds to the list of styles that can inherit values
		 */
		public function registerInheritingStyle (styleName:String) : void;
		/**
		 *  Tests to see if a style is inheriting.
		 */
		public function isInheritingStyle (styleName:String) : Boolean;
		/**
		 *  Test to see if a TextFormat style is inheriting.
		 */
		public function isInheritingTextFormatStyle (styleName:String) : Boolean;
		/**
		 *  Adds to the list of styles which may affect the measured size
		 */
		public function registerSizeInvalidatingStyle (styleName:String) : void;
		/**
		 *  Tests to see if a style changes the size of a component.
		 */
		public function isSizeInvalidatingStyle (styleName:String) : Boolean;
		/**
		 *  Adds to the list of styles which may affect the measured size
		 */
		public function registerParentSizeInvalidatingStyle (styleName:String) : void;
		/**
		 *  Tests to see if the style changes the size of the component's parent container.
		 */
		public function isParentSizeInvalidatingStyle (styleName:String) : Boolean;
		/**
		 *  Adds to the list of styles which may affect the appearance
		 */
		public function registerParentDisplayListInvalidatingStyle (styleName:String) : void;
		/**
		 *  Tests to see if this style affects the component's parent container in
		 */
		public function isParentDisplayListInvalidatingStyle (styleName:String) : Boolean;
		/**
		 *  Adds a color name to the list of aliases for colors.
		 */
		public function registerColorName (colorName:String, colorValue:uint) : void;
		/**
		 *  Tests to see if the given String is an alias for a color value. For example,
		 */
		public function isColorName (colorName:String) : Boolean;
		/**
		 *  Returns the numeric RGB color value that corresponds to the
		 */
		public function getColorName (colorName:Object) : uint;
		/**
		 *  Converts each element of the colors Array from a color name
		 */
		public function getColorNames (colors:Array) : void;
		/**
		 *  Determines if a specified parameter is a valid style property. For example:
		 */
		public function isValidStyleValue (value:*) : Boolean;
		/**
		 *  @private
		 */
		public function loadStyleDeclarations (url:String, update:Boolean = true, trustContent:Boolean = false) : IEventDispatcher;
		/**
		 *  Loads a style SWF.
		 */
		public function loadStyleDeclarations2 (url:String, update:Boolean = true, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null) : IEventDispatcher;
		/**
		 *  Unloads a style SWF.
		 */
		public function unloadStyleDeclarations (url:String, update:Boolean = true) : void;
	}
	/**
	 *  @private
	 */
	internal class StyleEventDispatcher extends EventDispatcher
	{
		/**
		 *  Constructor
		 */
		public function StyleEventDispatcher (moduleInfo:IModuleInfo);
		/**
		 *  @private
		 */
		private function moduleInfo_errorHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleInfo_progressHandler (event:ModuleEvent) : void;
		/**
		 *  @private
		 */
		private function moduleInfo_readyHandler (event:ModuleEvent) : void;
	}
	/**
	 *  @private
	 */
	internal class StyleModuleInfo
	{
		/**
		 *  @private
		 */
		public var errorHandler : Function;
		/**
		 *  @private
		 */
		public var readyHandler : Function;
		/**
		 *  @private
		 */
		public var styleModule : IStyleModule;
		/**
		 *  @private
		 */
		public var module : IModuleInfo;

		/**
		 *  Constructor
		 */
		public function StyleModuleInfo (module:IModuleInfo, readyHandler:Function, errorHandler:Function);
	}
}