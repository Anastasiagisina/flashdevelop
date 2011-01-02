﻿package mx.effects.effectClasses
{
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;

	/**
	 *  The ActionEffectInstance class is the superclass for all 
	 */
	public class ActionEffectInstance extends EffectInstance
	{
		/**
		 *  Indicates whether the effect has been played (<code>true</code>), 
		 */
		protected var playedAction : Boolean;
		/**
		 *  @private
		 */
		private var _startValue : *;

		/**
		 *  Constructor.
		 */
		public function ActionEffectInstance (target:Object);
		/**
		 *  Subclasses implement this method to save the starting state
		 */
		protected function saveStartValue () : *;
		/**
		 *  Returns the starting state value that was saved by the
		 */
		protected function getStartValue () : *;
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function end () : void;
	}
}