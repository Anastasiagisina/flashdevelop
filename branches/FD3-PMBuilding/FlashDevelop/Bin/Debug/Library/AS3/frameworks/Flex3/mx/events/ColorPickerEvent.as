﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  Represents events that are specific to the ColorPicker control,
	 */
	public class ColorPickerEvent extends Event
	{
		/**
		 *  The <code>ColorPickerEvent.CHANGE</code> constant defines the value of the
		 */
		public static const CHANGE : String = "change";
		/**
		 *  The <code>ColorPickerEvent.ENTER</code> constant defines the value of the
		 */
		public static const ENTER : String = "enter";
		/**
		 *  The <code>ColorPickerEvent.ITEM_ROLL_OUT</code> constant defines the value of the
		 */
		public static const ITEM_ROLL_OUT : String = "itemRollOut";
		/**
		 *  The <code>ColorPickerEvent.ITEM_ROLL_OVER</code> constant defines the value of the
		 */
		public static const ITEM_ROLL_OVER : String = "itemRollOver";
		/**
		 *  The RGB color that was rolled over, rolled out of, selected, or
		 */
		public var color : uint;
		/**
		 *  The zero-based index in the Color's data provider that corresponds
		 */
		public var index : int;

		/**
		 *  Constructor.
		 */
		public function ColorPickerEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, index:int = -1, color:uint = 0xFFFFFFFF);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}