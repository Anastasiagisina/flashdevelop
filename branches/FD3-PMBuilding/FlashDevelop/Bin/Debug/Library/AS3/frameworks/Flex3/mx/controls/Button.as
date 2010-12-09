﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IBorder;
	import mx.core.IButton;
	import mx.core.IDataRenderer;
	import mx.core.IFlexAsset;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IInvalidating;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.states.State;
	import mx.styles.ISimpleStyleClient;
	import mx.core.IStateClient;
	import mx.core.IProgrammaticSkin;

	/**
	 *  Dispatched when the user presses the Button control.
	 */
	[Event(name="buttonDown", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the <code>selected</code> property 
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Gap between the label and icon, when the <code>labelPlacement</code> property
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the component's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the component's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of milliseconds to wait after the first <code>buttonDown</code>
	 */
	[Style(name="repeatDelay", type="Number", format="Time", inherit="no")] 
	/**
	 *  Number of milliseconds between <code>buttonDown</code> events
	 */
	[Style(name="repeatInterval", type="Number", format="Time", inherit="no")] 
	/**
	 *  Text color of the label as the user moves the mouse pointer over the button.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Text color of the label as the user presses it.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Gap between the button's label and icon when the <code>labelPlacement</code>
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the background and border. 
	 */
	[Style(name="skin", type="Class", inherit="no", states="up, over, down, disabled, selectedUp, selectedOver, selectedDown, selectedDisabled")] 
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
	[Style(name="selectedUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the background and border
	 */
	[Style(name="selectedDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the default icon. 
	 */
	[Style(name="icon", type="Class", inherit="no", states="up, over, down, disabled, selectedUp, selectedOver, selectedDown, selectedDisabled")] 
	/**
	 *  Name of the class to use as the icon when a toggle button is not 
	 */
	[Style(name="upIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon when the button is not 
	 */
	[Style(name="overIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon when the button is not 
	 */
	[Style(name="downIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon
	 */
	[Style(name="disabledIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon
	 */
	[Style(name="selectedUpIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon
	 */
	[Style(name="selectedOverIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon
	 */
	[Style(name="selectedDownIcon", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon
	 */
	[Style(name="selectedDisabledIcon", type="Class", inherit="no")] 

	/**
	 *  The Button control is a commonly used rectangular button.
	 */
	public class Button extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var skins : Array;
		/**
		 *  @private
		 */
		local var currentSkin : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var icons : Array;
		/**
		 *  @private
		 */
		local var currentIcon : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var autoRepeatTimer : Timer;
		/**
		 *  @private
		 */
		local var buttonOffset : Number;
		/**
		 *  @private
		 */
		local var centerContent : Boolean;
		/**
		 *  @private
		 */
		local var extraSpacing : Number;
		/**
		 *  @private
		 */
		static var TEXT_WIDTH_PADDING : Number;
		/**
		 *  @private
		 */
		private var styleChangedFlag : Boolean;
		/**
		 *  @private
		 */
		private var skinMeasuredWidth : Number;
		/**
		 *  @private
		 */
		private var skinMeasuredHeight : Number;
		/**
		 *  @private
		 */
		private var oldUnscaledWidth : Number;
		/**
		 *  @private
		 */
		private var selectedSet : Boolean;
		private var labelSet : Boolean;
		/**
		 *  @private
		 */
		local var checkedDefaultSkin : Boolean;
		local var defaultSkinUsesStates : Boolean;
		local var checkedDefaultIcon : Boolean;
		local var defaultIconUsesStates : Boolean;
		/**
		 *  @private
		 */
		local var skinName : String;
		local var upSkinName : String;
		local var overSkinName : String;
		local var downSkinName : String;
		local var disabledSkinName : String;
		local var selectedUpSkinName : String;
		local var selectedOverSkinName : String;
		local var selectedDownSkinName : String;
		local var selectedDisabledSkinName : String;
		/**
		 *  @private
		 */
		local var iconName : String;
		local var upIconName : String;
		local var overIconName : String;
		local var downIconName : String;
		local var disabledIconName : String;
		local var selectedUpIconName : String;
		local var selectedOverIconName : String;
		local var selectedDownIconName : String;
		local var selectedDisabledIconName : String;
		/**
		 *  @private
		 */
		private var enabledChanged : Boolean;
		/**
		 *  The internal UITextField object that renders the label of this Button.
		 */
		protected var textField : IUITextField;
		/**
		 *  @private
		 */
		private var toolTipSet : Boolean;
		/**
		 *  @private
		 */
		private var _autoRepeat : Boolean;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		local var _emphasized : Boolean;
		/**
		 *  @private
		 */
		private var emphasizedChanged : Boolean;
		/**
		 *  @private
		 */
		private var _label : String;
		/**
		 *  @private
		 */
		private var labelChanged : Boolean;
		/**
		 *  @private
		 */
		local var _labelPlacement : String;
		/**
		 *  @private
		 */
		private var _listData : BaseListData;
		/**
		 *  @private
		 */
		private var _phase : String;
		/**
		 *  @private
		 */
		local var _selected : Boolean;
		/**
		 *  The name of the field in the <code>data</code> property which specifies
		 */
		public var selectedField : String;
		/**
		 *  If <code>false</code>, the Button displays its down skin
		 */
		public var stickyHighlighting : Boolean;
		/**
		 *  @private
		 */
		local var _toggle : Boolean;
		/**
		 *  @private
		 */
		local var toggleChanged : Boolean;

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
		public function set toolTip (value:String) : void;
		/**
		 *  Specifies whether to dispatch repeated <code>buttonDown</code>
		 */
		public function get autoRepeat () : Boolean;
		/**
		 *  @private
		 */
		public function set autoRepeat (value:Boolean) : void;
		/**
		 *  The <code>data</code> property lets you pass a value
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  Draws a thick border around the Button control
		 */
		public function get emphasized () : Boolean;
		/**
		 *  @private
		 */
		public function set emphasized (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  Text to appear on the Button control.
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;
		/**
		 *  Orientation of the label in relation to a specified icon.
		 */
		public function get labelPlacement () : String;
		/**
		 *  @private
		 */
		public function set labelPlacement (value:String) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  @private
		 */
		function get phase () : String;
		/**
		 *  @private
		 */
		function set phase (value:String) : void;
		/**
		 *  Indicates whether a toggle button is toggled
		 */
		public function get selected () : Boolean;
		/**
		 *  @private
		 */
		public function set selected (value:Boolean) : void;
		/**
		 *  Controls whether a Button is in a toggle state or not. 
		 */
		public function get toggle () : Boolean;
		/**
		 *  @private
		 */
		public function set toggle (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function Button ();
		function setSelected (value:Boolean, isProgrammatic:Boolean = false) : void;
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
		protected function commitProperties () : void;
		/**
		 *  @private 
		 */
		private function previousVersion_measure () : void;
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
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function adjustFocusRect (object:DisplayObject = null) : void;
		/**
		 *  @private
		 */
		function viewSkin () : void;
		/**
		 *  @private
		 */
		function viewSkinForPhase (tempSkinName:String, stateName:String) : void;
		/**
		 *  @private
		 */
		function getCurrentIconName () : String;
		/**
		 *  @private
		 */
		function getCurrentIcon () : IFlexDisplayObject;
		/**
		 *  @private
		 */
		function viewIcon () : void;
		/**
		 *  @private
		 */
		function viewIconForPhase (tempIconName:String) : IFlexDisplayObject;
		private function previousVersion_layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private
		 */
		function changeSkins () : void;
		/**
		 *  @private
		 */
		function changeIcons () : void;
		/**
		 *  @private
		 */
		function buttonPressed () : void;
		/**
		 *  @private
		 */
		function buttonReleased () : void;
		/**
		 *  @private
		 */
		function getTextField () : IUITextField;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.ROLL_OVER</code> event.
		 */
		protected function rollOverHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.ROLL_OUT</code> event.
		 */
		protected function rollOutHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.MOUSE_DOWN</code> event.
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.MOUSE_UP</code> event.
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  The default handler for the <code>MouseEvent.CLICK</code> event.
		 */
		protected function clickHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function systemManager_mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function stage_mouseLeaveHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function autoRepeatTimer_timerDelayHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function autoRepeatTimer_timerHandler (event:Event) : void;
	}
}