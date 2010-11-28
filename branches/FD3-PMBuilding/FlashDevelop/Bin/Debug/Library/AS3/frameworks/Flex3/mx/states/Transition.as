﻿package mx.states
{
	import mx.effects.IEffect;

	/**
	 *  The Transition class defines a set of effects that play in response
	 */
	public class Transition
	{
		/**
		 *  The IEffect object to play when you apply the transition. Typically,
		 */
		public var effect : IEffect;
		/**
		 *  A String specifying the view state that your are changing from when
		 */
		public var fromState : String;
		/**
		 *  A String specifying the view state that you are changing to when
		 */
		public var toState : String;

		/**
		 *  Constructor.
		 */
		public function Transition ();
	}
}