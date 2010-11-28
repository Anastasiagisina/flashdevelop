﻿package mx.managers
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import mx.events.BrowserChangeEvent;
	import mx.core.ApplicationGlobals;
	import mx.managers.SystemManagerGlobals;

	/**
	 *  Dispatched when the fragment property is changed either
	 */
	[Event(name="urlChange", type="flash.events.Event")] 
	/**
	 *  Dispatched when the fragment property is changed
	 */
	[Event(name="browserURLChange", type="mx.events.BrowserChangeEvent")] 
	/**
	 *  Dispatched when the fragment property is changed
	 */
	[Event(name="applicationURLChange", type="mx.events.BrowserChangeEvent")] 

	/**
	 *  @private
	 */
	public class BrowserManagerImpl extends EventDispatcher implements IBrowserManager
	{
		/**
		 *  @private
		 */
		private static var instance : IBrowserManager;
		private var _defaultFragment : String;
		private var browserMode : Boolean;
		private var _base : String;
		private var _fragment : String;
		private var _title : String;
		private var _url : String;

		/**
		 *  The portion of current URL before the '#' as it appears 
		 */
		public function get base () : String;
		/**
		 *  The portion of current URL after the '#' as it appears 
		 */
		public function get fragment () : String;
		/**
		 *  The title of the app as it should appear in the
		 */
		public function get title () : String;
		/**
		 *  The current URL as it appears in the browser address bar.
		 */
		public function get url () : String;

		/**
		 *  @private
		 */
		public static function getInstance () : IBrowserManager;
		/**
		 *  Constructor.
		 */
		public function BrowserManagerImpl ();
		/**
		 *  Initialize the BrowserManager.  The BrowserManager will get the initial URL.  If it
		 */
		public function init (defaultFragment:String = "", defaultTitle:String = "") : void;
		/**
		 *  Initialize the BrowserManager.  The HistoryManager calls this method to
		 */
		public function initForHistoryManager () : void;
		private function setup (defaultFragment:String, defaultTitle:String) : void;
		/**
		 *  Change the fragment of the url after the '#' in the browser.
		 */
		public function setFragment (value:String) : void;
		/**
		 *  Change the title in the browser.
		 */
		public function setTitle (value:String) : void;
		/**
		 *  @private
		 */
		private function browserURLChangeBrowser (fragment:String) : void;
		private function browserURLChange (fragment:String, force:Boolean = false) : void;
		private function sandboxBrowserManagerHandler (event:Event) : void;
		private function debugTrace (s:String) : void;
	}
}