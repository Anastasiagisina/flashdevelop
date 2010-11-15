﻿package fl.transitions
{
	import flash.display.*;

	/**
	 * The Fade class fades the movie clip object in or out. This effect requires no additional parameters.
	 */
	public class Fade extends Transition
	{
		/**
		 * @private
		 */
		protected var _alphaFinal : Number;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Fade (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		protected function _render (p:Number) : void;
	}
}