﻿package mx.effects.effectClasses
{
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.IEffectInstance;
	import mx.effects.Tween;

	/**
	 *  The SequenceInstance class implements the instance class 
	 */
	public class SequenceInstance extends CompositeEffectInstance
	{
		/**
		 *  @private
		 */
		private var activeChildCount : Number;
		/**
		 *  @private
		 */
		private var currentInstanceDuration : Number;
		/**
		 *  @private
		 */
		private var currentSet : Array;
		/**
		 *  @private
		 */
		private var currentSetIndex : int;
		/**
		 *  @private
		 */
		private var startTime : Number;

		/**
		 *  @private
		 */
		function get durationWithoutRepeat () : Number;

		/**
		 *  Constructor.
		 */
		public function SequenceInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function pause () : void;
		/**
		 *  @private
		 */
		public function stop () : void;
		/**
		 *  @private
		 */
		public function resume () : void;
		/**
		 *  @private
		 */
		public function reverse () : void;
		/**
		 *  Interrupts any effects that are currently playing, skips over
		 */
		public function end () : void;
		/**
		 *  Each time a child effect of SequenceInstance finishes, 
		 */
		protected function onEffectEnd (childEffect:IEffectInstance) : void;
		/**
		 *  @private
		 */
		private function playNextChildSet (offset:Number = 0) : Boolean;
	}
}