﻿package fl.containers
{
	import fl.core.UIComponent;
	import fl.controls.BaseButton;
	import fl.controls.ScrollBar;
	import fl.events.ScrollEvent;
	import fl.controls.ScrollPolicy;
	import fl.controls.ScrollBarDirection;
	import fl.core.InvalidationType;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	/**
	 * Dispatched when the user scrolls content by using the scroll bars on the
	 */
	[Event(name="scroll", type="fl.events.ScrollEvent")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowDisabledSkin
	 */
	[Style(name="downArrowDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowDownSkin
	 */
	[Style(name="downArrowDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowOverSkin
	 */
	[Style(name="downArrowOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:downArrowUpSkin
	 */
	[Style(name="downArrowUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbDisabledSkin
	 */
	[Style(name="thumbDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbDownSkin
	 */
	[Style(name="thumbDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbOverSkin
	 */
	[Style(name="thumbOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbUpSkin
	 */
	[Style(name="thumbUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackDisabledSkin
	 */
	[Style(name="trackDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackDownSkin
	 */
	[Style(name="trackDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackOverSkin
	 */
	[Style(name="trackOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:trackUpSkin
	 */
	[Style(name="trackUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowDisabledSkin
	 */
	[Style(name="upArrowDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowDownSkin
	 */
	[Style(name="upArrowDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowOverSkin
	 */
	[Style(name="upArrowOverSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:upArrowUpSkin
	 */
	[Style(name="upArrowUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.ScrollBar#style:thumbIcon
	 */
	[Style(name="thumbIcon", type="Class")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatDelay
	 */
	[Style(name="repeatDelay", type="Number", format="Time")] 
	/**
	 * @copy fl.controls.BaseButton#style:repeatInterval
	 */
	[Style(name="repeatInterval", type="Number", format="Time")] 
	/**
	 * The skin to be used as the background of the scroll pane.
	 */
	[Style(name="skin", type="Class")] 
	/**
	 * Padding between the content (the component and scroll bar), and the outside edge of the background, in pixels.
	 */
	[Style(name="contentPadding", type="Number", format="Length")] 
	/**
	 * When the <code>enabled</code> property is set to <code>false</code>, 
	 */
	[Style(name="disabledAlpha", type="Number", format="Length")] 

	/**
	 * The BaseScrollPane class handles basic scroll pane functionality including events, styling, 
	 */
	public class BaseScrollPane extends UIComponent
	{
		/**
		 * @private (protected)
		 */
		protected var _verticalScrollBar : ScrollBar;
		/**
		 * @private (protected)
		 */
		protected var _horizontalScrollBar : ScrollBar;
		/**
		 * @private (protected)
		 */
		protected var contentScrollRect : Rectangle;
		/**
		 * @private (protected)
		 */
		protected var disabledOverlay : Shape;
		/**
		 * @private (protected)
		 */
		protected var background : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var contentWidth : Number;
		/**
		 * @private (protected)
		 */
		protected var contentHeight : Number;
		/**
		 * @private (protected)
		 */
		protected var _horizontalScrollPolicy : String;
		/**
		 * @private (protected)
		 */
		protected var _verticalScrollPolicy : String;
		/**
		 * @private (protected)
		 */
		protected var contentPadding : Number;
		/**
		 * @private (protected)
		 */
		protected var availableWidth : Number;
		/**
		 * @private (protected)
		 */
		protected var availableHeight : Number;
		/**
		 * @private (protected)
		 */
		protected var vOffset : Number;
		/**
		 * @private (protected)
		 */
		protected var vScrollBar : Boolean;
		/**
		 * @private (protected)
		 */
		protected var hScrollBar : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _maxHorizontalScrollPosition : Number;
		/**
		 * @private (protected)
		 */
		protected var _horizontalPageScrollSize : Number;
		/**
		 * @private (protected)
		 */
		protected var _verticalPageScrollSize : Number;
		/**
		 * @private (protected)
		 */
		protected var defaultLineScrollSize : Number;
		/**
		 * @private (protected)
		 */
		protected var useFixedHorizontalScrolling : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _useBitmpScrolling : Boolean;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const SCROLL_BAR_STYLES : Object;

		/**
		 * @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets a value that indicates the state of the horizontal scroll
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 * @private (setter)
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 * Gets or sets a value that indicates the state of the vertical scroll
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 * @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 * Gets or sets a value that describes the amount of content to be scrolled,
		 */
		public function get horizontalLineScrollSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set horizontalLineScrollSize (value:Number) : void;
		/**
		 * Gets or sets a value that describes how many pixels to scroll vertically when a scroll arrow is clicked. 
		 */
		public function get verticalLineScrollSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set verticalLineScrollSize (value:Number) : void;
		/**
		 * Gets or sets a value that describes the horizontal position of the 
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set horizontalScrollPosition (value:Number) : void;
		/**
		 * Gets or sets a value that describes the vertical position of the 
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 * @private (setter)
		 */
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 * Gets the maximum horizontal scroll position for the current content, in pixels.
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 * Gets the maximum vertical scroll position for the current content, in pixels.
		 */
		public function get maxVerticalScrollPosition () : Number;
		/**
		 * When set to <code>true</code>, the <code>cacheAsBitmap</code> property for the scrolling content is set 
		 */
		public function get useBitmapScrolling () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set useBitmapScrolling (value:Boolean) : void;
		/**
		 * Gets or sets the count of pixels by which to move the scroll thumb 
		 */
		public function get horizontalPageScrollSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set horizontalPageScrollSize (value:Number) : void;
		/**
		 * Gets or sets the count of pixels by which to move the scroll thumb 
		 */
		public function get verticalPageScrollSize () : Number;
		/**
		 * @private (setter)
		 */
		public function set verticalPageScrollSize (value:Number) : void;
		/**
		 * Gets a reference to the horizontal scroll bar.
		 */
		public function get horizontalScrollBar () : ScrollBar;
		/**
		 * Gets a reference to the vertical scroll bar.
		 */
		public function get verticalScrollBar () : ScrollBar;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
		/**
		 * @private (protected)
		 */
		protected function setContentSize (width:Number, height:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function handleScroll (event:ScrollEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleWheel (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function setHorizontalScrollPosition (scroll:Number, fireEvent:Boolean = false) : void;
		/**
		 * @private (protected)
		 */
		protected function setVerticalScrollPosition (scroll:Number, fireEvent:Boolean = false) : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBackground () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function drawDisabledOverlay () : void;
		/**
		 * @private (protected)
		 */
		protected function calculateAvailableSize () : void;
		/**
		 * @private (protected)
		 */
		protected function calculateContentWidth () : void;
		/**
		 * @private (protected)
		 */
		protected function updateChildren () : void;
	}
}