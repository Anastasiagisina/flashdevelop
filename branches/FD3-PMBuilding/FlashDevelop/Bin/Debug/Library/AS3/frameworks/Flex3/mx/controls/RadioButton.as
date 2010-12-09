﻿package mx.controls
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.core.FlexVersion;
	import mx.events.ItemClickEvent;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerGroup;

	/**
	 *  The RadioButton control lets the user make a single choice
	 */
	public class RadioButton extends Button implements IFocusManagerGroup
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		local var indexNumber : int;
		/**
		 *  @private
		 */
		private var _group : RadioButtonGroup;
		/**
		 *  @private
		 */
		local var _groupName : String;
		/**
		 *  @private
		 */
		private var groupChanged : Boolean;
		/**
		 *  @private
		 */
		private var _value : Object;

		/**
		 *  @private
		 */
		public function get emphasized () : Boolean;
		/**
		 *  Position of the label relative to the RadioButton icon.
		 */
		public function get labelPlacement () : String;
		/**
		 *  @private
		 */
		public function get toggle () : Boolean;
		/**
		 *  @private
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 *  The RadioButtonGroup object to which this RadioButton belongs.
		 */
		public function get group () : RadioButtonGroup;
		/**
		 *  @private
		 */
		public function set group (value:RadioButtonGroup) : void;
		/**
		 *  Specifies the name of the group to which this RadioButton control belongs, or 
		 */
		public function get groupName () : String;
		/**
		 *  @private
		 */
		public function set groupName (value:String) : void;
		/**
		 *  Optional user-defined value
		 */
		public function get value () : Object;
		/**
		 *  @private
		 */
		public function set value (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function RadioButton ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
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
		private function addToGroup () : Object;
		/**
		 *  @private
		 */
		function deleteGroup () : void;
		/**
		 *  @private
		 */
		private function setPrev (moveSelection:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function setNext (moveSelection:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function setThis () : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function addHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}