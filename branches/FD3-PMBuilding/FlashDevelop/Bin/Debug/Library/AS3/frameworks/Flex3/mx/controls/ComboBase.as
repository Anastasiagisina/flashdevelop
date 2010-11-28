﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.ListCollectionView;
	import mx.collections.XMLListCollection;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IIMESupport;
	import mx.core.IRectangularBorder;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;
	import mx.utils.UIDUtil;

	/**
	 *  Name of the class to use as the default skin for the background and border. 
	 */
	[Style(name="skin", type="Class", inherit="no", states=" up, over, down, disabled,  editableUp, editableOver, editableDown, editableDisabled")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="upSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="overSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="downSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="disabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="editableUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="editableOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="editableDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="editableDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  The style declaration for the internal TextInput subcomponent 
	 */
	[Style(name="textInputStyleName", type="String", inherit="no")] 

	/**
	 *  The ComboBase class is the base class for controls that display text in a 
	 */
	public class ComboBase extends UIComponent implements IIMESupport
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  The ICollectionView of items this component displays.
		 */
		protected var collection : ICollectionView;
		/**
		 *  The main IViewCursor used to fetch items from the
		 */
		protected var iterator : IViewCursor;
		/**
		 *  @private
		 */
		local var collectionIterator : IViewCursor;
		/**
		 *  @private
		 */
		local var border : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var downArrowButton : Button;
		/**
		 *  @private
		 */
		local var wrapDownArrowButton : Boolean;
		/**
		 *  @private
		 */
		local var useFullDropdownSkin : Boolean;
		/**
		 *  @private
		 */
		private var selectedUID : String;
		/**
		 *  @private
		 */
		local var selectionChanged : Boolean;
		/**
		 *  @private
		 */
		local var selectedIndexChanged : Boolean;
		/**
		 *  @private
		 */
		local var selectedItemChanged : Boolean;
		/**
		 *  @private
		 */
		local var oldBorderStyle : String;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  @private
		 */
		private var _editable : Boolean;
		/**
		 *  @private
		 */
		local var editableChanged : Boolean;
		/**
		 *  @private
		 */
		private var _imeMode : String;
		/**
		 *  @private
		 */
		private var _restrict : String;
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var _selectedItem : Object;
		/**
		 *  @private
		 */
		private var _text : String;
		/**
		 *  @private
		 */
		local var textChanged : Boolean;
		/**
		 *  The internal TextInput subcomponent that displays
		 */
		protected var textInput : TextInput;
		private static var _textInputStyleFilters : Object;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  Set of styles to pass from the ComboBase to the down arrow button
		 */
		protected function get arrowButtonStyleFilters () : Object;
		/**
		 *  Returns an EdgeMetrics object that has four properties:
		 */
		protected function get borderMetrics () : EdgeMetrics;
		/**
		 *  The set of items this component displays. This property is of type
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  A flag that indicates whether the control is editable, 
		 */
		public function get editable () : Boolean;
		/**
		 *  @private
		 */
		public function set editable (value:Boolean) : void;
		/**
		 *  @copy mx.controls.TextInput#imeMode
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;
		/**
		 *  Set of characters that a user can or cannot enter into the text field.
		 */
		public function get restrict () : String;
		/**
		 *  @private
		 */
		public function set restrict (value:String) : void;
		/**
		 *  The index in the data provider of the selected item.
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  The item in the data provider at the selectedIndex.
		 */
		public function get selectedItem () : Object;
		/**
		 *  @private
		 */
		public function set selectedItem (data:Object) : void;
		/**
		 *  Contents of the text field.  If the control is non-editable
		 */
		public function get text () : String;
		/**
		 *  @private
		 */
		public function set text (value:String) : void;
		/**
		 *  The set of styles to pass from the ComboBase to the text input. 
		 */
		protected function get textInputStyleFilters () : Object;
		/**
		 *  The value of the selected item. If the item is a Number or String,
		 */
		public function get value () : Object;
		/**
		 *  @private
		 */
		function get ComboDownArrowButton () : Button;

		/**
		 *  Constructor.
		 */
		public function ComboBase ();
		/**
		 *  @private
		 */
		private function setSelectedItem (data:Object, clearFirst:Boolean = true) : void;
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Determines the <code>measuredWidth</code> and
		 */
		protected function measure () : void;
		/**
		 *  Sizes and positions the internal components in the given width
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function setFocus () : void;
		/**
		 *  @private
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 *  Determines default values of the height and width to use for the 
		 */
		protected function calculatePreferredSizeFromData (numItems:int) : Object;
		/**
		 *  Determines the UID for a dataProvider item.
		 */
		protected function itemToUID (data:Object) : String;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  Responds to changes to the data provider.  The component will adjust
		 */
		protected function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textInput_mouseEventHandler (event:Event) : void;
		/**
		 *  Handles changes to the TextInput that serves as the editable
		 */
		protected function textInput_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function textInput_valueCommitHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function textInput_enterHandler (event:FlexEvent) : void;
		/**
		 *  Performs some action when the drop-down button is pressed.  This is
		 */
		protected function downArrowButton_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		function getTextInput () : TextInput;
	}
}