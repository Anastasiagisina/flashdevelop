﻿package fl.controls
{
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.LabelButton;
	import fl.controls.RadioButtonGroup;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.managers.IFocusManager;
	import fl.managers.IFocusManagerGroup;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * Dispatched when the radio button instance's <code>selected</code> property changes.
	 */
	[Event(name="change" , type="flash.events.Event")] 
	/**
	 * Dispatched when the user clicks the radio button with the mouse or spacebar.
	 */
	[Event(name="click" , type="flash.events.MouseEvent")] 
	/**
	 * @copy fl.controls.LabelButton#style:icon
	 */
	[Style(name="icon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:upIcon
	 */
	[Style(name="upIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:downIcon
	 */
	[Style(name="downIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:overIcon
	 */
	[Style(name="overIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:disabledIcon
	 */
	[Style(name="disabledIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedDisabledIcon
	 */
	[Style(name="selectedDisabledIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedUpIcon
	 */
	[Style(name="selectedUpIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedDownIcon
	 */
	[Style(name="selectedDownIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedOverIcon
	 */
	[Style(name="selectedOverIcon", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:textPadding
	 */
	[Style(name="textPadding", type="Number", format="Length")] 

	/**
	 * The RadioButton component lets you force a user to make a single
	 */
	public class RadioButton extends LabelButton implements IFocusManagerGroup
	{
		/**
		 * @private (protected)
		 */
		protected var _value : Object;
		/**
		 * @private (protected)
		 */
		protected var _group : RadioButtonGroup;
		/**
		 * @private (protected)
		 */
		protected var defaultGroupName : String;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private
		 */
		public static var createAccessibilityImplementation : Function;

		/**
		 * A radio button is a toggle button; its <code>toggle</code> property is set to
		 */
		public function get toggle () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 * A radio button never auto-repeats by definition, so the <code>autoRepeat</code> property is set to
		 */
		public function get autoRepeat () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set autoRepeat (value:Boolean) : void;
		/**
		 * Indicates whether a radio button is currently selected (<code>true</code>) or deselected (<code>false</code>).
		 */
		public function get selected () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set selected (value:Boolean) : void;
		/**
		 * The group name for a radio button instance or group. You can use this property to get 
		 */
		public function get groupName () : String;
		/**
		 * @private (setter)
		 */
		public function set groupName (group:String) : void;
		/**
		 * The RadioButtonGroup object to which this RadioButton belongs.
		 */
		public function get group () : RadioButtonGroup;
		/**
		 * @private (setter)
		 */
		public function set group (name:RadioButtonGroup) : void;
		/**
		 * A user-defined value that is associated with a radio button.
		 */
		public function get value () : Object;
		/**
		 * @private (setter)
		 */
		public function set value (val:Object) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new RadioButton component instance.
		 */
		public function RadioButton ();
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * Shows or hides the focus indicator around this component instance.
		 */
		public function drawFocus (focused:Boolean) : void;
		/**
		 * @private (protected)
		 */
		protected function handleChange (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function handleClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBackground () : void;
		/**
		 * @private (protected)
		 */
		protected function initializeAccessibility () : void;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 * @private
		 */
		private function setPrev (moveSelection:Boolean = true) : void;
		/**
		 * @private
		 */
		private function setNext (moveSelection:Boolean = true) : void;
		/**
		 * @private
		 */
		private function setThis () : void;
	}
}