﻿package mx.graphics
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.events.PropertyChangeEvent;

	/**
	 *  The GradientEntry class defines the objects
	 */
	public class GradientEntry extends EventDispatcher
	{
		private var _alpha : Number;
		private var _color : uint;
		private var _ratio : Number;

		/**
		 *  The transparency of a gradient fill.
		 */
		public function get alpha () : Number;
		public function set alpha (value:Number) : void;
		/**
		 *  The color value for a gradient fill.
		 */
		public function get color () : uint;
		public function set color (value:uint) : void;
		/**
		 *  Where in the graphical element, as a percentage from 0.0 to 1.0,
		 */
		public function get ratio () : Number;
		public function set ratio (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function GradientEntry (color:uint = 0x000000, ratio:Number = -1.0, alpha:Number = 1.0);
		/**
		 *  @private
		 */
		private function dispatchEntryChangedEvent (prop:String, oldValue:*, value:*) : void;
	}
}