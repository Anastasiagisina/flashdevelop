﻿package mx.controls.buttonBarClasses
{
	import mx.controls.Button;
	import mx.core.UITextFormat;
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class ButtonBarButton extends Button
	{
		/**
		 *  @private
		 */
		private var inLayoutContents : Boolean;

		/**
		 *  Constructor.
		 */
		public function ButtonBarButton ();
		/**
		 *  @private
		 */
		public function determineTextFormatFromStyles () : UITextFormat;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
	}
}