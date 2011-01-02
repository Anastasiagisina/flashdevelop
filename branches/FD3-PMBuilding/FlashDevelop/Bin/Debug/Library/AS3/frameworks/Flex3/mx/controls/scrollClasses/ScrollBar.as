﻿package mx.controls.scrollClasses
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import mx.controls.Button;
	import mx.core.FlexVersion;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.managers.ISystemManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  Name of the class to use as the default skin for the down arrow button of 
	 */
	[Style(name="downArrowSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of the 
	 */
	[Style(name="downArrowDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of the 
	 */
	[Style(name="downArrowDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of the 
	 */
	[Style(name="downArrowOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the down arrow button of 
	 */
	[Style(name="downArrowUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the down arrow button of 
	 */
	[Style(name="thumbSkin", type="Class", inherit="no", states="up, over, down")] 
	/**
	 *  Name of the class to use as the skin for the thumb of the scroll bar 
	 */
	[Style(name="thumbDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the icon for the thumb of the scroll bar. 
	 */
	[Style(name="thumbIcon", type="Class", inherit="no")] 
	/**
	 *  The number of pixels to offset the scroll thumb from the center of the scroll bar. 
	 */
	[Style(name="thumbOffset", type="Number", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the thumb of the scroll bar 
	 */
	[Style(name="thumbOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the thumb of the scroll bar.
	 */
	[Style(name="thumbUpSkin", type="Class", inherit="no")] 
	/**
	 *  The colors of the track, as an array of two colors.
	 */
	[Style(name="trackColors", type="Array", arrayType="uint", format="Color", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the track of the scroll bar. 
	 */
	[Style(name="trackSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar 
	 */
	[Style(name="trackDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar 
	 */
	[Style(name="trackDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar 
	 */
	[Style(name="trackOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the track of the scroll bar.
	 */
	[Style(name="trackUpSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the default skin for the up arrow button of the scroll bar. 
	 */
	[Style(name="upArrowSkin", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the scroll bar 
	 */
	[Style(name="upArrowDisabledSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the scroll bar 
	 */
	[Style(name="upArrowDownSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the scroll bar 
	 */
	[Style(name="upArrowOverSkin", type="Class", inherit="no")] 
	/**
	 *  Name of the class to use as the skin for the up arrow button of the 
	 */
	[Style(name="upArrowUpSkin", type="Class", inherit="no")] 

	/**
	 *  The ScrollBar class is the base class for the HScrollBar and VScrollBar
	 */
	public class ScrollBar extends UIComponent
	{
		/**
		 *  The width of a vertical scrollbar, or the height of a horizontal
		 */
		public static const THICKNESS : Number = 16;
		/**
		 *  @private
		 */
		local var upArrow : Button;
		/**
		 *  @private
		 */
		local var downArrow : Button;
		/**
		 *  @private
		 */
		local var scrollTrack : Button;
		/**
		 *  @private
		 */
		local var scrollThumb : ScrollThumb;
		/**
		 *  @private
		 */
		local var _minWidth : Number;
		/**
		 *  @private
		 */
		local var _minHeight : Number;
		/**
		 *  @private
		 */
		local var isScrolling : Boolean;
		/**
		 *  @private
		 */
		private var trackScrollTimer : Timer;
		/**
		 *  @private
		 */
		private var trackScrollRepeatDirection : int;
		/**
		 *  @private
		 */
		private var trackScrolling : Boolean;
		/**
		 *  @private
		 */
		private var trackPosition : Number;
		/**
		 *  @private
		 */
		local var oldPosition : Number;
		/**
		 *  @private
		 */
		private var _direction : String;
		/**
		 *  @private
		 */
		private var _lineScrollSize : Number;
		/**
		 *  @private
		 */
		private var _maxScrollPosition : Number;
		/**
		 *  @private
		 */
		private var _minScrollPosition : Number;
		/**
		 *  @private
		 */
		private var _pageSize : Number;
		/**
		 *  @private
		 */
		private var _pageScrollSize : Number;
		/**
		 *  @private
		 */
		private var _scrollPosition : Number;

		/**
		 *  @private
		 */
		public function set doubleClickEnabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  Specifies whether the ScrollBar is for horizontal or vertical scrolling.
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  Set of styles to pass from the ScrollBar to the down arrow.
		 */
		protected function get downArrowStyleFilters () : Object;
		/**
		 *  @private
		 */
		function get lineMinusDetail () : String;
		/**
		 *  @private
		 */
		function get linePlusDetail () : String;
		/**
		 *  Amount to scroll when an arrow button is pressed, in pixels.
		 */
		public function get lineScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set lineScrollSize (value:Number) : void;
		/**
		 *  @private
		 */
		private function get maxDetail () : String;
		/**
		 *  Number which represents the maximum scroll position.
		 */
		public function get maxScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set maxScrollPosition (value:Number) : void;
		/**
		 *  @private
		 */
		private function get minDetail () : String;
		/**
		 *  Number that represents the minimum scroll position.
		 */
		public function get minScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set minScrollPosition (value:Number) : void;
		/**
		 *  @private
		 */
		function get pageMinusDetail () : String;
		/**
		 *  @private
		 */
		function get pagePlusDetail () : String;
		/**
		 *  The number of lines equivalent to one page.
		 */
		public function get pageSize () : Number;
		/**
		 *  @private
		 */
		public function set pageSize (value:Number) : void;
		/**
		 *  Amount to move the scroll thumb when the scroll bar 
		 */
		public function get pageScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set pageScrollSize (value:Number) : void;
		/**
		 *  Number that represents the current scroll position.
		 */
		public function get scrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set scrollPosition (value:Number) : void;
		/**
		 *  Set of styles to pass from the ScrollBar to the thumb.
		 */
		protected function get thumbStyleFilters () : Object;
		/**
		 *  @private
		 */
		private function get trackHeight () : Number;
		/**
		 *  @private
		 */
		private function get trackY () : Number;
		/**
		 *  Set of styles to pass from the ScrollBar to the up arrow.
		 */
		protected function get upArrowStyleFilters () : Object;
		/**
		 *  @private
		 */
		function get virtualHeight () : Number;
		/**
		 *  @private
		 */
		function get virtualWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function ScrollBar ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Sets the range and viewport size of the ScrollBar control. 
		 */
		public function setScrollProperties (pageSize:Number, minScrollPosition:Number, maxScrollPosition:Number, pageScrollSize:Number = 0) : void;
		/**
		 *  @private
		 */
		function lineScroll (direction:int) : void;
		/**
		 *  @private
		 */
		function pageScroll (direction:int) : void;
		/**
		 *  @private
		 */
		function dispatchScrollEvent (oldPosition:Number, detail:String) : void;
		/**
		 *  @private
		 */
		function isScrollBarKey (key:uint) : Boolean;
		/**
		 *  @private
		 */
		private function upArrow_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function downArrow_buttonDownHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function scrollTrack_mouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function scrollTrack_mouseOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function scrollTrack_mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function trackScrollTimerHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function scrollTrack_mouseUpHandler (event:MouseEvent) : void;
		private function scrollTrack_mouseLeaveHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function scrollTrack_mouseMoveHandler (event:MouseEvent) : void;
	}
}