﻿package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import mx.collections.IViewCursor;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  Background color of the component.
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")] 

	/**
	 *  The ListBaseContentHolder class defines a container in a list-based control
	 */
	public class ListBaseContentHolder extends UIComponent
	{
		/**
		 *  The layer in the content defined by the <code>:istbase.listContent</code> property 
		 */
		public var selectionLayer : Sprite;
		/**
		 *  A hash table of data provider item renderers currently in view.
		 */
		public var visibleData : Object;
		/**
		 *  An Array of Arrays that contains
		 */
		public var listItems : Array;
		/**
		 *  An Array of ListRowInfo objects that cache row heights and 
		 */
		public var rowInfo : Array;
		/**
		 *  The IViewCursor instance used to fetch items from the
		 */
		public var iterator : IViewCursor;
		/**
		 *  @private
		 */
		private var parentList : ListBase;
		/**
		 *  @private
		 */
		private var maskShape : Shape;
		/**
		 *  @private
		 */
		local var allowItemSizeChangeNotification : Boolean;
		/**
		 *  Offset, in pixels, for the upper-left corner in the list control of the content defined 
		 */
		public var leftOffset : Number;
		/**
		 *  Offset, in pixels, for the upper-left corner in the list control of the content defined 
		 */
		public var topOffset : Number;
		/**
		 *  Offset, in pixels, for the lower-right corner in the list control of the content defined 
		 */
		public var rightOffset : Number;
		/**
		 *  Offset, in pixels, for the lower-right corner in the list control of the content defined 
		 */
		public var bottomOffset : Number;

		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  Height, in pixels excluding the top and
		 */
		public function get heightExcludingOffsets () : Number;
		/**
		 *  Width, in pixels excluding the top and
		 */
		public function get widthExcludingOffsets () : Number;

		/**
		 *  Constructor.
		 */
		public function ListBaseContentHolder (parentList:ListBase);
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  Sets the position and size of the scroll bars and content
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function getParentList () : ListBase;
	}
}