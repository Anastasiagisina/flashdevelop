﻿package mx.utils
{
	/**
	 *  The ArrayUtil utility class is an all-static class
	 */
	public class ArrayUtil
	{
		/**
		 *  Ensures that an Object can be used as an Array.
		 */
		public static function toArray (obj:Object) : Array;
		/**
		 *  Returns the index of the item in the Array.
		 */
		public static function getItemIndex (item:Object, source:Array) : int;
	}
}