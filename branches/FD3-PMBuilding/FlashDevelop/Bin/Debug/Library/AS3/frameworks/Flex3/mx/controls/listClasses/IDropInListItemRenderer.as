﻿package mx.controls.listClasses
{
	/**
	 *  The interface for "drop-in" item renderers.  Most IListItemRenderers
	 */
	public interface IDropInListItemRenderer
	{
		/**
		 *  Implements the <code>listData</code> property
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

	}
}