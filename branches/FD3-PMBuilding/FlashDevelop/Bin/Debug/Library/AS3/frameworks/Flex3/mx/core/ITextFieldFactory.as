﻿package mx.core
{
	import flash.text.TextField;

	/**
	 *  @private
	 */
	public interface ITextFieldFactory
	{
		/**
		 *  Creates a TextField object in the context
		 */
		public function createTextField (moduleFactory:IFlexModuleFactory) : TextField;
	}
}