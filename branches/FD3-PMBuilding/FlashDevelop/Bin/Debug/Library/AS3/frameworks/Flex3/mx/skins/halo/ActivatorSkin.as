﻿package mx.skins.halo
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.filters.BlurFilter;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import mx.core.ApplicationGlobals;
	import mx.skins.Border;
	import mx.styles.IStyleClient;
	import mx.utils.ColorUtil;

	/**
	 *  Defines the up, down, and over states for MenuBarItem objects.
	 */
	public class ActivatorSkin extends Border
	{
		/**
		 *  @private
		 */
		private static var cache : Object;
		/**
		 *  We don't use 'is' to prevent dependency issues
		 */
		private static var acbs : Object;

		/**
		 *  @private
		 */
		private static function calcDerivedStyles (themeColor:uint, fillColor0:uint, fillColor1:uint) : Object;
		/**
		 *  Constructor.
		 */
		public function ActivatorSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		private function drawHaloRect (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		private function drawTranslucentHaloRect (w:Number, h:Number) : void;
		private static function isApplicationControlBar (parent:Object) : Boolean;
	}
}