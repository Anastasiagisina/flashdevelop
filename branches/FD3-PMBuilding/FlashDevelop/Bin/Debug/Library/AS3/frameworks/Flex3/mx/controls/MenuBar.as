﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.containers.ApplicationControlBar;
	import mx.controls.menuClasses.IMenuBarItemRenderer;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.controls.menuClasses.MenuBarItem;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.ClassFactory;
	import mx.core.EventPriority;
	import mx.core.FlexVersion;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.MenuEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProxy;
	import mx.collections.IViewCursor;
	import mx.events.InterManagerRequest;

	/**
	 *  Dispatched when selection changes as a result of user 
	 */
	[Event(name="change", type="mx.events.MenuEvent")] 
	/**
	 *  Dispatched when the user selects an item in a pop-up submenu.
	 */
	[Event(name="itemClick", type="mx.events.MenuEvent")] 
	/**
	 *  Dispatched when a pop-up submenu closes.
	 */
	[Event(name="menuHide", type="mx.events.MenuEvent")] 
	/**
	 *  Dispatched when a pop-up submenu opens, or the 
	 */
	[Event(name="menuShow", type="mx.events.MenuEvent")] 
	/**
	 *  Dispatched when the mouse pointer rolls out of a menu item.
	 */
	[Event(name="itemRollOut", type="mx.events.MenuEvent")] 
	/**
	 *  Dispatched when the mouse pointer rolls over a menu item.
	 */
	[Event(name="itemRollOver", type="mx.events.MenuEvent")] 
	/**
	 *  Alpha level of the color defined by the <code>backgroundColor</code>
	 */
	[Style(name="backgroundAlpha", type="Number", inherit="no", deprecatedReplacement="menuStyleName", deprecatedSince="3.0")] 
	/**
	 *  Background color of the component.
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no", deprecatedReplacement="menuStyleName", deprecatedSince="3.0")] 
	/**
	 *  The background skin of the MenuBar control. 
	 */
	[Style(name="backgroundSkin", type="Class", inherit="no")] 
	/**
	 *  The default skin for a MenuBar item
	 */
	[Style(name="itemSkin", type="Class", inherit="no", states="up, over, down")] 
	/**
	 *  The skin when a MenuBar item is not selected.
	 */
	[Style(name="itemUpSkin", type="Class", inherit="no")] 
	/**
	 *  The skin when focus is over a MenuBar item either. 
	 */
	[Style(name="itemOverSkin", type="Class", inherit="no")] 
	/**
	 *  The skin when a MenuBar item is selected. 
	 */
	[Style(name="itemDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the CSSStyleDeclaration that specifies the styles for
	 */
	[Style(name="menuStyleName", type="String", inherit="no")] 
	/**
	 *  @copy mx.controls.Menu#style:rollOverColor
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  @copy mx.controls.Menu#style:selectionColor
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  A MenuBar control defines a horizontal, top-level menu bar that contains
	 */
	public class MenuBar extends UIComponent implements IFocusManagerComponent
	{
		/**
		 *  @private
		 */
		private static const MARGIN_WIDTH : int = 10;
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		local var _rootModel : ICollectionView;
		/**
		 *  @private
		 */
		private var isDown : Boolean;
		/**
		 *  @private
		 */
		private var inKeyDown : Boolean;
		/**
		 *  @private
		 */
		private var background : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var isInsideACB : Boolean;
		/**
		 *  @private
		 */
		private var supposedToLoseFocus : Boolean;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
		 */
		private var iconFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var menuBarItemRendererChanged : Boolean;
		/**
		 *  @private
		 */
		local var _dataDescriptor : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		local var _hasRoot : Boolean;
		/**
		 *  @private
		 */
		private var _iconField : String;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  The function that determines the text to display for each menu item.
		 */
		public var labelFunction : Function;
		/**
		 *  @private
		 */
		private var _menuBarItemRenderer : IFactory;
		/**
		 *  An Array that contains the MenuBarItem objects that render 
		 */
		public var menuBarItems : Array;
		private static var _menuBarItemStyleFilters : Object;
		/**
		 *  An Array containing the Menu objects corresponding to the 
		 */
		public var menus : Array;
		/**
		 *  @private
		 */
		private var openMenuIndex : int;
		/**
		 *  @private
		 */
		local var _showRoot : Boolean;
		/**
		 *  @private
		 */
		local var showRootChanged : Boolean;

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
		 *  The object that accesses and manipulates data in the data provider. 
		 */
		public function get dataDescriptor () : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;
		/**
		 *  The hierarchy of objects that are displayed as MenuBar items and menus. 
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @copy mx.controls.Menu#hasRoot
		 */
		public function get hasRoot () : Boolean;
		/**
		 *  The name of the field in the data provider that determines the 
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;
		/**
		 *  The name of the field in the data provider that determines the 
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  The item renderer used by the MenuBar control for 
		 */
		public function get menuBarItemRenderer () : IFactory;
		/**
		 * @private
		 */
		public function set menuBarItemRenderer (value:IFactory) : void;
		/**
		 *  The set of styles to pass from the MenuBar to the menuBar items.
		 */
		protected function get menuBarItemStyleFilters () : Object;
		/**
		 *  The index in the MenuBar control of the currently open Menu 
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  A Boolean flag that specifies whether to display the data provider's 
		 */
		public function get showRoot () : Boolean;
		/**
		 *  @private
		 */
		public function set showRoot (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function MenuBar ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  Updates the MenuBar control's background skin. 
		 */
		protected function updateBackground () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Calculates the preferred width and height of the MenuBar based on the
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
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
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @private
		 */
		private function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function eventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function addMenuAt (index:int, arg1:Object, arg2:Object = null) : void;
		/**
		 *  @copy mx.controls.listClasses.ListBase#itemToLabel()
		 */
		public function itemToLabel (data:Object) : String;
		/**
		 *  Returns the class for an icon, if any, for a data item,  
		 */
		public function itemToIcon (data:Object) : Class;
		/**
		 *  @private
		 */
		private function insertMenuBarItem (index:int, mdp:Object) : void;
		/**
		 *  Returns a reference to the Menu object at the specified MenuBar item index,  
		 */
		public function getMenuAt (index:int) : Menu;
		/**
		 *  @private
		 */
		private function showMenu (index:Number) : void;
		/**
		 *  @private
		 */
		private function removeMenuBarItemAt (index:int) : void;
		/**
		 *  @private
		 */
		private function removeAll () : void;
		/**
		 *  @private
		 */
		private function mouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
	}
}