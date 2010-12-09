﻿package mx.events
{
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;

	/**
	 *   The DataGridEvent class represents event objects that are specific to
	 */
	public class DataGridEvent extends Event
	{
		/**
		 *  The DataGridEvent.ITEM_EDIT_BEGIN constant defines the value of the 
		 */
		public static const ITEM_EDIT_BEGIN : String = "itemEditBegin";
		/**
		 *  The DataGridEvent.ITEM_EDIT_END constant defines the value of the 
		 */
		public static const ITEM_EDIT_END : String = "itemEditEnd" public s;
		/**
		 *  The DataGridEvent.ITEM_FOCUS_IN constant defines the value of the 
		 */
		public const ITEM_FOCUS_IN : String = "itemFocusIn";
		/**
		 *  The DataGridEvent.ITEM_FOCUS_OUT constant defines the value of the 
		 */
		public static const ITEM_FOCUS_OUT : String = "itemFocusOut";
		/**
		 *  The DataGridEvent.ITEM__EDIT_BEGINNING constant defines the value of the 
		 */
		public static const ITEM_EDIT_BEGINNING : String = "itemEditBeginning";
		/**
		 *  The DataGridEvent.COLUMN_STRETCH constant defines the value of the 
		 */
		public static const COLUMN_STRETCH : String = "columnStretch";
		/**
		 *  The DataGridEvent.HEADER_RELEASE constant defines the value of the 
		 */
		public static const HEADER_RELEASE : String = "headerRelease";
		/**
		 *  The zero-based index in the DataGrid object's <code>columns</code> array
		 */
		public var columnIndex : int;
		/**
		 *  The name of the field or property in the data associated with the column.
		 */
		public var dataField : String;
		/**
		 *  The item renderer for the item that is being edited or the header
		 */
		public var itemRenderer : IListItemRenderer;
		/**
		 *  The column's x-position; used for replaying column stretch events.
		 */
		public var localX : Number;
		/**
		 *  The reason the <code>itemEditEnd</code> event was dispatched. 
		 */
		public var reason : String;
		/**
		 *  The zero-based index of the item in the data provider.
		 */
		public var rowIndex : int;

		/**
		 *  Constructor.
		 */
		public function DataGridEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, columnIndex:int = -1, dataField:String = null, rowIndex:int = -1, reason:String = null, itemRenderer:IListItemRenderer = null, localX:Number = NaN);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}