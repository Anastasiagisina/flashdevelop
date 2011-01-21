﻿package mx.managers
{
	import flash.events.IEventDispatcher;
	import mx.core.mx_internal;

	/**
	 *  The ILayoutManagerClient interface defines the interface 
	 */
	public interface ILayoutManagerClient extends IEventDispatcher
	{
		/**
		 *  A flag that determines if an object has been through all three phases
		 */
		public function get initialized () : Boolean;
		/**
		 *  @private
		 */
		public function set initialized (value:Boolean) : void;
		/**
		 *  The top-level SystemManager has a nestLevel of 1.
		 */
		public function get nestLevel () : int;
		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;
		/**
		 *  @copy mx.core.UIComponent#processedDescriptors
		 */
		public function get processedDescriptors () : Boolean;
		/**
		 *  @private
		 */
		public function set processedDescriptors (value:Boolean) : void;
		/**
		 *  A flag that determines if an object is waiting to have its
		 */
		public function get updateCompletePendingFlag () : Boolean;
		/**
		 *  @private
		 */
		public function set updateCompletePendingFlag (value:Boolean) : void;

		/**
		 *  Validates the properties of a component.
		 */
		public function validateProperties () : void;
		/**
		 *  Validates the measured size of the component
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  Validates the position and size of children and draws other
		 */
		public function validateDisplayList () : void;
	}
}