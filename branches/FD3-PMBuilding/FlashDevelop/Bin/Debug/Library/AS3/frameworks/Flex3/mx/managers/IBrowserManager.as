﻿package mx.managers
{
	import flash.events.IEventDispatcher;

	/**
	 *  Dispatched when the URL is changed either
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 *  Dispatched when the URL is changed
	 */
	[Event(name="browserURLChange", type="mx.events.BrowserChangeEvent")] 
	/**
	 *  Dispatched when the URL is changed
	 */
	[Event(name="urlChange", type="mx.events.BrowserChangeEvent")] 

	/**
	 *  The interface that the shared instance of the BrowserManager
	 */
	public interface IBrowserManager extends IEventDispatcher
	{
		/**
		 *  The portion of current URL before the '#' as it appears 
		 */
		public function get base () : String;
		/**
		 *  The portion of current URL after the '#' as it appears 
		 */
		public function get fragment () : String;
		/**
		 *  The title of the application as it should appear in the
		 */
		public function get title () : String;
		/**
		 *  The current URL as it appears in the browser address bar.
		 */
		public function get url () : String;

		/**
		 *  Changes the fragment of the URL after the '#' in the browser.
		 */
		public function setFragment (value:String) : void;
		/**
		 *  Changes the text in the browser's title bar.
		 */
		public function setTitle (value:String) : void;
		/**
		 *  Initializes the BrowserManager. The BrowserManager will get the initial URL. If it
		 */
		public function init (value:String = null, title:String = null) : void;
		/**
		 *  Initializes the BrowserManager. The HistoryManager calls this method to
		 */
		public function initForHistoryManager () : void;
	}
}