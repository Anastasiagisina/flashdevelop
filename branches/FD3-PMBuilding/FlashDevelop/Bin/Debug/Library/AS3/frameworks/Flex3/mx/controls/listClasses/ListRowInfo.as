﻿package mx.controls.listClasses
{
	/**
	 *  Used by the list-based classes to store information about their IListItemRenderers.
	 */
	public class ListRowInfo
	{
		/**
		 *  The item in the dataprovider.
		 */
		public var data : Object;
		/**
		 *  The height of the row including margins.
		 */
		public var height : Number;
		/**
		 *  The last Y value for the renderer.
		 */
		public var itemOldY : Number;
		/**
		 *  The last Y value for the row.
		 */
		public var oldY : Number;
		/**
		 *  The unique identifier of the item in the dataProvider
		 */
		public var uid : String;
		/**
		 *  The y-position value for the row.
		 */
		public var y : Number;

		/**
		 *  Constructor.
		 */
		public function ListRowInfo (y:Number, height:Number, uid:String, data:Object = null);
	}
}