﻿package mx.validators
{
	/**
	 *  The RegExpValidator class dispatches the <code>valid</code>
	 */
	public class RegExpValidationResult extends ValidationResult
	{
		/**
		 *  An integer that contains the starting index
		 */
		public var matchedIndex : int;
		/**
		 *  A String that contains the substring of the input String
		 */
		public var matchedString : String;
		/**
		 *  An Array of Strings that contains parenthesized
		 */
		public var matchedSubstrings : Array;

		/**
		 *  Constructor
		 */
		public function RegExpValidationResult (isError:Boolean, subField:String = "", errorCode:String = "", errorMessage:String = "", matchedString:String = "", matchedIndex:int = 0, matchedSubstrings:Array = null);
	}
}