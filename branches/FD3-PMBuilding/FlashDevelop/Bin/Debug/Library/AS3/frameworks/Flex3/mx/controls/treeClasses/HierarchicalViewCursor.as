﻿package mx.controls.treeClasses
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.utils.UIDUtil;

	/**
	 *  @private
	 */
	public class HierarchicalViewCursor extends EventDispatcher implements IViewCursor
	{
		/**
		 *  @private
		 */
		private var dataDescriptor : ITreeDataDescriptor;
		/**
		 *  @private
		 */
		private var currentIndex : int;
		/**
		 *  @private
		 */
		private var currentChildIndex : int;
		/**
		 *  @private
		 */
		private var _currentDepth : int;
		/**
		 *  @private
		 */
		private var childNodes : Object;
		/**
		 *  @private
		 */
		private var parentNodes : Array;
		/**
		 *  @private
		 */
		private var childIndexStack : Array;
		/**
		 *  @private
		 */
		private var model : ICollectionView;
		/**
		 *  @private
		 */
		private var collection : HierarchicalCollectionView;
		/**
		 *  @private
		 */
		private var openNodes : Object;
		/**
		 *  @private
		 */
		private var more : Boolean;
		/**
		 *  @private
		 */
		private var modelCursor : IViewCursor;
		/**
		 *  @private
		 */
		private var itemToUID : Function;

		/**
		 * @private
		 */
		public function get index () : int;
		/**
		 *  @private
		 */
		public function get bookmark () : CursorBookmark;
		/**
		 *  @private
		 */
		public function get current () : Object;
		/**
		 *  @private
		 */
		public function get currentDepth () : int;
		public function get beforeFirst () : Boolean;
		public function get afterLast () : Boolean;
		public function get view () : ICollectionView;

		/**
		 *  Constructor.
		 */
		public function HierarchicalViewCursor (collection:HierarchicalCollectionView, model:ICollectionView, dataDescriptor:ITreeDataDescriptor, itemToUID:Function, openNodes:Object);
		/**
		 *  @private
		 */
		private function isItemVisible (node:Object) : Boolean;
		/**
		 *  @private
		 */
		private function getParentStack (node:Object) : Array;
		/**
		 *  @private
		 */
		private function isNodeBefore (node:Object, currentNode:Object) : Boolean;
		/**
		 *  @private
		 */
		public function findAny (values:Object) : Boolean;
		/**
		 *  @private
		 */
		public function findFirst (values:Object) : Boolean;
		/**
		 *  @private
		 */
		public function findLast (values:Object) : Boolean;
		/**
		 *  @private
		 */
		public function moveNext () : Boolean;
		/**
		 *  @private
		 */
		public function movePrevious () : Boolean;
		/**
		 *  @private
		 */
		public function seek (bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void;
		/**
		 *  @private
		 */
		private function moveToFirst () : void;
		/**
		 *  @private
		 */
		public function moveToLast () : void;
		/**
		 *  @private
		 */
		public function insert (item:Object) : void;
		/**
		 *  @private
		 */
		public function remove () : Object;
		/**
		 *  @private
		 */
		public function collectionChangeHandler (event:CollectionEvent) : void;
	}
}