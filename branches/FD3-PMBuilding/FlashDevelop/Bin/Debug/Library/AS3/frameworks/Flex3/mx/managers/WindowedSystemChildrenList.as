﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import mx.core.IChildList;
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class WindowedSystemChildrenList implements IChildList
	{
		/**
		 *  @private
		 */
		private var owner : WindowedSystemManager;
		/**
		 *  @private
		 */
		private var lowerBoundReference : QName;
		/**
		 *  @private
		 */
		private var upperBoundReference : QName;

		/**
		 *  @copy mx.core.IChildList#numChildren
		 */
		public function get numChildren () : int;

		/**
		 *  Constructor.
		 */
		public function WindowedSystemChildrenList (owner:WindowedSystemManager, lowerBoundReference:QName, upperBoundReference:QName);
		/**
		 *  @copy mx.core.IChildList#addChild
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#addChildAt
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#removeChild
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#removeChildAt
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#getChildAt
		 */
		public function getChildAt (index:int) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#getChildByName
		 */
		public function getChildByName (name:String) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#getChildIndex
		 */
		public function getChildIndex (child:DisplayObject) : int;
		/**
		 *  @copy mx.core.IChildList#setChildIndex
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @copy mx.core.IChildList#getObjectsUnderPoint
		 */
		public function getObjectsUnderPoint (point:Point) : Array;
		/**
		 *  @copy mx.core.IChildList#contains
		 */
		public function contains (child:DisplayObject) : Boolean;
	}
}