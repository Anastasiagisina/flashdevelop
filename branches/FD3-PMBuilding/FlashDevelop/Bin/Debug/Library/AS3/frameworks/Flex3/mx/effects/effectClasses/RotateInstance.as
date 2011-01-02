﻿package mx.effects.effectClasses
{
	import mx.core.mx_internal;
	import mx.effects.EffectManager;

	/**
	 *  The RotateInstance class implements the instance class
	 */
	public class RotateInstance extends TweenEffectInstance
	{
		/**
		 *  @private
		 */
		private var centerX : Number;
		/**
		 *  @private
		 */
		private var centerY : Number;
		/**
		 *  @private
		 */
		private var newX : Number;
		/**
		 *  @private
		 */
		private var newY : Number;
		/**
		 *  @private
		 */
		private var originalOffsetX : Number;
		/**
		 *  @private
		 */
		private var originalOffsetY : Number;
		/**
		 *  The starting angle of rotation of the target object,
		 */
		public var angleFrom : Number;
		/**
		 *  The ending angle of rotation of the target object,
		 */
		public var angleTo : Number;
		/**
		 *  The x-position of the center point of rotation.
		 */
		public var originX : Number;
		/**
		 *  The y-position of the center point of rotation.
		 */
		public var originY : Number;

		/**
		 *  Constructor.
		 */
		public function RotateInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
	}
}