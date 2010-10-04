﻿package mx.collections
{
	import flash.events.IEventDispatcher;

	/**
	 *  Dispatched whenever the cursor position is updated.
	 */
	[Event(name="cursorUpdate", type="mx.events.FlexEvent")] 

	/**
	 *  Defines the interface for enumerating a collection view bi-directionally.
	 */
	public interface IViewCursor extends IEventDispatcher
	{
		/**
		 *  If the cursor is located after the last item in the view, 
		 */
		public function get afterLast () : Boolean;
		/**
		 *  If the cursor is located before the first item in the view,
		 */
		public function get beforeFirst () : Boolean;
		/**
		 *  Provides access to a bookmark that corresponds to the item
		 */
		public function get bookmark () : CursorBookmark;
		/**
		 *  Provides access the object at the location
		 */
		public function get current () : Object;
		/**
		 *  A reference to the ICollectionView with which this cursor is associated.
		 */
		public function get view () : ICollectionView;

		/**
		 *  Finds an item with the specified properties within the collection
		 */
		public function findAny (values:Object) : Boolean;
		/**
		 *  Finds the first item with the specified properties within the collection
		 */
		public function findFirst (values:Object) : Boolean;
		/**
		 *  Finds the last item with the specified properties within the collection
		 */
		public function findLast (values:Object) : Boolean;
		/**
		 *  Inserts the specified item before the cursor's current position.
		 */
		public function insert (item:Object) : void;
		/**
		 *  Moves the cursor to the next item within the collection.
		 */
		public function moveNext () : Boolean;
		/**
		 *  Moves the cursor to the previous item within the collection.
		 */
		public function movePrevious () : Boolean;
		/**
		 *  Removes the current item and returns it.
		 */
		public function remove () : Object;
		/**
		 *  Moves the cursor to a location at an offset from the specified
		 */
		public function seek (bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void;
	}
}