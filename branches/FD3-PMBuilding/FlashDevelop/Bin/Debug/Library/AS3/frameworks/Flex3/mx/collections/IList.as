﻿package mx.collections
{
	import flash.events.IEventDispatcher;
	import mx.events.CollectionEvent;

	/**
	 *  Dispatched when the IList has been updated in some way.
	 */
	[Event(name="collectionChange", type="mx.events.CollectionEvent")] 

	/**
	 *  A collection of items organized in an ordinal fashion.  
	 */
	public interface IList extends IEventDispatcher
	{
		/**
		 *  The number of items in this collection. 
		 */
		public function get length () : int;

		/**
		 *  Adds the specified item to the end of the list.
		 */
		public function addItem (item:Object) : void;
		/**
		 *  Adds the item at the specified index.  
		 */
		public function addItemAt (item:Object, index:int) : void;
		/**
		 *  Gets the item at the specified index.
		 */
		public function getItemAt (index:int, prefetch:int = 0) : Object;
		/**
		 *  Returns the index of the item if it is in the list such that
		 */
		public function getItemIndex (item:Object) : int;
		/**
		 *  Notifies the view that an item has been updated.  
		 */
		public function itemUpdated (item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void;
		/**
		 *  Removes all items from the list.
		 */
		public function removeAll () : void;
		/**
		 *  Removes the item at the specified index and returns it.  
		 */
		public function removeItemAt (index:int) : Object;
		/**
		 *  Places the item at the specified index.  
		 */
		public function setItemAt (item:Object, index:int) : Object;
		/**
		 *  Returns an Array that is populated in the same order as the IList
		 */
		public function toArray () : Array;
	}
}