﻿package mx.events
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import mx.modules.IModuleInfo;

	/**
	 *  The ModuleEvent class represents the event object passed to the event listener
	 */
	public class ModuleEvent extends ProgressEvent
	{
		/**
		 *  Dispatched when there is an error downloading the module.
		 */
		public static const ERROR : String = "error";
		/**
		 *  Dispatched when the module is in the process of downloading. This module is
		 */
		public static const PROGRESS : String = "progress";
		/**
		 *  Dispatched when the module has finished downloading.     
		 */
		public static const READY : String = "ready";
		/**
		 *  Dispatched when enough of a module has been downloaded that you can get information
		 */
		public static const SETUP : String = "setup";
		/**
		 *  Dispatched when the module is unloaded.
		 */
		public static const UNLOAD : String = "unload";
		/**
		 *  The error message if the type is <code>ModuleEvent.ERROR</code>;
		 */
		public var errorText : String;
		private var _module : IModuleInfo;

		/**
		 *  The <code>target</code>, which is an instance of an
		 */
		public function get module () : IModuleInfo;

		/**
		 *  Constructor.
		 */
		public function ModuleEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0, errorText:String = null, module:IModuleInfo = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}