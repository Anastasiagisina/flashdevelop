﻿package fl.motion
{
	/**
	 * The AdjustColor class defines various color properties, such as brightness, contrast, hue, and saturation, to support the ColorMatrixFilter class. 
	 */
	public class AdjustColor
	{
		private static var s_arrayOfDeltaIndex : Array;
		private var m_brightnessMatrix : ColorMatrix;
		private var m_contrastMatrix : ColorMatrix;
		private var m_saturationMatrix : ColorMatrix;
		private var m_hueMatrix : ColorMatrix;
		private var m_finalMatrix : ColorMatrix;

		/**
		 * Sets the brightness of the AdjustColor filter. The range of valid values is <code>-100</code> to <code>100</code>.
		 */
		public function set brightness (value:Number) : void;
		/**
		 * Sets the contrast of the AdjustColor filter. The range of valid values is <code>-100</code> to <code>100</code>.
		 */
		public function set contrast (value:Number) : void;
		/**
		 * Sets the saturation of the AdjustColor filter. The range of valid values is <code>-100</code> to <code>100</code>.
		 */
		public function set saturation (value:Number) : void;
		/**
		 * Sets the hue of the AdjustColor filter. The range of valid values is <code>-180</code> to <code>180</code>.
		 */
		public function set hue (value:Number) : void;

		/**
		 * The AdjustColor class defines various color properties to support the ColorMatrixFilter.
		 */
		public function AdjustColor ();
		/**
		 * Verifies if all four AdjustColor properties are set. 
		 */
		public function AllValuesAreSet () : Boolean;
		/**
		 * Returns the flat array of values for all four properties.
		 */
		public function CalculateFinalFlatArray () : Array;
		private function CalculateFinalMatrix () : Boolean;
	}
}