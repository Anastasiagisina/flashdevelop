﻿package mx.skins.halo
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import mx.core.IContainer;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.graphics.RectangularDropShadow;
	import mx.skins.RectangularBorder;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;
	import mx.graphics.GradientEntry;

	/**
	 *  Defines the appearance of the default border for the Halo theme.
	 */
	public class HaloBorder extends RectangularBorder
	{
		/**
		 *  @private
		 */
		private static var BORDER_WIDTHS : Object;
		/**
		 *  @private
		 */
		private var dropShadow : RectangularDropShadow;
		local var backgroundColor : Object;
		local var backgroundAlphaName : String;
		local var backgroundHole : Object;
		local var bRoundedCorners : Boolean;
		local var radius : Number;
		local var radiusObj : Object;
		/**
		 *  @private
		 */
		protected var _borderMetrics : EdgeMetrics;

		/**
		 *  @private
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function HaloBorder ();
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		function drawBorder (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		function draw3dBorder (c1:Number, c2:Number, c3:Number, c4:Number, c5:Number, c6:Number) : void;
		/**
		 *  @private
		 */
		function drawBackground (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		function drawDropShadow (x:Number, y:Number, width:Number, height:Number, tlRadius:Number, trRadius:Number, brRadius:Number, blRadius:Number) : void;
		/**
		 *  @private
		 */
		function getDropShadowAngle (distance:Number, direction:String) : Number;
		/**
		 *  @private
		 */
		function getBackgroundColor () : Object;
		/**
		 *  @private
		 */
		function getBackgroundColorMetrics () : EdgeMetrics;
	}
}