﻿package mx.skins.halo
{
	import flash.display.GradientType;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import mx.containers.BoxDirection;
	import mx.core.IButton;
	import mx.core.UIComponent;
	import mx.skins.Border;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;

	/**
	 *  The skin for all the states of the ButtonBarButtons in a ButtonBar.
	 */
	public class ButtonBarButtonSkin extends Border
	{
		/**
		 *  @private
		 */
		private static var cache : Object;
		/**
		 *  We don't use 'is' to prevent dependency issues
		 */
		private static var bbars : Object;

		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  @private
		 */
		private static function calcDerivedStyles (themeColor:uint, fillColor0:uint, fillColor1:uint) : Object;
		/**
		 *  Constructor.
		 */
		public function ButtonBarButtonSkin ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
		/**
		 *  @private
		 */
		private function getCornerRadius (pos:int, horizontal:Boolean, radius:Number) : Object;
		private static function isButtonBar (parent:Object) : Boolean;
	}
}