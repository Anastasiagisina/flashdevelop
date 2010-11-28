﻿package mx.effects
{
	import mx.effects.effectClasses.FadeInstance;

	/**
	 *  The Fade effect animates the <code>alpha</code> property of a component,
	 */
	public class Fade extends TweenEffect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  Initial transparency level between 0.0 and 1.0, 
		 */
		public var alphaFrom : Number;
		/**
		 *  Final transparency level,
		 */
		public var alphaTo : Number;

		/**
		 *  Constructor.
		 */
		public function Fade (target:Object = null);
		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}