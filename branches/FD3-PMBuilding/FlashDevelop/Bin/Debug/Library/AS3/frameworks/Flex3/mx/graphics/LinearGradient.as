﻿package mx.graphics
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import mx.core.mx_internal;

	/**
	 *  The LinearGradient class lets you specify the fill of a graphical element,
	 */
	public class LinearGradient extends GradientBase implements IFill
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
		 *  Controls the transition direction. 
		 */
		public function get angle () : Number;
		/**
		 *  @private
		 */
		public function set angle (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function LinearGradient ();
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