﻿package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.PropertyChanges;
	import mx.effects.effectClasses.RemoveItemActionInstance;
	import mx.controls.listClasses.ListBase;

	/**
	 *  The RemoveItemAction class defines an action effect that determines 
	 */
	public class RemoveItemAction extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;

		/**
		 *  Constructor.
		 */
		public function RemoveItemAction (target:Object = null);
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