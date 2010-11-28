﻿package mx.controls.listClasses
{
	import mx.core.IUIComponent;
	import mx.core.IUID;

	/**
	 *  The BaseListData class defines the data type of the <code>listData</code>
	 */
	public class BaseListData
	{
		/**
		 *  The index of the column of the List-based control relative 
		 */
		public var columnIndex : int;
		/**
		 *  The textual representation of the item data, based on the list class's
		 */
		public var label : String;
		/**
		 *  A reference to the list object that owns this item.
		 */
		public var owner : IUIComponent;
		/**
		 *  The index of the row of the DataGrid, List, or Tree control relative 
		 */
		public var rowIndex : int;
		/**
		 *  @private
		 */
		private var _uid : String;

		/**
		 *  The unique identifier for this item.
		 */
		public function get uid () : String;
		/**
		 *  @private
		 */
		public function set uid (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function BaseListData (label:String, uid:String, owner:IUIComponent, rowIndex:int = 0, columnIndex:int = 0);
	}
}