﻿package mx.core
{
	/**
	 *  The IRepeaterClient interface defines the APIs for components
	 */
	public interface IRepeaterClient
	{
		/**
		 *  An Array that contains the indices required
		 */
		public function get instanceIndices () : Array;
		/**
		 *  @private
		 */
		public function set instanceIndices (value:Array) : void;
		/**
		 *  @copy mx.core.UIComponent#isDocument
		 */
		public function get isDocument () : Boolean;
		/**
		 *  An Array that contains the indices of the items in the data
		 */
		public function get repeaterIndices () : Array;
		/**
		 *  @private
		 */
		public function set repeaterIndices (value:Array) : void;
		/**
		 *  An Array that contains any enclosing Repeaters of the component.
		 */
		public function get repeaters () : Array;
		/**
		 *  @private
		 */
		public function set repeaters (value:Array) : void;

		/**
		 *  Initializes the <code>instanceIndices</code>,
		 */
		public function initializeRepeaterArrays (parent:IRepeaterClient) : void;
	}
}