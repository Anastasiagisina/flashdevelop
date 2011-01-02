﻿package mx.effects
{
	import mx.effects.effectClasses.TweenEffectInstance;
	import mx.events.TweenEvent;
	import flash.events.EventDispatcher;

	/**
	 *  Dispatched when the tween effect starts, which corresponds to the 
	 */
	[Event(name="tweenStart", type="mx.events.TweenEvent")] 
	/**
	 *  Dispatched every time the tween effect updates the target.
	 */
	[Event(name="tweenUpdate", type="mx.events.TweenEvent")] 
	/**
	 *  Dispatched when the tween effect ends.
	 */
	[Event(name="tweenEnd", type="mx.events.TweenEvent")] 

	/**
	 *  The TweenEffect class is the superclass for all effects
	 */
	public class TweenEffect extends Effect
	{
		/**
		 *  The easing function for the animation.
		 */
		public var easingFunction : Function;

		/**
		 *  Constructor.
		 */
		public function TweenEffect (target:Object = null);
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
		/**
		 *  Called when the TweenEffect dispatches a TweenEvent.
		 */
		protected function tweenEventHandler (event:TweenEvent) : void;
	}
}