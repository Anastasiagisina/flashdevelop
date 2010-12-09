﻿package mx.containers
{
	import flash.events.Event;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

	/**
	 *  Horizontal alignment of each child inside its tile cell.
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Number of pixels between children in the horizontal direction.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's bottom border and its content area.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border and its content area.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Vertical alignment of each child inside its tile cell.
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 
	/**
	 *  Number of pixels between children in the vertical direction.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  A Tile container lays out its children
	 */
	public class Tile extends Container
	{
		/**
		 *  @private
		 */
		local var cellWidth : Number;
		/**
		 *  @private
		 */
		local var cellHeight : Number;
		/**
		 *  @private
		 */
		private var _direction : String;
		/**
		 *  @private
		 */
		private var _tileHeight : Number;
		/**
		 *  @private
		 */
		private var _tileWidth : Number;

		/**
		 *  Determines how children are placed in the container.
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;
		/**
		 *  Height of each tile cell, in pixels. 
		 */
		public function get tileHeight () : Number;
		/**
		 *  @private
		 */
		public function set tileHeight (value:Number) : void;
		/**
		 *  Width of each tile cell, in pixels.
		 */
		public function get tileWidth () : Number;
		/**
		 *  @private
		 */
		public function set tileWidth (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function Tile ();
		/**
		 *  Calculates the default minimum and maximum sizes of the
		 */
		protected function measure () : void;
		/**
		 *  Sets the positions and sizes of this container's children.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function findCellSize () : void;
		/**
		 *  @private
		 */
		private function setChildSize (child:IUIComponent) : void;
		/**
		 *  @private
		 */
		function calcHorizontalOffset (width:Number, horizontalAlign:String) : Number;
		/**
		 *  @private
		 */
		function calcVerticalOffset (height:Number, verticalAlign:String) : Number;
	}
}