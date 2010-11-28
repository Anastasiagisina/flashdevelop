﻿package mx.accessibility
{
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import mx.collections.ICollectionView;
	import mx.collections.CursorBookmark;
	import mx.collections.IViewCursor;
	import mx.controls.Tree;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.treeClasses.HierarchicalCollectionView;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.TreeEvent;

	/**
	 *  The TreeAccImpl class is the accessibility class for Tree.
	 */
	public class TreeAccImpl extends AccImpl
	{
		/**
		 *  @private
		 */
		private static var accessibilityHooked : Boolean;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_OUTLINEITEM : uint = 0x24;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_COLLAPSED : uint = 0x00000400;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_EXPANDED : uint = 0x00000200;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_INVISIBLE : uint = 0x00008000;
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
		private static const EVENT_OBJECT_FOCUS : uint = 0x8005;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_STATECHANGE : uint = 0x800A;

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
		public function TreeAccImpl (master:UIComponent);
		/**
		 *  @private
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accValue (childID:uint) : String;
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
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private
		 */
		public function get_accFocus () : uint;
		/**
		 *  @private
		 */
		protected function getName (childID:uint) : String;
		private function getItemAt (index:int) : Object;
		/**
		 *  @private
		 */
		private function getMOfN (item:Object) : String;
		/**
		 *  @private
		 */
		protected function eventHandler (event:Event) : void;
	}
}