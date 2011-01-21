﻿package mx.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;

	/**
	 *  Defines a set of values used to fill an area on screen
	 */
	public class BitmapFill implements IFill
	{
		/**
		 *  @private
		 */
		private var bitmapData : BitmapData;
		/**
		 *  @private
		 */
		private var matrix : Matrix;
		/**
		 *  The horizontal origin for the bitmap fill.
		 */
		public var originX : Number;
		/**
		 *  The vertical origin for the bitmap fill.
		 */
		public var originY : Number;
		/**
		 *  How far the bitmap is horizontally offset from the origin.
		 */
		public var offsetX : Number;
		/**
		 *  How far the bitmap is vertically offset from the origin.
		 */
		public var offsetY : Number;
		/**
		 *  Whether the bitmap is repeated to fill the area.
		 */
		public var repeat : Boolean;
		/**
		 *  The number of degrees to rotate the bitmap.
		 */
		public var rotation : Number;
		/**
		 *  The percent to horizontally scale the bitmap when filling,
		 */
		public var scaleX : Number;
		/**
		 *  The percent to vertically scale the bitmap when filling,
		 */
		public var scaleY : Number;
		/**
		 *  A flag indicating whether to smooth the bitmap data
		 */
		public var smooth : Boolean;

		/**
		 *  The source used for the bitmap fill.
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function BitmapFill ();
		/**
		 *  @private
		 */
		public function begin (target:Graphics, rc:Rectangle) : void;
		/**
		 *  @private
		 */
		public function end (target:Graphics) : void;
		/**
		 *  @private
		 */
		private function buildMatrix () : void;
	}
}