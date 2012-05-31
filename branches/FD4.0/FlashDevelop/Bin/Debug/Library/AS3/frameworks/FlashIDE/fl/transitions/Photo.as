﻿package fl.transitions
{
	import flash.display.MovieClip;
	import flash.geom.*;

	/**
	 * Makes the movie clip object appear or disappear like a photographic flash.
	 */
	public class Photo extends Transition
	{
		/**
		 * @private
		 */
		protected var _alphaFinal : Number;
		/**
		 * @private
		 */
		protected var _colorControl : ColorTransform;

		/**
		 * @private
		 */
		public function get type () : Class;

		/**
		 * @private
		 */
		function Photo (content:MovieClip, transParams:Object, manager:TransitionManager);
		/**
		 * @private
		 */
		protected function _render (p:Number) : void;
	}
}