﻿package mx.effects
{
	import mx.effects.effectClasses.PauseInstance;

	/**
	 *  The Pause effect is useful when sequencing effects.
	 */
	public class Pause extends TweenEffect
	{
		/**
		 *  Constructor.
		 */
		public function Pause (target:Object = null);
		/**
		 *  @private
		 */
		public function createInstances (targets:Array = null) : Array;
	}
}