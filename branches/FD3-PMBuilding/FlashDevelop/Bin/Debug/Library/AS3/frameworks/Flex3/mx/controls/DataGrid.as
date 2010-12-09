﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.ItemResponder;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.dataGridClasses.DataGridBase;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.dataGridClasses.DataGridDragProxy;
	import mx.controls.dataGridClasses.DataGridHeader;
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.controls.listClasses.ListBaseSeekPending;
	import mx.controls.listClasses.ListRowInfo;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.core.ContextualClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IChildList;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IIMESupport;
	import mx.core.IInvalidating;
	import mx.core.IPropertyChangeNotifier;
	import mx.core.IRawChildrenContainer;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.ListEvent;
	import mx.events.DataGridEvent;
	import mx.events.DataGridEventReason;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.skins.halo.ListDropIndicator;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;
	import mx.utils.ObjectUtil;
	import mx.managers.ISystemManager;
	import mx.core.IFlexModuleFactory;
	import mx.utils.StringUtil;

	/**
	 *  Dispatched when the user releases the mouse button while over an item 
	 */
	[Event(name="itemEditBeginning", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when the <code>editedItemPosition</code> property has been set
	 */
	[Event(name="itemEditBegin", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when an item editing session ends for any reason.
	 */
	[Event(name="itemEditEnd", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when an item renderer gets focus, which can occur if the user
	 */
	[Event(name="itemFocusIn", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when an item renderer loses focus, which can occur if the user
	 */
	[Event(name="itemFocusOut", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when a user changes the width of a column, indicating that the 
	 */
	[Event(name="columnStretch", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when the user releases the mouse button on a column header
	 */
	[Event(name="headerRelease", type="mx.events.DataGridEvent")] 
	/**
	 *  Dispatched when the user releases the mouse button on a column header after 
	 */
	[Event(name="headerShift", type="mx.events.IndexChangedEvent")] 
	/**
	 *  A flag that indicates whether to show vertical grid lines between
	 */
	[Style(name="verticalGridLines", type="Boolean", inherit="no")] 
	/**
	 *  A flag that indicates whether to show horizontal grid lines between
	 */
	[Style(name="horizontalGridLines", type="Boolean", inherit="no")] 
	/**
	 *  The color of the vertical grid lines.
	 */
	[Style(name="verticalGridLineColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The color of the horizontal grid lines.
	 */
	[Style(name="horizontalGridLineColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  An array of two colors used to draw the header background gradient.
	 */
	[Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  The color of the row background when the user rolls over the row.
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The color of the background for the row when the user selects 
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The name of a CSS style declaration for controlling other aspects of
	 */
	[Style(name="headerStyleName", type="String", inherit="no")] 
	/**
	 *  The class to use as the skin for a column that is being resized.
	 */
	[Style(name="columnResizeSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that defines the appearance of the  
	 */
	[Style(name="headerBackgroundSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that defines the appearance of the 
	 */
	[Style(name="headerSeparatorSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that defines the appearance of the 
	 */
	[Style(name="horizontalSeparatorSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that defines the appearance of the 
	 */
	[Style(name="horizontalLockedSeparatorSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that defines the appearance of the 
	 */
	[Style(name="verticalSeparatorSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that defines the appearance of the 
	 */
	[Style(name="verticalLockedSeparatorSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin for the arrow that indicates the column sort 
	 */
	[Style(name="sortArrowSkin", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin for the cursor that indicates that a column
	 */
	[Style(name="stretchCursor", type="Class", inherit="no")] 
	/**
	 *  The class to use as the skin that indicates that 
	 */
	[Style(name="columnDropIndicatorSkin", type="Class", inherit="no")] 
	/**
	 *  The name of a CSS style declaration for controlling aspects of the
	 */
	[Style(name="headerDragProxyStyleName", type="String", inherit="no")] 

	/**
	 *  The <code>DataGrid</code> control is like a List except that it can 
	 */
	public class DataGrid extends DataGridBase implements IIMESupport
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  A reference to the currently active instance of the item editor, 
		 */
		public var itemEditorInstance : IListItemRenderer;
		/**
		 *  @private
		 */
		private var skipHeaderUpdate : Boolean;
		/**
		 *  @private
		 */
		private var dontEdit : Boolean;
		/**
		 *  @private
		 */
		private var losingFocus : Boolean;
		/**
		 *  @private
		 */
		private var inEndEdit : Boolean;
		/**
		 *  @private
		 */
		private var collectionUpdatesDisabled : Boolean;
		/**
		 *  @private
		 */
		local var sortIndex : int;
		/**
		 *  @private
		 */
		private var sortColumn : DataGridColumn;
		/**
		 *  @private
		 */
		local var sortDirection : String;
		/**
		 *  @private
		 */
		local var lastSortIndex : int;
		/**
		 *  @private
		 */
		private var lastItemDown : IListItemRenderer;
		/**
		 *  @private
		 */
		private var displayWidth : Number;
		/**
		 *  @private
		 */
		private var lockedColumnWidth : Number;
		/**
		 *  @private
		 */
		local var movingColumn : DataGridColumn;
		/**
		 *  @private
		 */
		local var resizingColumn : DataGridColumn;
		/**
		 *  @private
		 */
		private var displayableColumns : Array;
		/**
		 *  @private
		 */
		private var generatedColumns : Boolean;
		private var actualRowIndex : int;
		private var actualColIndex : int;
		private var actualContentHolder : ListBaseContentHolder;
		/**
		 *  @private
		 */
		private var manualSort : Boolean;
		/**
		 *  @private
		 */
		private var _imeMode : String;
		/**
		 *  @private
		 */
		private var _minColumnWidth : Number;
		/**
		 *  @private
		 */
		private var minColumnWidthInvalid : Boolean;
		/**
		 *  @private
		 */
		private var _columns : Array;
		/**
		 *  @private
		 */
		private var _draggableColumns : Boolean;
		/**
		 *  A flag that indicates whether or not the user can edit
		 */
		public var editable : Boolean;
		/**
		 *  @private
		 */
		private var bEditedItemPositionChanged : Boolean;
		/**
		 *  @private
		 */
		private var _proposedEditedItemPosition : *;
		/**
		 *  @private
		 */
		private var lastEditedItemPosition : *;
		/**
		 *  @private
		 */
		private var _editedItemPosition : Object;
		/**
		 *  @private
		 */
		private var itemEditorPositionChanged : Boolean;
		/**
		 *  A flag that indicates whether the user can change the size of the
		 */
		public var resizableColumns : Boolean;
		/**
		 *  A flag that indicates whether the user can sort the data provider items
		 */
		public var sortableColumns : Boolean;
		private var _headerWordWrapPresent : Boolean;
		private var _originalExplicitHeaderHeight : Boolean;
		private var _originalHeaderHeight : Number;
		private var _focusPane : Sprite;
		local var lockedColumnDropIndicator : IFlexDisplayObject;

		/**
		 *  A reference to the item renderer
		 */
		public function get editedItemRenderer () : IListItemRenderer;
		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function get columnCount () : int;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set headerHeight (value:Number) : void;
		/**
		 *  The offset into the content from the left edge. 
		 */
		public function set horizontalScrollPosition (value:Number) : void;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 *  Specifies the IME (input method editor) mode.
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;
		/**
		 *  @private
		 */
		public function get itemRenderer () : IFactory;
		/**
		 *  The minimum width of the columns, in pixels.  If not NaN,
		 */
		public function get minColumnWidth () : Number;
		/**
		 *  @private
		 */
		public function set minColumnWidth (value:Number) : void;
		/**
		 *  An array of DataGridColumn objects, one for each column that
		 */
		public function get columns () : Array;
		/**
		 *  @private
		 */
		public function set columns (value:Array) : void;
		/**
		 *  A flag that indicates whether the user is allowed to reorder columns.
		 */
		public function get draggableColumns () : Boolean;
		/**
		 *  @private
		 */
		public function set draggableColumns (value:Boolean) : void;
		/**
		 *  The column and row index of the item renderer for the
		 */
		public function get editedItemPosition () : Object;
		/**
		 *  @private
		 */
		public function set editedItemPosition (value:Object) : void;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @private
		 */
		protected function get dragImage () : IUIComponent;
		function get vScrollBar () : ScrollBar;
		/**
		 *  diagnostics
		 */
		function get rendererArray () : Array;
		/**
		 *  diagnostics
		 */
		function get sortArrow () : IFlexDisplayObject;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;

		/**
		 *  Constructor.
		 */
		public function DataGrid ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		public function invalidateDisplayList () : void;
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		function setupRendererFromData (c:DataGridColumn, item:IListItemRenderer, data:Object) : void;
		/**
		 *  @private
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  @private
		 */
		function measureHeightOfItemsUptoMaxHeight (index:int = -1, count:int = 0, maxHeight:Number = -1) : Number;
		/**
		 *  @private
		 */
		function calculateHeaderHeight () : Number;
		/**
		 *  @private
		 */
		protected function calculateRowHeight (data:Object, hh:Number, skipVisible:Boolean = false) : Number;
		/**
		 *  @private
		 */
		protected function scrollHandler (event:Event) : void;
		private function displayingPartialRow () : Boolean;
		/**
		 *  @private
		 */
		protected function configureScrollBars () : void;
		/**
		 *  @private
		 */
		private function adjustVerticalScrollPositionDownward (rowCount:int) : Boolean;
		/**
		 *  @private
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;
		/**
		 *  @private
		 */
		protected function drawRowBackgrounds () : void;
		/**
		 *  @private
		 */
		protected function drawRowGraphics (contentHolder:ListBaseContentHolder) : void;
		/**
		 *  @private
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;
		/**
		 *  @private
		 */
		function shiftColumns (oldIndex:int, newIndex:int, trigger:Event = null) : void;
		/**
		 *  @private
		 */
		private function generateCols () : void;
		/**
		 *  @private
		 */
		private function generateColumnsPendingResultHandler (data:Object, info:ListBaseSeekPending) : void;
		/**
		 *  @private
		 */
		private function calculateColumnSizes () : void;
		/**
		 *  @private
		 */
		function resizeColumn (col:int, w:Number) : void;
		/**
		 *  Draws a row background 
		 */
		protected function drawRowBackground (s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int) : void;
		/**
		 *  Draws a column background for a column with the suggested color.
		 */
		protected function drawColumnBackground (s:Sprite, columnIndex:int, color:uint, column:DataGridColumn) : void;
		/**
		 *  Creates and sizes the horizontalSeparator skins. If none have been specified, then draws the lines using
		 */
		private function drawHorizontalSeparator (s:Sprite, rowIndex:int, color:uint, y:Number, useLockedSeparator:Boolean = false) : void;
		/**
		 *  Draws a line between rows.  This implementation draws a line
		 */
		protected function drawHorizontalLine (s:Sprite, rowIndex:int, color:uint, y:Number) : void;
		/**
		 *  Creates and sizes the verticalSeparator skins. If none have been specified, then draws the lines using
		 */
		private function drawVerticalSeparator (s:Sprite, colIndex:int, color:uint, x:Number, useLockedSeparator:Boolean = false) : void;
		/**
		 *  Draw lines between columns.  This implementation draws a line
		 */
		protected function drawVerticalLine (s:Sprite, colIndex:int, color:uint, x:Number) : void;
		/**
		 *  Draw lines between columns, and column backgrounds.
		 */
		protected function drawLinesAndColumnBackgrounds () : void;
		/**
		 *  Draw lines between columns, and column backgrounds.
		 */
		protected function drawLinesAndColumnGraphics (contentHolder:ListBaseContentHolder, visibleColumns:Array, separators:Object) : void;
		function _drawHeaderBackground (headerBG:UIComponent) : void;
		/**
		 *  Draws the background of the headers into the given 
		 */
		protected function drawHeaderBackground (headerBG:UIComponent) : void;
		function _clearSeparators () : void;
		/**
		 *  Removes column header separators that the user normally uses
		 */
		protected function clearSeparators () : void;
		function _drawSeparators () : void;
		/**
		 *  Creates and displays the column header separators that the user 
		 */
		protected function drawSeparators () : void;
		/**
		 *  @private
		 */
		private function updateSortIndexAndDirection () : void;
		function _placeSortArrow () : void;
		/**
		 *  Draws the sort arrow graphic on the column that is the current sort key.
		 */
		protected function placeSortArrow () : void;
		/**
		 *  @private
		 */
		private function sortByColumn (index:int) : void;
		/**
		 *  @private
		 */
		private function setEditedItemPosition (coord:Object) : void;
		/**
		 *  @private
		 */
		private function commitEditedItemPosition (coord:Object) : void;
		private function scrollToEditedItem (rowIndex:int, colIndex:int) : void;
		/**
		 *  Creates the item editor for the item renderer at the
		 */
		public function createItemEditor (colIndex:int, rowIndex:int) : void;
		/**
		 *  @private
		 */
		private function findNextItemRenderer (shiftKey:Boolean) : Boolean;
		/**
		 *  This method closes an item editor currently open on an item renderer. 
		 */
		public function destroyItemEditor () : void;
		/**
		 *  @private
		 */
		private function endEdit (reason:String) : Boolean;
		/**
		 *  Determines whether to allow editing of a dataprovider item on a per-row basis. 
		 */
		public function isItemEditable (data:Object) : Boolean;
		/**
		 *  @private
		 */
		function columnRendererChanged (c:DataGridColumn) : void;
		/**
		 *  @private
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function deactivateHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		public function itemToLabel (data:Object) : String;
		/**
		 *  @private
		 */
		private function editorMouseDownHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function editorKeyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function editorStageResizeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function findNextEnterItemRenderer (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function mouseFocusChangeHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorFocusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditBeginningHandler (event:DataGridEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditBeginHandler (event:DataGridEvent) : void;
		/**
		 *  @private
		 */
		private function itemEditorItemEditEndHandler (event:DataGridEvent) : void;
		/**
		 *  @private
		 */
		private function headerReleaseHandler (event:DataGridEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function dragStartHandler (event:DragEvent) : void;
		/**
		 *  Called from the <code>updateDisplayList()</code> method to adjust the size and position of
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;
		private function lockedRowSeekPendingResultHandler (data:Object, info:ListBaseSeekPending) : void;
		/**
		 *  @inheritDoc
		 */
		protected function scrollPositionToIndex (horizontalScrollPosition:int, verticalScrollPosition:int) : int;
		/**
		 *  @inheritDoc
		 */
		protected function scrollVertically (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  @private
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  @private
		 */
		public function hideDropFeedback (event:DragEvent) : void;
	}
}