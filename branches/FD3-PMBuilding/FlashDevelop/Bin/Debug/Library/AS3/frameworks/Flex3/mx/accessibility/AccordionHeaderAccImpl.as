﻿package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.containers.Accordion;
	import mx.containers.accordionClasses.AccordionHeader;
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The AccordionHeaderAccImpl is the class
	 */
	public class AccordionHeaderAccImpl extends AccImpl
	{
		/**
		 *  @private
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTABLE : uint = 0x00200000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTED : uint = 0x00000002;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_UNAVAILABLE : uint = 0x00000001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_FOCUS : uint = 0x8005;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;
		/**
		 *  @private
		 */
		private static const MAX_NUM : uint = 100000;

		/**
		 *  @private
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Constructor.
		 */
		public function AccordionHeaderAccImpl (master:UIComponent);
		/**
		 *  @private
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private
		 */
		protected function eventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		protected function removedHandler (event:Event) : void;
	}
}