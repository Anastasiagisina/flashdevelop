﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import mx.controls.tabBarClasses.Tab;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ItemClickEvent;

	/**
	 *  Dispatched when a tab navigation item is selected.
	 */
	[Event(name="itemClick", type="mx.events.ItemClickEvent")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the 
	 */
	[Style(name="firstTabStyleName", type="String", inherit="no")] 
	/**
	 * Horizontal alignment of all tabs within the TabBar. Since individual 
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Number of pixels between tab navigation items in the horizontal direction.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the 
	 */
	[Style(name="lastTabStyleName", type="String", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the text
	 */
	[Style(name="selectedTabTextStyleName", type="String", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the tab
	 */
	[Style(name="tabStyleName", type="String", inherit="no")] 
	/**
	 *  Height of each tab navigation item, in pixels.
	 */
	[Style(name="tabHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Width of the tab navigation item, in pixels.
	 */
	[Style(name="tabWidth", type="Number", format="Length", inherit="no")] 
	/**
	 * Vertical alignment of all tabs within the TabBar. Since individual 
	 */
	[Style(name="verticalAlign", type="String", enumeration="top,middle,bottom", inherit="no")] 
	/**
	 *  Number of pixels between tab navigation items in the vertical direction.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  The TabBar control lets you create a horizontal or vertical group of tab navigation 
	 */
	public class TabBar extends ToggleButtonBar
	{
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;

		/**
		 *  Constructor.
		 */
		public function TabBar ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function tab_mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function tab_doubleClickHandler (event:MouseEvent) : void;
	}
}