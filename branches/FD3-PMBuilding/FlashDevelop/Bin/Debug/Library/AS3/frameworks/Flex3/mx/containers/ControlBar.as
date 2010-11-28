﻿package mx.containers
{
	import mx.core.Container;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.styles.IStyleClient;

	/**
	 *  The ControlBar container lets you place controls
	 */
	public class ControlBar extends Box
	{
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function ControlBar ();
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}