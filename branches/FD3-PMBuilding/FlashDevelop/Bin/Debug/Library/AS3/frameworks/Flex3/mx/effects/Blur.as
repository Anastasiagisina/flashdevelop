﻿package mx.effects
{
	import mx.effects.effectClasses.BlurInstance;

	/**
	 *  The Blur effect lets you apply a blur visual effect to a component. 
	 */
	public class Blur extends TweenEffect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  The starting amount of horizontal blur.
		 */
		public var blurXFrom : Number;
		/**
		 *  The ending amount of horizontal blur.
		 */
		public var blurXTo : Number;
		/**
		 *  The starting amount of vertical blur.
		 */
		public var blurYFrom : Number;
		/**
		 *  The ending amount of vertical blur.
		 */
		public var blurYTo : Number;

		/**
		 *  Constructor.
		 */
		public function Blur (target:Object = null);
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