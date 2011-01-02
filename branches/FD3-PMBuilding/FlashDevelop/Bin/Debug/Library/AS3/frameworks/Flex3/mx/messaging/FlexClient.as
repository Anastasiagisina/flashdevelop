﻿package mx.messaging
{
	import flash.events.EventDispatcher;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;

	/**
	 *  Dispatched when a property of the FlexClient singleton changes.
	 */
	[Event(name="propertyChange", type="mx.events.PropertyChangeEvent")] 

	/**
	 *  Singleton class that stores the global Id for this Player instance that is 
	 */
	public class FlexClient extends EventDispatcher
	{
		/**
		 *  @private
		 */
		static const NULL_FLEXCLIENT_ID : String = "nil";
		/**
		 *  @private
		 */
		private static var _instance : FlexClient;
		/**
		 *  @private
		 */
		private var _id : String;
		/**
		 *  @private
		 */
		private var _waitForFlexClientId : Boolean;

		/**
		 *  The global FlexClient Id for this Player instance.
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  @private 
		 */
		function get waitForFlexClientId () : Boolean;
		/**
		 *  @private
		 */
		function set waitForFlexClientId (value:Boolean) : void;

		/**
		 *  Returns the sole instance of this singleton class,
		 */
		public static function getInstance () : FlexClient;
		/**
		 *  @private
		 */
		public function FlexClient ();
	}
}