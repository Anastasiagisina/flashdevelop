﻿package mx.utils
{
	/**
	 *  The ColorUtil class is an all-static class
	 */
	public class ColorUtil
	{
		/**
		 *  Performs a linear brightness adjustment of an RGB color.
		 */
		public static function adjustBrightness (rgb:uint, brite:Number) : uint;
		/**
		 *  Performs a scaled brightness adjustment of an RGB color.
		 */
		public static function adjustBrightness2 (rgb:uint, brite:Number) : uint;
		/**
		 *  Performs an RGB multiplication of two RGB colors.
		 */
		public static function rgbMultiply (rgb1:uint, rgb2:uint) : uint;
	}
}