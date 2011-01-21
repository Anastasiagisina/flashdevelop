﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The CalendarLayoutChangeEvent class represents the event object passed to 
	 */
	public class CalendarLayoutChangeEvent extends Event
	{
		/**
		 *  The <code>CalendarLayoutChangeEvent.CHANGE</code> constant 
		 */
		public static const CHANGE : String = "change";
		/**
		 *  The selected date of the control.
		 */
		public var newDate : Date;
		/**
		 *  The event that triggered the change of the date;
		 */
		public var triggerEvent : Event;

		/**
		 *  Constructor.
		 */
		public function CalendarLayoutChangeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, newDate:Date = null, triggerEvent:Event = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}