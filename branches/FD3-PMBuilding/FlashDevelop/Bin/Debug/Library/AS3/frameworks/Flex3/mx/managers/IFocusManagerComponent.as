﻿package mx.managers
{
	/**
	 *  The IFocusManagerComponent interface defines the interface 
	 */
	public interface IFocusManagerComponent
	{
		/**
		 *  A flag that indicates whether the component can receive focus when selected.
		 */
		public function get focusEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set focusEnabled (value:Boolean) : void;
		/**
		 *  A flag that indicates whether the component can receive focus 
		 */
		public function get mouseFocusEnabled () : Boolean;
		/**
		 *  A flag that indicates whether pressing the Tab key eventually 
		 */
		public function get tabEnabled () : Boolean;
		/**
		 *  If <code>tabEnabled</code>, the order in which the component receives focus.
		 */
		public function get tabIndex () : int;

		/**
		 *  Called by the FocusManager when the component receives focus.
		 */
		public function setFocus () : void;
		/**
		 *  Called by the FocusManager when the component receives focus.
		 */
		public function drawFocus (isFocused:Boolean) : void;
	}
}