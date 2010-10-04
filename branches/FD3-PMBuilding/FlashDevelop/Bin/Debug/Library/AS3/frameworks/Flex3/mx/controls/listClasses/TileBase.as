﻿package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import mx.collections.CursorBookmark;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.skins.halo.ListDropIndicator;
	import mx.styles.StyleManager;
	import mx.collections.ItemWrapper;
	import mx.collections.ModifiedCollectionView;

	/**
	 *  The TileBase class is the base class for controls
	 */
	public class TileBase extends ListBase
	{
		private var bShiftKey : Boolean;
		private var bCtrlKey : Boolean;
		private var lastKey : uint;
		private var bSelectItem : Boolean;
		private var lastColumnCount : int;
		private var lastRowCount : int;
		/**
		 *  Cache of measuring objects by factory.
		 */
		protected var measuringObjects : Dictionary;
		/**
		 *  @private
		 */
		private var _direction : String;
		/**
		 *  @private
		 */
		private var _maxColumns : int;
		/**
		 *  @private
		 */
		private var _maxRows : int;

		/**
		 *  The direction in which this control lays out its children.
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  The maximum number of columns that the control can have.
		 */
		public function get maxColumns () : int;
		/**
		 *  @private
		 */
		public function set maxColumns (value:int) : void;
		/**
		 *  The maximum number of rows that the control can have.
		 */
		public function get maxRows () : int;
		/**
		 *  @private
		 */
		public function set maxRows (value:int) : void;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;
		/**
		 *  @private
		 */
		protected function get dragImageOffsets () : Point;

		/**
		 *  Constructor.
		 */
		public function TileBase ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		private function moveNextSafely (more:Boolean) : Boolean;
		/**
		 *  @private
		 */
		private function getPreparedItemRenderer (rowNum:int, colNum:int, wrappedData:Object, data:Object, uid:String) : IListItemRenderer;
		/**
		 *  @private
		 */
		private function placeAndDrawItemRenderer (item:IListItemRenderer, xx:Number, yy:Number, uid:String) : void;
		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;
		/**
		 *  @private
		 */
		protected function scrollVertically (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		protected function scrollHorizontally (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  @private
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 *  @private
		 */
		protected function moveSelectionHorizontally (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		private function displayingPartialRow () : Boolean;
		private function displayingPartialColumn () : Boolean;
		/**
		 *  @private
		 */
		protected function finishKeySelection () : void;
		/**
		 *  @private
		 */
		public function itemRendererToIndex (item:IListItemRenderer) : int;
		/**
		 *  @private
		 */
		public function indexToItemRenderer (index:int) : IListItemRenderer;
		/**
		 *  @private
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;
		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  @private
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		function getMeasuringRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		function purgeMeasuringRenderers () : void;
		/**
		 *  Get the appropriate renderer, using the default renderer if none is specified.
		 */
		public function createItemRenderer (data:Object) : IListItemRenderer;
		/**
		 *  @private
		 */
		function setupRendererFromData (item:IListItemRenderer, data:Object) : void;
		/**
		 *  @private
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		protected function scrollPositionToIndex (horizontalScrollPosition:int, verticalScrollPosition:int) : int;
		/**
		 *  @private
		 */
		function addClipMask (layoutChanged:Boolean) : void;
		/**
		 *  @private
		 */
		function removeClipMask () : void;
		/**
		 *  @private
		 */
		function adjustOffscreenRowsAndColumns () : void;
		/**
		 *  Creates a new ListData instance and populates the fields based on
		 */
		protected function makeListData (data:Object, uid:String, rowNum:int, columnNum:int) : BaseListData;
		/**
		 *  @private
		 */
		private function lastRowInColumn (index:int) : int;
		/**
		 *  @private
		 */
		private function lastColumnInRow (index:int) : int;
		/**
		 *  @private
		 */
		protected function indexToRow (index:int) : int;
		/**
		 *  @private
		 */
		protected function indexToColumn (index:int) : int;
		/**
		 *  @private
		 */
		public function indicesToIndex (rowIndex:int, columnIndex:int) : int;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function reconstructDataFromListItems () : Array;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Draws the backgrounds, if any, behind all of the tiles.
		 */
		protected function drawTileBackgrounds () : void;
		/**
		 *  Draws the background for an individual tile. 
		 */
		protected function drawTileBackground (s:Sprite, rowIndex:int, columnIndex:int, width:Number, height:Number, color:uint, item:IListItemRenderer) : DisplayObject;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function scrollToIndex (index:int) : Boolean;
		/**
		 *  Called from the <code>updateDisplayList()</code> method to adjust the size and position of
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;
	}
}