﻿package mx.formatters
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The PhoneFormatter class formats a valid number into a phone number format,
	 */
	public class PhoneFormatter extends Formatter
	{
		/**
		 *  @private
		 */
		private var _areaCode : Object;
		/**
		 *  @private
		 */
		private var areaCodeOverride : Object;
		/**
		 *  @private
		 */
		private var _areaCodeFormat : String;
		/**
		 *  @private
		 */
		private var areaCodeFormatOverride : String;
		/**
		 *  @private
		 */
		private var _formatString : String;
		/**
		 *  @private
		 */
		private var formatStringOverride : String;
		/**
		 *  @private
		 */
		private var _validPatternChars : String;
		/**
		 *  @private
		 */
		private var validPatternCharsOverride : String;

		/**
		 *  Area code number added to a seven-digit United States
		 */
		public function get areaCode () : Object;
		/**
		 *  @private
		 */
		public function set areaCode (value:Object) : void;
		/**
		 *  Default format for the area code when the <code>areacode</code>
		 */
		public function get areaCodeFormat () : String;
		/**
		 *  @private
		 */
		public function set areaCodeFormat (value:String) : void;
		/**
		 *  String that contains mask characters
		 */
		public function get formatString () : String;
		/**
		 *  @private
		 */
		public function set formatString (value:String) : void;
		/**
		 *  List of valid characters that can be used
		 */
		public function get validPatternChars () : String;
		/**
		 *  @private
		 */
		public function set validPatternChars (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function PhoneFormatter ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Formats the String as a phone number.
		 */
		public function format (value:Object) : String;
	}
}