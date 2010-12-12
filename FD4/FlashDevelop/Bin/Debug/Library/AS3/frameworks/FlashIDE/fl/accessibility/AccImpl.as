﻿package fl.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.events.Event;
	import fl.core.UIComponent;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 *  The AccImpl class, also called the Accessibility Implementation class, is the base class 
	 */
	public class AccImpl extends AccessibilityImplementation
	{
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_NORMAL : uint = 0x00000000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSABLE : uint = 0x00100000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_UNAVAILABLE : uint = 0x00000001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_NAMECHANGE : uint = 0x800C;
		/**
		 *  @private (protected)
		 */
		protected var master : UIComponent;
		/**
		 *  @private (protected)
		 */
		protected var role : uint;

		/**
		 *  @private (protected)
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private
		 */
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 * Enables accessibility for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 * @private
		 */
		public function AccImpl (component:UIComponent);
		/**
		 *  @private
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accName (childID:uint) : String;
		/**
		 *  @private (protected)
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private (protected)
		 */
		protected function getState (childID:uint) : uint;
		/**
		 *  @private
		 */
		private function getStatusName () : String;
		/**
		 *  @private (protected)
		 */
		protected function eventHandler (event:Event) : void;
	}
}