﻿package mx.validators
{
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

	/**
	 *  The NumberValidator class ensures that a String represents a valid number.
	 */
	public class NumberValidator extends Validator
	{
		/**
		 *  @private
		 */
		private var _allowNegative : Object;
		/**
		 *  @private
		 */
		private var allowNegativeOverride : Object;
		/**
		 *  @private
		 */
		private var _decimalSeparator : String;
		/**
		 *  @private
		 */
		private var decimalSeparatorOverride : String;
		/**
		 *  @private
		 */
		private var _domain : String;
		/**
		 *  @private
		 */
		private var domainOverride : String;
		/**
		 *  @private
		 */
		private var _maxValue : Object;
		/**
		 *  @private
		 */
		private var maxValueOverride : Object;
		/**
		 *  @private
		 */
		private var _minValue : Object;
		/**
		 *  @private
		 */
		private var minValueOverride : Object;
		/**
		 *  @private
		 */
		private var _precision : Object;
		/**
		 *  @private
		 */
		private var precisionOverride : Object;
		/**
		 *  @private
		 */
		private var _thousandsSeparator : String;
		/**
		 *  @private
		 */
		private var thousandsSeparatorOverride : String;
		/**
		 *  @private
		 */
		private var _decimalPointCountError : String;
		/**
		 *  @private
		 */
		private var decimalPointCountErrorOverride : String;
		/**
		 *  @private
		 */
		private var _exceedsMaxError : String;
		/**
		 *  @private
		 */
		private var exceedsMaxErrorOverride : String;
		/**
		 *  @private
		 */
		private var _integerError : String;
		/**
		 *  @private
		 */
		private var integerErrorOverride : String;
		/**
		 *  @private
		 */
		private var _invalidCharError : String;
		/**
		 *  @private
		 */
		private var invalidCharErrorOverride : String;
		/**
		 *  @private
		 */
		private var _invalidFormatCharsError : String;
		/**
		 *  @private
		 */
		private var invalidFormatCharsErrorOverride : String;
		/**
		 *  @private
		 */
		private var _lowerThanMinError : String;
		/**
		 *  @private
		 */
		private var lowerThanMinErrorOverride : String;
		/**
		 *  @private
		 */
		private var _negativeError : String;
		/**
		 *  @private
		 */
		private var negativeErrorOverride : String;
		/**
		 *  @private
		 */
		private var _precisionError : String;
		/**
		 *  @private
		 */
		private var precisionErrorOverride : String;
		/**
		 *  @private
		 */
		private var _separationError : String;
		/**
		 *  @private
		 */
		private var separationErrorOverride : String;

		/**
		 *  Specifies whether negative numbers are permitted.
		 */
		public function get allowNegative () : Object;
		/**
		 *  @private
		 */
		public function set allowNegative (value:Object) : void;
		/**
		 *  The character used to separate the whole
		 */
		public function get decimalSeparator () : String;
		/**
		 *  @private
		 */
		public function set decimalSeparator (value:String) : void;
		/**
		 *  Type of number to be validated.
		 */
		public function get domain () : String;
		/**
		 *  @private
		 */
		public function set domain (value:String) : void;
		/**
		 *  Maximum value for a valid number. A value of NaN means there is no maximum.
		 */
		public function get maxValue () : Object;
		/**
		 *  @private
		 */
		public function set maxValue (value:Object) : void;
		/**
		 *  Minimum value for a valid number. A value of NaN means there is no minimum.
		 */
		public function get minValue () : Object;
		/**
		 *  @private
		 */
		public function set minValue (value:Object) : void;
		/**
		 *  The maximum number of digits allowed to follow the decimal point.
		 */
		public function get precision () : Object;
		/**
		 *  @private
		 */
		public function set precision (value:Object) : void;
		/**
		 *  The character used to separate thousands
		 */
		public function get thousandsSeparator () : String;
		/**
		 *  @private
		 */
		public function set thousandsSeparator (value:String) : void;
		/**
		 *  Error message when the decimal separator character occurs more than once.
		 */
		public function get decimalPointCountError () : String;
		/**
		 *  @private
		 */
		public function set decimalPointCountError (value:String) : void;
		/**
		 *  Error message when the value exceeds the <code>maxValue</code> property.
		 */
		public function get exceedsMaxError () : String;
		/**
		 *  @private
		 */
		public function set exceedsMaxError (value:String) : void;
		/**
		 *  Error message when the number must be an integer, as defined 
		 */
		public function get integerError () : String;
		/**
		 *  @private
		 */
		public function set integerError (value:String) : void;
		/**
		 *  Error message when the value contains invalid characters.
		 */
		public function get invalidCharError () : String;
		/**
		 *  @private
		 */
		public function set invalidCharError (value:String) : void;
		/**
		 *  Error message when the value contains invalid format characters, which means that 
		 */
		public function get invalidFormatCharsError () : String;
		/**
		 *  @private
		 */
		public function set invalidFormatCharsError (value:String) : void;
		/**
		 *  Error message when the value is less than <code>minValue</code>.
		 */
		public function get lowerThanMinError () : String;
		/**
		 *  @private
		 */
		public function set lowerThanMinError (value:String) : void;
		/**
		 *  Error message when the value is negative and the 
		 */
		public function get negativeError () : String;
		/**
		 *  @private
		 */
		public function set negativeError (value:String) : void;
		/**
		 *  Error message when the value has a precision that exceeds the value defined 
		 */
		public function get precisionError () : String;
		/**
		 *  @private
		 */
		public function set precisionError (value:String) : void;
		/**
		 *  Error message when the thousands separator is in the wrong location.
		 */
		public function get separationError () : String;
		/**
		 *  @private
		 */
		public function set separationError (value:String) : void;

		/**
		 *  Convenience method for calling a validator
		 */
		public static function validateNumber (validator:NumberValidator, value:Object, baseField:String) : Array;
		/**
		 *  Constructor.
		 */
		public function NumberValidator ();
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Override of the base class <code>doValidation()</code> method 
		 */
		protected function doValidation (value:Object) : Array;
	}
}