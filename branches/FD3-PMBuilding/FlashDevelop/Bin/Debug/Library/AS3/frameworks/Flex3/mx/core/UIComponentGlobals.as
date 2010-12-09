﻿package mx.core
{
	import flash.display.InteractiveObject;
	import flash.geom.Matrix;
	import mx.managers.ILayoutManager;

	public class UIComponentGlobals
	{
		/**
		 *  @private
		 */
		static var layoutManager : ILayoutManager;
		/**
		 *  @private
		 */
		static var callLaterSuspendCount : int;
		/**
		 *  @private
		 */
		static var callLaterDispatcherCount : int;
		/**
		 *  @private
		 */
		static var nextFocusObject : InteractiveObject;
		/**
		 *  @private
		 */
		static var tempMatrix : Matrix;
		/**
		 *  @private
		 */
		static var designTime : Boolean;
		/**
		 *  @private
		 */
		private static var _catchCallLaterExceptions : Boolean;

		/**
		 *  A global flag that can be read by any component to determine
		 */
		public static function get designMode () : Boolean;
		/**
		 *  @private
		 */
		public static function set designMode (value:Boolean) : void;
		/**
		 *  A global flag that can is used to catch unhandled exceptions
		 */
		public static function get catchCallLaterExceptions () : Boolean;
		/**
		 *  @private
		 */
		public static function set catchCallLaterExceptions (value:Boolean) : void;

	}
}