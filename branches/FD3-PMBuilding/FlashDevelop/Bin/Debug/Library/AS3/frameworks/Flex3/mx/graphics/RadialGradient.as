﻿package mx.graphics
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 *  The RadialGradient class lets you specify a gradual color transition 
	 */
	public class RadialGradient extends GradientBase implements IFill
	{
		/**
		 *  @private
		 */
		private var matrix : Matrix;
		/**
		 *  @private
		 */
		private var _rotation : Number;
		/**
		 *  @private
		 */
		private var _focalPointRatio : Number;

		/**
		 *  Sets the location of the start of the radial fill.
		 */
		public function get angle () : Number;
		/**
		 *  @private
		 */
		public function set angle (value:Number) : void;
		/**
		 *  Sets the location of the start of the radial fill.
		 */
		public function get focalPointRatio () : Number;
		/**
		 *  @private
		 */
		public function set focalPointRatio (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function RadialGradient ();
		/**
		 *  @inheritDoc
		 */
		public function begin (target:Graphics, rc:Rectangle) : void;
		/**
		 *  @inheritDoc
		 */
		public function end (target:Graphics) : void;
	}
}