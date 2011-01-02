﻿package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.ItemResponder;
	import mx.collections.ItemWrapper;
	import mx.collections.ListCollectionView;
	import mx.collections.ModifiedCollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.CursorError;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.core.DragSource;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IRawChildrenContainer;
	import mx.core.IUIComponent;
	import mx.core.IUID;
	import mx.core.IUITextField;
	import mx.core.ScrollControlBase;
	import mx.core.ScrollPolicy;
	import mx.core.SpriteAsset;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.effects.IEffect;
	import mx.effects.IEffectInstance;
	import mx.effects.IEffectTargetHost;
	import mx.effects.Tween;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.events.TweenEvent;
	import mx.managers.DragManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.skins.halo.ListDropIndicator;
	import mx.styles.StyleManager;
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;
	import mx.events.MoveEvent;
	import mx.styles.StyleProxy;

	/**
	 *  Dispatched when the <code>selectedIndex</code> or <code>selectedItem</code> property
	 */
	[Event(name="change", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the user rolls the mouse pointer over an item in the control.
	 */
	[Event(name="itemRollOver", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user rolls the mouse pointer out of an item in the control.
	 */
	[Event(name="itemRollOut", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user clicks on an item in the control.
	 */
	[Event(name="itemClick", type="mx.events.ListEvent")] 
	/**
	 *  Dispatched when the user double-clicks on an item in the control.
	 */
	[Event(name="itemDoubleClick", type="mx.events.ListEvent")] 
	/**
	 *  The colors to use for the backgrounds of the items in the list. 
	 */
	[Style(name="alternatingItemColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 
	/**
	 *  The skin to use to indicate where a dragged item can be dropped.
	 */
	[Style(name="dropIndicatorSkin", type="Class", inherit="no")] 
	/**
	 *  The number of pixels between the bottom of the row
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  The number of pixels between the top of the row
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  The color of the background of a renderer when the user rolls over it.
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The color of the background of a renderer when the user selects it.
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The color of the background of a renderer when the component is disabled.
	 */
	[Style(name="selectionDisabledColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The duration of the selection effect.
	 */
	[Style(name="selectionDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  The easingFunction for the selection effect.
	 */
	[Style(name="selectionEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The color of the text of a renderer when the user rolls over a it.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  The color of the text of a renderer when the user selects it.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  A flag that controls whether items are highlighted as the mouse rolls 
	 */
	[Style(name="useRollOver", type="Boolean", inherit="no")] 
	/**
	 *  The vertical alignment of a renderer in a row.
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 

	/**
	 *  The ListBase class is the base class for controls that represent lists
	 */
	public class ListBase extends ScrollControlBase implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var IS_ITEM_STYLE : Object;
		/**
		 *  @private
		 */
		static const DRAG_THRESHOLD : int = 4;
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  An ICollectionView that represents the data provider.
		 */
		protected var collection : ICollectionView;
		/**
		 *  The main IViewCursor used to fetch items from the
		 */
		protected var iterator : IViewCursor;
		/**
		 *  A flag that indicates that a page fault as occurred and that
		 */
		protected var iteratorValid : Boolean;
		/**
		 *  The most recent seek that caused a page fault.
		 */
		protected var lastSeekPending : ListBaseSeekPending;
		/**
		 *  An internal display object that parents all of the item renderers,
		 */
		protected var listContent : ListBaseContentHolder;
		private static var _listContentStyleFilters : Object;
		/**
		 *  The layer in <code>listContent</code> where all selection 
		 */
		protected var selectionLayer : Sprite;
		/**
		 *  A hash map of item renderers to their respective ListRowInfo object.
		 */
		protected var rowMap : Object;
		/**
		 *  A map of item renderers by factory.
		 */
		protected var factoryMap : Dictionary;
		/**
		 *  A stack of unused item renderers.
		 */
		protected var freeItemRenderers : Array;
		/**
		 *  A map of free item renderers by factory.
		 */
		protected var freeItemRenderersByFactory : Dictionary;
		/**
		 *  A hash map of currently unused item renderers that may be
		 */
		protected var reservedItemRenderers : Object;
		/**
		 *  A hash map of item renderers that are not subject
		 */
		protected var unconstrainedRenderers : Dictionary;
		/**
		 *  A dictionary mapping item renderers to the ItemWrappers
		 */
		protected var dataItemWrappersByRenderer : Dictionary;
		/**
		 *  A flag that indicates if a data effect should be initiated
		 */
		protected var runDataEffectNextUpdate : Boolean;
		/**
		 *  A flag indicating if a data change effect is currently running.
		 */
		protected var runningDataEffect : Boolean;
		/**
		 *  The effect that plays when changes occur in the data
		 */
		protected var cachedItemsChangeEffect : IEffect;
		/**
		 *  The collection view that temporarily preserves previous
		 */
		protected var modifiedCollectionView : ModifiedCollectionView;
		/**
		 *  A copy of the value normally stored in <code>collection</code>
		 */
		protected var actualCollection : ICollectionView;
		/**
		 *  The target number of extra rows of item renderers to be used in 
		 */
		protected var offscreenExtraRows : int;
		/**
		 *  The number of offscreen rows currently above the topmost visible
		 */
		protected var offscreenExtraRowsTop : int;
		/**
		 *  The number of offscreen rows currently below the bottom visible
		 */
		protected var offscreenExtraRowsBottom : int;
		/**
		 *  The target number of extra columns of item renderers used in the 
		 */
		protected var offscreenExtraColumns : int;
		/**
		 *  The number of offscreen columns currently to the left of the 
		 */
		protected var offscreenExtraColumnsLeft : int;
		/**
		 *  The number of offscreen columns currently to the right of the 
		 */
		protected var offscreenExtraColumnsRight : int;
		/**
		 *  A copy of the value normally stored in <code>iterator</code>
		 */
		protected var actualIterator : IViewCursor;
		/**
		 *  @private
		 */
		local var allowRendererStealingDuringLayout : Boolean;
		/**
		 *  The UID of the item that is current rolled over or under the caret.
		 */
		protected var highlightUID : String;
		/**
		 *  The renderer that is currently rolled over or under the caret.
		 */
		protected var highlightItemRenderer : IListItemRenderer;
		/**
		 *  The DisplayObject that contains the graphics that indicates
		 */
		protected var highlightIndicator : Sprite;
		/**
		 *  The UID of the item under the caret.
		 */
		protected var caretUID : String;
		/**
		 *  The renderer for the item under the caret.  In the selection
		 */
		protected var caretItemRenderer : IListItemRenderer;
		/**
		 *  The DisplayObject that contains the graphics that indicate
		 */
		protected var caretIndicator : Sprite;
		/**
		 *  A hash table of ListBaseSelectionData objects that track which
		 */
		protected var selectedData : Object;
		/**
		 *  A hash table of selection indicators. This table allows the component
		 */
		protected var selectionIndicators : Object;
		/**
		 *  A hash table of selection tweens. This allows the component to
		 */
		protected var selectionTweens : Object;
		/**
		 *  A bookmark to the item under the caret. A bookmark allows the
		 */
		protected var caretBookmark : CursorBookmark;
		/**
		 *  A bookmark to the item that is the anchor. A bookmark allows the
		 */
		protected var anchorBookmark : CursorBookmark;
		/**
		 *  A flag that indicates whether to show caret.  
		 */
		protected var showCaret : Boolean;
		/**
		 *  The most recently calculated index where the drag item
		 */
		protected var lastDropIndex : int;
		/**
		 *  A flag that indicates whether the <code>columnWidth</code> 
		 */
		protected var itemsNeedMeasurement : Boolean;
		/**
		 *  A flag that indicates that the size of the renderers may have changed.
		 */
		protected var itemsSizeChanged : Boolean;
		/**
		 *  A flag that indicates that the renderer changed.
		 */
		protected var rendererChanged : Boolean;
		/**
		 *  A flag that indicates that the a data change effect has
		 */
		protected var dataEffectCompleted : Boolean;
		/**
		 *  A flag that indicates whether the value of the <code>wordWrap</code> 
		 */
		protected var wordWrapChanged : Boolean;
		/**
		 *  A flag that indicates if keyboard selection was interrupted by 
		 */
		protected var keySelectionPending : Boolean;
		/**
		 *  @private
		 */
		local var cachedPaddingTop : Number;
		/**
		 *  @private
		 */
		local var cachedPaddingBottom : Number;
		/**
		 *  @private
		 */
		local var cachedVerticalAlign : String;
		/**
		 *  @private
		 */
		private var oldUnscaledWidth : Number;
		/**
		 *  @private
		 */
		private var oldUnscaledHeight : Number;
		/**
		 *  @private
		 */
		private var horizontalScrollPositionPending : Number;
		/**
		 *  @private
		 */
		private var verticalScrollPositionPending : Number;
		/**
		 *  @private
		 */
		private var mouseDownPoint : Point;
		/**
		 *  @private
		 */
		private var bSortItemPending : Boolean;
		private var bShiftKey : Boolean;
		private var bCtrlKey : Boolean;
		private var lastKey : uint;
		private var bSelectItem : Boolean;
		/**
		 *  @private
		 */
		private var approximate : Boolean;
		local var bColumnScrolling : Boolean;
		local var listType : String;
		local var bSelectOnRelease : Boolean;
		private var mouseDownItem : IListItemRenderer;
		local var bSelectionChanged : Boolean;
		local var bSelectedIndexChanged : Boolean;
		private var bSelectedItemChanged : Boolean;
		private var bSelectedItemsChanged : Boolean;
		private var bSelectedIndicesChanged : Boolean;
		/**
		 *  @private
		 */
		private var cachedPaddingTopInvalid : Boolean;
		/**
		 *  @private
		 */
		private var cachedPaddingBottomInvalid : Boolean;
		/**
		 *  @private
		 */
		private var cachedVerticalAlignInvalid : Boolean;
		/**
		 *  @private
		 */
		private var firstSelectionData : ListBaseSelectionData;
		/**
		 *  @private
		 */
		private var lastSelectionData : ListBaseSelectionData;
		/**
		 *  The renderer that is or was rolled over or under the caret.
		 */
		local var lastHighlightItemRenderer : IListItemRenderer;
		/**
		 *  The renderer that is or was rolled over or under the caret.
		 */
		local var lastHighlightItemRendererAtIndices : IListItemRenderer;
		/**
		 *  The last coordinate send in ITEM_ROLL_OVER
		 */
		private var lastHighlightItemIndices : Point;
		local var dragScrollingInterval : int;
		/**
		 *  @private
		 */
		private var itemMaskFreeList : Array;
		/**
		 *  @private
		 */
		private var trackedRenderers : Array;
		/**
		 *  @private
		 */
		private var rendererTrackingSuspended : Boolean;
		/**
		 *  @private
		 */
		local var isPressed : Boolean;
		/**
		 *  A separate IViewCursor used to find indices of items and
		 */
		local var collectionIterator : IViewCursor;
		local var dropIndicator : IFlexDisplayObject;
		local var lastDragEvent : DragEvent;
		/**
		 *  A flag that indicates whether drag-selection is enabled.
		 */
		public var allowDragSelection : Boolean;
		/**
		 *  @private
		 */
		private var _allowMultipleSelection : Boolean;
		/**
		 *  The offset of the item in the data provider that is the selection
		 */
		protected var anchorIndex : int;
		/**
		 *  The offset of the item in the data provider that is the selection
		 */
		protected var caretIndex : int;
		/**
		 *  @private
		 */
		private var _columnCount : int;
		/**
		 *  @private
		 */
		private var columnCountChanged : Boolean;
		/**
		 *  @private
		 */
		private var _columnWidth : Number;
		/**
		 *  @private
		 */
		private var columnWidthChanged : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _dataTipField : String;
		/**
		 *  @private
		 */
		private var _dataTipFunction : Function;
		/**
		 *  The default number of columns to display.  This value
		 */
		protected var defaultColumnCount : int;
		/**
		 *  The default number of rows to display.  This value
		 */
		protected var defaultRowCount : int;
		/**
		 *  @private
		 */
		private var _dragEnabled : Boolean;
		/**
		 *  @private
		 */
		private var _dragMoveEnabled : Boolean;
		/**
		 *  @private
		 */
		private var _dropEnabled : Boolean;
		/**
		 *  The column count requested by explicitly setting the
		 */
		protected var explicitColumnCount : int;
		/**
		 *  The column width requested by explicitly setting the 
		 */
		protected var explicitColumnWidth : Number;
		/**
		 *  The row count requested by explicitly setting
		 */
		protected var explicitRowCount : int;
		/**
		 *  The row height requested by explicitly setting
		 */
		protected var explicitRowHeight : Number;
		/**
		 *  @private
		 */
		private var _iconField : String;
		/**
		 *  @private
		 */
		private var _iconFunction : Function;
		/**
		 *  @private
		 */
		private var _itemRenderer : IFactory;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  @private
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var _listData : BaseListData;
		/**
		 *  A flag that indicates whether menu-style selection
		 */
		public var menuSelectionMode : Boolean;
		/**
		 *  @private
		 */
		private var _offscreenExtraRowsOrColumns : int;
		/**
		 *  A flag indicating that the number of offscreen rows or columns
		 */
		protected var offscreenExtraRowsOrColumnsChanged : Boolean;
		/**
		 *  @private
		 */
		private var _nullItemRenderer : IFactory;
		/**
		 *  @private
		 */
		private var _rowCount : int;
		/**
		 *  @private
		 */
		private var rowCountChanged : Boolean;
		/**
		 *  @private
		 */
		private var _rowHeight : Number;
		/**
		 *  @private
		 */
		private var rowHeightChanged : Boolean;
		/**
		 *  @private
		 */
		private var _selectable : Boolean;
		/**
		 *  @private
		 */
		local var _selectedIndex : int;
		private var _selectedIndices : Array;
		/**
		 *  @private
		 */
		private var _selectedItem : Object;
		private var _selectedItems : Array;
		/**
		 *  @private
		 */
		private var _showDataTips : Boolean;
		/**
		 *  @private
		 */
		private var _variableRowHeight : Boolean;
		/**
		 *  @private
		 */
		private var _wordWrap : Boolean;

		/**
		 *  A hash table of data provider item renderers currently in view.
		 */
		protected function get visibleData () : Object;
		/**
		 *  The set of styles to pass from the ListBase to the listContent.
		 */
		protected function get listContentStyleFilters () : Object;
		/**
		 *  An Array of Arrays that contains
		 */
		protected function get listItems () : Array;
		/**
		 *  An array of ListRowInfo objects that cache row heights and 
		 */
		protected function get rowInfo () : Array;
		/**
		 *  diagnostics
		 */
		function get rendererArray () : Array;
		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set horizontalScrollPosition (value:Number) : void;
		function set $horizontalScrollPosition (value:Number) : void;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;
		function set $verticalScrollPosition (value:Number) : void;
		/**
		 *  A flag that indicates whether you can allow more than one item to be
		 */
		public function get allowMultipleSelection () : Boolean;
		/**
		 *  @private
		 */
		public function set allowMultipleSelection (value:Boolean) : void;
		/**
		 *  The number of columns to be displayed in a TileList control or items 
		 */
		public function get columnCount () : int;
		/**
		 *  @private
		 */
		public function set columnCount (value:int) : void;
		/**
		 *  The width of the control's columns.
		 */
		public function get columnWidth () : Number;
		/**
		 *  @private
		 */
		public function set columnWidth (value:Number) : void;
		/**
		 *  The item in the data provider this component should render when
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  Set of data to be viewed.
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  Name of the field in the data provider items to display as the 
		 */
		public function get dataTipField () : String;
		/**
		 *  @private
		 */
		public function set dataTipField (value:String) : void;
		/**
		 *  User-supplied function to run on each item to determine its dataTip.  
		 */
		public function get dataTipFunction () : Function;
		/**
		 *  @private
		 */
		public function set dataTipFunction (value:Function) : void;
		/**
		 *  A flag that indicates whether you can drag items out of
		 */
		public function get dragEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dragEnabled (value:Boolean) : void;
		/**
		 *  Gets an instance of a class that displays the visuals
		 */
		protected function get dragImage () : IUIComponent;
		/**
		 *  Gets the offset of the drag image for drag and drop.
		 */
		protected function get dragImageOffsets () : Point;
		/**
		 *  A flag that indicates whether items can be moved instead
		 */
		public function get dragMoveEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dragMoveEnabled (value:Boolean) : void;
		/**
		 *  A flag that indicates whether dragged items can be dropped onto the 
		 */
		public function get dropEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set dropEnabled (value:Boolean) : void;
		/**
		 *  The name of the field in the data provider object that determines what to 
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;
		/**
		 *  A user-supplied function to run on each item to determine its icon.  
		 */
		public function get iconFunction () : Function;
		/**
		 *  @private
		 */
		public function set iconFunction (value:Function) : void;
		/**
		 *  The custom item renderer for the control.
		 */
		public function get itemRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set itemRenderer (value:IFactory) : void;
		/**
		 *  The name of the field in the data provider items to display as the label. 
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  A user-supplied function to run on each item to determine its label.  
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  The target number of extra rows or columns of item renderers to be used 
		 */
		public function get offscreenExtraRowsOrColumns () : int;
		public function set offscreenExtraRowsOrColumns (value:int) : void;
		/**
		 *  The custom item renderer for the control.
		 */
		public function get nullItemRenderer () : IFactory;
		/**
		 *  @private
		 */
		public function set nullItemRenderer (value:IFactory) : void;
		/**
		 *  Number of rows to be displayed.
		 */
		public function get rowCount () : int;
		/**
		 *  @private
		 */
		public function set rowCount (value:int) : void;
		/**
		 *  The height of the rows in pixels.
		 */
		public function get rowHeight () : Number;
		/**
		 *  @private
		 */
		public function set rowHeight (value:Number) : void;
		/**
		 *  A flag that indicates whether the list shows selected items
		 */
		public function get selectable () : Boolean;
		/**
		 *  @private
		 */
		public function set selectable (value:Boolean) : void;
		/**
		 *  The index in the data provider of the selected item.
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  An array of indices in the data provider of the selected items. The
		 */
		public function get selectedIndices () : Array;
		/**
		 *  @private
		 */
		public function set selectedIndices (indices:Array) : void;
		/**
		 *  A reference to the selected item in the data provider.
		 */
		public function get selectedItem () : Object;
		/**
		 *  @private
		 */
		public function set selectedItem (data:Object) : void;
		/**
		 *  An array of references to the selected items in the data provider. The
		 */
		public function get selectedItems () : Array;
		/**
		 *  @private
		 */
		public function set selectedItems (items:Array) : void;
		/**
		 *  A flag that indicates whether dataTips are displayed for text in the rows.
		 */
		public function get showDataTips () : Boolean;
		/**
		 *  @private
		 */
		public function set showDataTips (value:Boolean) : void;
		/**
		 *  The selected item, or the data or label field of the selected item.
		 */
		public function get value () : Object;
		/**
		 *  A flag that indicates whether the individual rows can have different
		 */
		public function get variableRowHeight () : Boolean;
		/**
		 *  @private
		 */
		public function set variableRowHeight (value:Boolean) : void;
		/**
		 *  A flag that indicates whether text in the row should be word wrapped.
		 */
		public function get wordWrap () : Boolean;
		/**
		 *  @private
		 */
		public function set wordWrap (value:Boolean) : void;
		/**
		 *  If false, renderers cannot invalidate size of List.
		 */
		protected function set allowItemSizeChangeNotification (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function ListBase ();
		private function makeRowsAndColumnsWithExtraRows (unscaledWidth:Number, unscaledHeight:Number) : void;
		private function makeRowsAndColumnsWithExtraColumns (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Internal version for setting columnCount
		 */
		function setColumnCount (value:int) : void;
		/**
		 *  Internal version of setting columnWidth
		 */
		function setColumnWidth (value:Number) : void;
		/**
		 *  Sets the <code>rowCount</code> property without causing
		 */
		protected function setRowCount (v:int) : void;
		/**
		 *  Sets the <code>rowHeight</code> property without causing invalidation or 
		 */
		protected function setRowHeight (v:Number) : void;
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  Creates objects that are children of this ListBase; in this case,
		 */
		protected function createChildren () : void;
		/**
		 *  Calculates the column width and row height and number of rows and
		 */
		protected function commitProperties () : void;
		/**
		 *  Calculates the measured width and height of the component based 
		 */
		protected function measure () : void;
		/**
		 *  @private 
		 */
		public function validateDisplayList () : void;
		/**
		 *  Initiates a data change effect when there have been changes
		 */
		protected function initiateDataChangeEffect (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function initiateSelectionTracking (renderers:Array) : void;
		/**
		 *  @private
		 */
		private function terminateSelectionTracking () : void;
		/**
		 *  @inheritDoc
		 */
		public function removeDataEffectItem (item:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function addDataEffectItem (item:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function unconstrainRenderer (item:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function getRendererSemanticValue (target:Object, semanticProperty:String) : Object;
		/**
		 *  Returns <code>true</code> if an item renderer is no longer being positioned
		 */
		protected function isRendererUnconstrained (item:Object) : Boolean;
		/**
		 *  Cleans up after a data change effect has finished running
		 */
		protected function finishDataChangeEffect (event:EffectEvent) : void;
		/**
		 * @private
		 */
		private function cleanupAfterDataChangeEffect () : void;
		/**
		 *  Adds or removes item renderers if the number of displayable items 
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Called from the <code>updateDisplayList()</code> method to adjust the size and position of
		 */
		protected function adjustListContent (unscaledWidth:Number = -1, unscaledHeight:Number = -1) : void;
		/**
		 *  @private
		 */
		private function adjustScrollPosition () : void;
		/**
		 *  @private
		 */
		function adjustOffscreenRowsAndColumns () : void;
		/**
		 *  Called by the <code>updateDisplayList()</code> method to remove existing item renderers
		 */
		protected function purgeItemRenderers () : void;
		/**
		 *  @private
		 */
		private function partialPurgeItemRenderers () : void;
		/**
		 *  @private
		 */
		private function reduceRows (rowIndex:int) : void;
		/**
		 *  @private
		 */
		private function makeAdditionalRows (rowIndex:int) : void;
		/**
		 *  @private
		 */
		private function adjustSelectionSettings (collectionHasItems:Boolean) : void;
		/**
		 *  @private
		 */
		private function seekPositionIgnoreError (iterator:IViewCursor, cursorPos:CursorBookmark) : void;
		/**
		 *  @private
		 */
		private function seekNextSafely (iterator:IViewCursor, pos:int) : Boolean;
		private function seekPreviousSafely (iterator:IViewCursor, pos:int) : Boolean;
		/**
		 *  Seek to a position, and handle an ItemPendingError if necessary.
		 */
		protected function seekPositionSafely (index:int) : Boolean;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  Measures a set of items from the data provider using
		 */
		public function measureWidthOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  Measures a set of items from the data provider using the
		 */
		public function measureHeightOfItems (index:int = -1, count:int = 0) : Number;
		/**
		 *  Returns the string the renderer would display for the given data object
		 */
		public function itemToLabel (data:Object) : String;
		/**
		 *  Returns the dataTip string the renderer would display for the given
		 */
		public function itemToDataTip (data:Object) : String;
		/**
		 *  Returns the class for an icon, if any, for a data item,  
		 */
		public function itemToIcon (data:Object) : Class;
		/**
		 *  Make enough rows and columns to fill the area
		 */
		protected function makeRowsAndColumns (left:Number, top:Number, right:Number, bottom:Number, firstColumn:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0) : Point;
		/**
		 *  Computes the offset into the data provider of the item
		 */
		public function indicesToIndex (rowIndex:int, colIndex:int) : int;
		/**
		 *  The row for the data provider item at the given index.
		 */
		protected function indexToRow (index:int) : int;
		/**
		 *  The column for the data provider item at the given index.
		 */
		protected function indexToColumn (index:int) : int;
		/**
		 *  @private
		 */
		function indicesToItemRenderer (row:int, col:int) : IListItemRenderer;
		/**
		 *  Returns a Point containing the columnIndex and rowIndex of an
		 */
		protected function itemRendererToIndices (item:IListItemRenderer) : Point;
		/**
		 *  Get an item renderer for the index of an item in the data provider,
		 */
		public function indexToItemRenderer (index:int) : IListItemRenderer;
		/**
		 *  Returns the index of the item in the data provider of the item
		 */
		public function itemRendererToIndex (itemRenderer:IListItemRenderer) : int;
		/**
		 *  Determines the UID for a data provider item.  All items
		 */
		protected function itemToUID (data:Object) : String;
		/**
		 *  Find an item renderer based on its UID if it is visible.
		 */
		protected function UIDToItemRenderer (uid:String) : IListItemRenderer;
		/**
		 *  Returns the item renderer for a given item in the data provider,
		 */
		public function itemToItemRenderer (item:Object) : IListItemRenderer;
		/**
		 *  Determines if an item is being displayed by a renderer.
		 */
		public function isItemVisible (item:Object) : Boolean;
		/**
		 *  Determines which item renderer is under the mouse.  Item
		 */
		protected function mouseEventToItemRenderer (event:MouseEvent) : IListItemRenderer;
		/**
		 *  @private
		 */
		function mouseEventToItemRendererOrEditor (event:MouseEvent) : IListItemRenderer;
		/**
		 *  @private
		 */
		function hasOnlyTextRenderers () : Boolean;
		/**
		 *  Determines whether a renderer contains (or owns) a display object.
		 */
		public function itemRendererContains (renderer:IListItemRenderer, object:DisplayObject) : Boolean;
		/**
		 *  Adds a renderer to the recycled renderer list,
		 */
		protected function addToFreeItemRenderers (item:IListItemRenderer) : void;
		/**
		 *  Retrieves an already-created item renderer not currently in use.
		 */
		protected function getReservedOrFreeItemRenderer (data:Object) : IListItemRenderer;
		/**
		 *  Return the appropriate factory, using the default factory if none specified.
		 */
		public function getItemRendererFactory (data:Object) : IFactory;
		/**
		 *  Draws any alternating row colors, borders and backgrounds for the rows.
		 */
		protected function drawRowBackgrounds () : void;
		/**
		 *  Draws the renderer with indicators
		 */
		protected function drawItem (item:IListItemRenderer, selected:Boolean = false, highlighted:Boolean = false, caret:Boolean = false, transition:Boolean = false) : void;
		/**
		 *  Draws the highlight indicator into the given Sprite
		 */
		protected function drawHighlightIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  Clears the highlight indicator in the given Sprite.
		 */
		protected function clearHighlightIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;
		/**
		 *  Draws the selection indicator into the given Sprite
		 */
		protected function drawSelectionIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  Draws the caret indicator into the given Sprite
		 */
		protected function drawCaretIndicator (indicator:Sprite, x:Number, y:Number, width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer) : void;
		/**
		 *  Clears the caret indicator into the given Sprite.
		 */
		protected function clearCaretIndicator (indicator:Sprite, itemRenderer:IListItemRenderer) : void;
		/**
		 *  Removes all selection and highlight and caret indicators.
		 */
		protected function clearIndicators () : void;
		/**
		 *  Cleans up selection highlights and other associated graphics
		 */
		protected function removeIndicators (uid:String) : void;
		/**
		 *  @private
		 */
		function clearHighlight (item:IListItemRenderer) : void;
		/**
		 *  Refresh all rows on the next update.
		 */
		public function invalidateList () : void;
		/**
		 *  Refreshes all rows. Calling this method can require substantial
		 */
		protected function updateList () : void;
		/**
		 *  Empty the visibleData hash table.
		 */
		protected function clearVisibleData () : void;
		/**
		 *  Update the keys in the visibleData hash table.
		 */
		protected function reKeyVisibleData () : void;
		/**
		 *  @private
		 */
		function addClipMask (layoutChanged:Boolean) : void;
		/**
		 *  @private
		 */
		function createItemMask (x:Number, y:Number, width:Number, height:Number) : DisplayObject;
		/**
		 *  @private
		 */
		function removeClipMask () : void;
		/**
		 *  Determines if the item renderer for a data provider item 
		 */
		public function isItemHighlighted (data:Object) : Boolean;
		/**
		 *  Determines if the item renderer for a data provider item 
		 */
		public function isItemSelected (data:Object) : Boolean;
		/**
		 *  Determines if the item renderer for a data provider item 
		 */
		public function isItemSelectable (data:Object) : Boolean;
		/**
		 *  @private
		 */
		private function calculateSelectedIndexAndItem () : void;
		/**
		 *  Updates the set of selected items given that the item renderer provided
		 */
		protected function selectItem (item:IListItemRenderer, shiftKey:Boolean, ctrlKey:Boolean, transition:Boolean = true) : Boolean;
		/**
		 *  @private
		 */
		private function shiftSelectionLoop (incr:Boolean, index:int, stopData:Object, transition:Boolean, placeHolder:CursorBookmark) : void;
		/**
		 *  Clears the set of selected items and removes all graphics
		 */
		protected function clearSelected (transition:Boolean = false) : void;
		/**
		 *  Moves the selection in a horizontal direction in response
		 */
		protected function moveSelectionHorizontally (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 *  Moves the selection in a vertical direction in response
		 */
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		/**
		 *  Sets selected items based on the <code>caretIndex</code> and 
		 */
		protected function finishKeySelection () : void;
		/**
		 *  @private
		 */
		function commitSelectedIndex (value:int) : void;
		/**
		 *  @private
		 */
		function commitSelectedIndices (indices:Array) : void;
		/**
		 *  @private
		 */
		private function setSelectionIndicesLoop (index:int, indices:Array, firstTime:Boolean = false) : void;
		/**
		 *  @private
		 */
		private function commitSelectedItem (data:Object, clearFirst:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function commitSelectedItems (items:Array) : void;
		/**
		 *  @private
		 */
		private function setSelectionDataLoop (items:Array, index:int, useFind:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function clearSelectionData () : void;
		/**
		 *  Adds the selection data after the item in the list
		 */
		private function insertSelectionDataBefore (uid:String, selectionData:ListBaseSelectionData, nextSelectionData:ListBaseSelectionData) : void;
		/**
		 *  Adds the selection data after the item in the list
		 */
		private function insertSelectionDataAfter (uid:String, selectionData:ListBaseSelectionData, prevSelectionData:ListBaseSelectionData) : void;
		/**
		 *  @private
		 */
		private function removeSelectionData (uid:String) : void;
		/**
		 *  Sets up the effect for applying the selection indicator.
		 */
		protected function applySelectionEffect (indicator:Sprite, uid:String, itemRenderer:IListItemRenderer) : void;
		/**
		 *  @private
		 */
		private function onSelectionTweenUpdate (value:Number) : void;
		/**
		 *  Copies the selected items in the order that they were selected.
		 */
		protected function copySelectedItems (useDataField:Boolean = true) : Array;
		/**
		 *  Returns the data provider index for the item at the first visible
		 */
		protected function scrollPositionToIndex (horizontalScrollPosition:int, verticalScrollPosition:int) : int;
		/**
		 *  Ensures that the data provider item at the given index is visible.
		 */
		public function scrollToIndex (index:int) : Boolean;
		/**
		 *  Adjusts the renderers in response to a change
		 */
		protected function scrollVertically (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  Recycle a row that is no longer needed, and remove its indicators.
		 */
		protected function destroyRow (i:int, numCols:int) : void;
		/**
		 *  Move a row vertically, and update the rowInfo record.
		 */
		protected function moveRowVertically (i:int, numCols:int, moveBlockDistance:Number) : void;
		/**
		 *  Shift a row in the arrays that reference rows.
		 */
		protected function shiftRow (oldIndex:int, newIndex:int, numCols:int, shiftItems:Boolean) : void;
		/**
		 *  Move the selection and highlight indicators vertically.
		 */
		protected function moveIndicatorsVertically (uid:String, moveBlockDistance:Number) : void;
		/**
		 *  Move the selection and highlight indicators horizontally.
		 */
		protected function moveIndicatorsHorizontally (uid:String, moveBlockDistance:Number) : void;
		/**
		 *  Determine the height of the requested set of rows.
		 */
		protected function sumRowHeights (startRowIdx:int, endRowIdx:int) : Number;
		/**
		 *  Remove all remaining rows from the end of the
		 */
		protected function truncateRowArrays (numRows:int) : void;
		/**
		 *  Add a blank row to the beginning of the arrays that store references to the rows.
		 */
		protected function addToRowArrays () : void;
		/**
		 *  Remove the requested number of rows from the beginning of the 
		 */
		protected function restoreRowArrays (modDeltaPos:int) : void;
		/**
		 *  Remove a row from the arrays that store references to the row.
		 */
		protected function removeFromRowArrays (i:int) : void;
		/**
		 *  Adjusts the renderers in response to a change
		 */
		protected function scrollHorizontally (pos:int, deltaPos:int, scrollUp:Boolean) : void;
		/**
		 *  Creates an item renderer given the data object.
		 */
		public function createItemRenderer (data:Object) : IListItemRenderer;
		/**
		 *  Configures the ScrollBars based on the number of rows and columns and
		 */
		protected function configureScrollBars () : void;
		/**
		 *  Interval function that scrolls the list up or down
		 */
		protected function dragScroll () : void;
		/**
		 *  @private
		 */
		function resetDragScrolling () : void;
		/**
		 *  Adds the selected items to the DragSource object as part of a
		 */
		protected function addDragData (ds:Object) : void;
		/**
		 *  Returns the index where the dropped items should be added 
		 */
		public function calculateDropIndex (event:DragEvent = null) : int;
		/**
		 *  Calculates the y position of the drop indicator 
		 */
		protected function calculateDropIndicatorY (rowCount:Number, rowNum:int) : Number;
		/**
		 *  Displays a drop indicator under the mouse pointer to indicate that a
		 */
		public function showDropFeedback (event:DragEvent) : void;
		/**
		 *  Hides the drop indicator under the mouse pointer that indicates that a
		 */
		public function hideDropFeedback (event:DragEvent) : void;
		/**
		 *  The default failure handler when a seek fails due to a page fault.
		 */
		protected function seekPendingFailureHandler (data:Object, info:ListBaseSeekPending) : void;
		/**
		 *  The default result handler when a seek fails due to a page fault.
		 */
		protected function seekPendingResultHandler (data:Object, info:ListBaseSeekPending) : void;
		/**
		 *  @private
		 */
		private function findPendingFailureHandler (data:Object, info:ListBaseFindPending) : void;
		/**
		 *  @private
		 */
		private function findPendingResultHandler (data:Object, info:ListBaseFindPending) : void;
		/**
		 *  @private
		 */
		private function selectionPendingFailureHandler (data:Object, info:ListBaseSelectionPending) : void;
		/**
		 *  @private
		 */
		private function selectionPendingResultHandler (data:Object, info:ListBaseSelectionPending) : void;
		/**
		 *  @private
		 */
		private function selectionDataPendingFailureHandler (data:Object, info:ListBaseSelectionDataPending) : void;
		/**
		 *  @private
		 */
		function selectionDataPendingResultHandler (data:Object, info:ListBaseSelectionDataPending) : void;
		/**
		 *  @private
		 */
		private function selectionIndicesPendingFailureHandler (data:Object, info:ListBaseSelectionDataPending) : void;
		/**
		 *  @private
		 */
		private function selectionIndicesPendingResultHandler (data:Object, info:ListBaseSelectionDataPending) : void;
		/**
		 *  Tries to find the next item in the data provider that
		 */
		protected function findKey (eventCode:int) : Boolean;
		/**
		 *  Finds an item in the list based on a String,
		 */
		public function findString (str:String) : Boolean;
		/**
		 *  @private
		 */
		private function findStringLoop (str:String, cursorPos:CursorBookmark, i:int, stopIndex:int) : Boolean;
		/**
		 *  @private
		 */
		private function adjustAfterSort () : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  Handles <code>mouseWheel</code> events by changing scroll positions.
		 */
		protected function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  Handles CollectionEvents dispatched from the data provider
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function reconstructDataFromListItems () : Array;
		/**
		 *  Prepares the data effect for the collection event.
		 */
		protected function prepareDataEffect (ce:CollectionEvent) : void;
		/**
		 *  @private
		 */
		protected function adjustAfterAdd (items:Array, location:int) : Boolean;
		/**
		 *  @private
		 */
		protected function adjustAfterRemove (items:Array, location:int, emitEvent:Boolean) : Boolean;
		/**
		 *  @private
		 */
		function setBookmarkPendingFailureHandler (data:Object, info:Object) : void;
		/**
		 *  @private
		 */
		function setBookmarkPendingResultHandler (data:Object, info:Object) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_OVER</code> events from any mouse
		 */
		protected function mouseOverHandler (event:MouseEvent) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_OUT</code> events from any mouse targets
		 */
		protected function mouseOutHandler (event:MouseEvent) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_MOVE</code> events from any mouse
		 */
		protected function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_DOWN</code> events from any mouse
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		private function mouseIsUp () : void;
		private function mouseLeaveHandler (event:Event) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_DOWN</code> events from any mouse
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_CLICK</code> events from any mouse
		 */
		protected function mouseClickHandler (event:MouseEvent) : void;
		/**
		 *  Handles <code>MouseEvent.MOUSE_DOUBLE_CLICK</code> events from any
		 */
		protected function mouseDoubleClickHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>dragStart</code> event.
		 */
		protected function dragStartHandler (event:DragEvent) : void;
		/**
		 *  Handles <code>DragEvent.DRAG_ENTER</code> events.  This method
		 */
		protected function dragEnterHandler (event:DragEvent) : void;
		/**
		 *  Handles <code>DragEvent.DRAG_OVER</code> events. This method
		 */
		protected function dragOverHandler (event:DragEvent) : void;
		/**
		 *  Handles <code>DragEvent.DRAG_EXIT</code> events. This method hides
		 */
		protected function dragExitHandler (event:DragEvent) : void;
		/**
		 *  Handles <code>DragEvent.DRAG_DROP events</code>. This method  hides
		 */
		protected function dragDropHandler (event:DragEvent) : void;
		/**
		 *  Makes a deep copy of the object by calling the 
		 */
		protected function copyItemWithUID (item:Object) : Object;
		/**
		 *  Handles <code>DragEvent.DRAG_COMPLETE</code> events.  This method
		 */
		protected function dragCompleteHandler (event:DragEvent) : void;
		/**
		 *  @private
		 */
		function selectionTween_updateHandler (event:TweenEvent) : void;
		/**
		 *  @private
		 */
		function selectionTween_endHandler (event:TweenEvent) : void;
		/**
		 *  @private
		 */
		private function rendererMoveHandler (event:MoveEvent) : void;
		/**
		 *  @private
		 */
		function getListVisibleData () : Object;
		/**
		 *  @private
		 */
		function getItemUID (data:Object) : String;
		/**
		 *  @private
		 */
		function getItemRendererForMouseEvent (event:MouseEvent) : IListItemRenderer;
		/**
		 *  @private
		 */
		function getListContentHolder () : ListBaseContentHolder;
		/**
		 *  @private
		 */
		function getRowInfo () : Array;
		/**
		 *  @private
		 */
		function convertIndexToRow (index:int) : int;
		/**
		 *  @private
		 */
		function convertIndexToColumn (index:int) : int;
		/**
		 *  @private
		 */
		function getCaretIndex () : int;
		/**
		 *  @private
		 */
		function getIterator () : IViewCursor;
	}
}