﻿package mx.core
{
	/**
	 *  The IDeferredInstance interface defines the Flex deferred instance factory interface.
	 */
	public interface IDeferredInstance
	{
		/**
		 *  Creates an instance Object from a class or function,
		 */
		public function getInstance () : Object;
	}
}