﻿package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.controls.listClasses.ListBase;
	import mx.effects.effectClasses.UnconstrainItemActionInstance;

	/**
	 *  The UnconstrainItemAction class defines an action effect that
	 */
	public class UnconstrainItemAction extends Effect
	{
		/**
		 *  Constructor.
		 */
		public function UnconstrainItemAction (target:Object = null);
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}