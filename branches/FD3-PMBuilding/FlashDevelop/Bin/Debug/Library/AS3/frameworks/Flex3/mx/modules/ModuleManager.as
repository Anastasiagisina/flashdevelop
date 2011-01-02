﻿package mx.modules
{
	import flash.utils.ByteArray;
	import mx.core.IFlexModuleFactory;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.core.IFlexModuleFactory;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;

	/**
	 *  The ModuleManager class centrally manages dynamically loaded modules.
	 */
	public class ModuleManager
	{
		/**
		 *  Get the IModuleInfo interface associated with a particular URL.
		 */
		public static function getModule (url:String) : IModuleInfo;
		/**
		 *  See if the referenced object is associated with (or, in the managed
		 */
		public static function getAssociatedFactory (object:Object) : IFlexModuleFactory;
		/**
		 *  @private
		 */
		private static function getSingleton () : Object;
	}
	/**
	 *  @private
	 */
	internal class ModuleManagerImpl extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private var moduleList : Object;

		/**
		 *  Constructor.
		 */
		public function ModuleManagerImpl ();
		/**
		 *  @private
		 */
		public function getAssociatedFactory (object:Object) : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function getModule (url:String) : IModuleInfo;
	}
	/**
	 *  @private
	 */
	internal class ModuleInfo extends EventDispatcher
	{
		/**
		 *  @private
		 */
		private var factoryInfo : FactoryInfo;
		/**
		 *  @private
		 */
		private var limbo : Dictionary;
		/**
		 *  @private
		 */
		private var loader : Loader;
		/**
		 *  @private
		 */
		private var numReferences : int;
		/**
		 *  @private
		 */
		private var _error : Boolean;
		/**
		 *  @private
		 */
		private var _loaded : Boolean;
		/**
		 *  @private
		 */
		private var _ready : Boolean;
		/**
		 *  @private
		 */
		private var _setup : Boolean;
		/**
		 *  @private
		 */
		private var _url : String;

		/**
		 *  @private
		 */
		public function get applicationDomain () : ApplicationDomain;
		/**
		 *  @private
		 */
		public function get error () : Boolean;
		/**
		 *  @private
		 */
		public function get factory () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function get loaded () : Boolean;
		/**
		 *  @private
		 */
		public function get ready () : Boolean;
		/**
		 *  @private
		 */
		public function get setup () : Boolean;
		/**
		 *  @private
		 */
		public function get size () : int;
		/**
		 *  @private
		 */
		public function get url () : String;

		/**
		 *  Constructor.
		 */
		public function ModuleInfo (url:String);
		/**
		 *  @private
		 */
		public function load (applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null, bytes:ByteArray = null) : void;
		/**
		 *  @private
		 */
		private function loadBytes (applicationDomain:ApplicationDomain, bytes:ByteArray) : void;
		/**
		 *  @private
		 */
		public function resurrect () : void;
		/**
		 *  @private
		 */
		public function release () : void;
		/**
		 *  @private
		 */
		private function clearLoader () : void;
		/**
		 *  @private
		 */
		public function unload () : void;
		/**
		 *  @private
		 */
		public function publish (factory:IFlexModuleFactory) : void;
		/**
		 *  @private
		 */
		public function addReference () : void;
		/**
		 *  @private
		 */
		public function removeReference () : void;
		/**
		 *  @private
		 */
		public function initHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function progressHandler (event:ProgressEvent) : void;
		/**
		 *  @private
		 */
		public function completeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function errorHandler (event:ErrorEvent) : void;
		/**
		 *  @private
		 */
		public function readyHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function moduleErrorHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class FactoryInfo
	{
		/**
		 *  @private
		 */
		public var factory : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public var applicationDomain : ApplicationDomain;
		/**
		 *  @private
		 */
		public var bytesTotal : int;

		/**
		 *  Constructor.
		 */
		public function FactoryInfo ();
	}
	/**
	 *  @private
	 */
	internal class ModuleInfoProxy extends EventDispatcher implements IModuleInfo
	{
		/**
		 *  @private
		 */
		private var info : ModuleInfo;
		/**
		 *  @private
		 */
		private var referenced : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;

		/**
		 *  @private
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  @private
		 */
		public function get error () : Boolean;
		/**
		 *  @private
		 */
		public function get factory () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function get loaded () : Boolean;
		/**
		 *  @private
		 */
		public function get ready () : Boolean;
		/**
		 *  @private
		 */
		public function get setup () : Boolean;
		/**
		 *  @private
		 */
		public function get url () : String;

		/**
		 *  Constructor.
		 */
		public function ModuleInfoProxy (info:ModuleInfo);
		/**
		 *  @private
		 */
		public function publish (factory:IFlexModuleFactory) : void;
		/**
		 *  @private
		 */
		public function load (applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null, bytes:ByteArray = null) : void;
		/**
		 *  @private
		 */
		public function release () : void;
		/**
		 *  @private
		 */
		public function unload () : void;
		/**
		 *  @private
		 */
		private function moduleEventHandler (event:ModuleEvent) : void;
	}
}