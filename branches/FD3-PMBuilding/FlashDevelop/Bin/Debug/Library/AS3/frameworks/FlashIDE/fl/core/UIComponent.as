﻿package fl.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.system.IMEConversionMode;
	import flash.utils.getQualifiedClassName;
	import fl.core.InvalidationType;
	import fl.events.ComponentEvent;
	import fl.managers.FocusManager;
	import fl.managers.IFocusManager;
	import fl.managers.IFocusManagerComponent;
	import fl.managers.StyleManager;

	/**
	 * Dispatched after the component is moved.
	 */
	[Event(name="move", type="fl.events.ComponentEvent")] 
	/**
	 * Dispatched after the component is resized.
	 */
	[Event(name="resize", type="fl.events.ComponentEvent")] 
	/**
	 * Dispatched after the component visibility changes from invisible to visible.
	 */
	[Event(name="show", type="fl.events.ComponentEvent")] 
	/**
	 * Dispatched after the component visibility changes from visible to invisible.
	 */
	[Event(name="hide", type="fl.events.ComponentEvent")] 
	/**
	 * The skin to be used to display focus indicators.
	 */
	[Style(name="focusRectSkin", type="Class")] 
	/**
	 * The padding that separates the outside boundaries of the component from the
	 */
	[Style(name="focusRectPadding", type="Number", format="Length")] 
	/**
	 *  The TextFormat object to use to render the component label.
	 */
	[Style(name="textFormat", type="flash.text.TextFormat")] 
	/**
	 *  The TextFormat object to use to render the component label when the button is disabled.
	 */
	[Style(name="disabledTextFormat", type="flash.text.TextFormat")] 

	/**
	 *  The UIComponent class is the base class for all visual components,
	 */
	public class UIComponent extends Sprite
	{
		/**
		 * The version number of the components.
		 */
		public var version : String;
		/**
		 * @private (internal)
		 */
		public static var inCallLaterPhase : Boolean;
		/**
		 * @private
		 */
		public var focusTarget : IFocusManagerComponent;
		/**
		 * @private (protected)
		 */
		protected var isLivePreview : Boolean;
		/**
		 * @private (testing)
		 */
		private var tempText : TextField;
		/**
		 * @private (protected)
		 */
		protected var instanceStyles : Object;
		/**
		 * @private (protected)
		 */
		protected var sharedStyles : Object;
		/**
		 * @private (protected)
		 */
		protected var callLaterMethods : Dictionary;
		/**
		 * @private (protected)
		 */
		protected var invalidateFlag : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _enabled : Boolean;
		/**
		 * @private (protected)
		 */
		protected var invalidHash : Object;
		/**
		 * @private (protected)
		 */
		protected var uiFocusRect : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var isFocused : Boolean;
		/**
		 * @private
		 */
		private var _focusEnabled : Boolean;
		/**
		 * @private
		 */
		private var _mouseFocusEnabled : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _width : Number;
		/**
		 * @private (protected)
		 */
		protected var _height : Number;
		/**
		 * @private (protected)
		 */
		protected var _x : Number;
		/**
		 * @private (protected)
		 */
		protected var _y : Number;
		/**
		 * @private (protected)
		 */
		protected var startWidth : Number;
		/**
		 * @private (protected)
		 */
		protected var startHeight : Number;
		/**
		 * @private (protected)
		 */
		protected var _imeMode : String;
		/**
		 * @private (protected)
		 */
		protected var _oldIMEMode : String;
		/**
		 * @private (protected)
		 */
		protected var errorCaught : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _inspector : Boolean;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private
		 */
		private static var focusManagers : Dictionary;
		/**
		 *  @private
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * @private (internal)
		 */
		public function get componentInspectorSetting () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set componentInspectorSetting (value:Boolean) : void;
		/**
		 * Gets or sets a value that indicates whether the component can accept user interaction.
		 */
		public function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets the width of the component, in pixels.
		 */
		public function get width () : Number;
		/**
		 * @private (setter)
		 */
		public function set width (value:Number) : void;
		/**
		 * Gets or sets the height of the component, in pixels.
		 */
		public function get height () : Number;
		/**
		 * @private (setter)
		 */
		public function set height (value:Number) : void;
		/**
		 * Gets or sets the x coordinate that represents the position of the component along
		 */
		public function get x () : Number;
		/**
		 * @private (setter)
		 */
		public function set x (value:Number) : void;
		/**
		 * Gets or sets the y coordinate that represents the position of the component along 
		 */
		public function get y () : Number;
		/**
		 * @private (setter)
		 */
		public function set y (value:Number) : void;
		/**
		 * Multiplies the current width of the component by a scale factor.
		 */
		public function get scaleX () : Number;
		/**
		 * @private (setter)
		 */
		public function set scaleX (value:Number) : void;
		/**
		 * Multiplies the current height of the component by a scale factor.
		 */
		public function get scaleY () : Number;
		/**
		 * @private (setter)
		 */
		public function set scaleY (value:Number) : void;
		/**
		 * Gets or sets a value that indicates whether the current component instance is visible. 
		 */
		public function get visible () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set visible (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the component can receive focus 
		 */
		public function get focusEnabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set focusEnabled (b:Boolean) : void;
		/**
		 * Gets or sets a value that indicates whether the component can receive focus after 
		 */
		public function get mouseFocusEnabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set mouseFocusEnabled (b:Boolean) : void;
		/**
		 * Gets or sets the FocusManager that controls focus for this component and its
		 */
		public function get focusManager () : IFocusManager;
		/**
		 * @private (setter)
		 */
		public function set focusManager (f:IFocusManager) : void;

		/**
		 * Retrieves the default style map for the current component. The style map contains
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Merges the styles from multiple classes into one object. 
		 */
		public static function mergeStyles (...list:Array) : Object;
		/**
		 * Creates a new UIComponent component instance.
		 */
		public function UIComponent ();
		/**
		 * @private (protected)
		 */
		protected function beforeComponentParameters () : void;
		/**
		 * @private (protected)
		 */
		protected function afterComponentParameters () : void;
		/**
		 * Sets the component to the specified width and height.
		 */
		public function setSize (width:Number, height:Number) : void;
		/**
		 * Sets a style property on this component instance. This style may 
		 */
		public function setStyle (style:String, value:Object) : void;
		/**
		 * Deletes a style property from this component instance.
		 */
		public function clearStyle (style:String) : void;
		/**
		 * Retrieves a style property that is set in the style lookup 
		 */
		public function getStyle (style:String) : Object;
		/**
		 * Moves the component to the specified position within its parent. This has
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function getScaleY () : Number;
		/**
		 * @private (protected)
		 */
		protected function setScaleY (value:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function getScaleX () : Number;
		/**
		 * @private (setter)
		 */
		protected function setScaleX (value:Number) : void;
		/**
		 * Validates and updates the properties and layout of this object, redrawing it
		 */
		public function validateNow () : void;
		/**
		 * Marks a property as invalid and redraws the component on the
		 */
		public function invalidate (property:String = InvalidationType.ALL, callLater:Boolean = true) : void;
		/**
		 * @private (internal)
		 */
		public function setSharedStyle (name:String, style:Object) : void;
		/**
		 * Shows or hides the focus indicator on this component.
		 */
		public function drawFocus (focused:Boolean) : void;
		/**
		 * Sets the focus to this component. The component may in turn give the focus
		 */
		public function setFocus () : void;
		/**
		 * Retrieves the object that currently has focus. 
		 */
		public function getFocus () : InteractiveObject;
		/**
		 * @private (protected)
		 */
		protected function setIMEMode (enabled:Boolean);
		/**
		 * Initiates an immediate draw operation, without invalidating everything as <code>invalidateNow</code> does.
		 */
		public function drawNow () : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function checkLivePreview () : Boolean;
		/**
		 * @private (protected)
		 */
		protected function isInvalid (property:String, ...properties:Array) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function validate () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function getDisplayObjectInstance (skin:Object) : DisplayObject;
		/**
		 * Returns the specified style for a component, considering all styles set on the global level, component level and instance level. 
		 */
		protected function getStyleValue (name:String) : Object;
		/**
		 * @private (protected)
		 */
		protected function copyStylesToChild (child:UIComponent, styleMap:Object) : void;
		/**
		 * @private (protected)
		 */
		protected function callLater (fn:Function) : void;
		/**
		 * @private
		 */
		private function callLaterDispatcher (event:Event) : void;
		/**
		 * @private
		 */
		private function initializeFocusManager () : void;
		/**
		 * @private
		 */
		private function addedHandler (evt:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function createFocusManager () : void;
		/**
		 * @private (protected)
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  @private (protected)
		 */
		protected function hookAccessibility (event:Event) : void;
		/**
		 *  @private (protected)
		 */
		protected function initializeAccessibility () : void;
	}
}