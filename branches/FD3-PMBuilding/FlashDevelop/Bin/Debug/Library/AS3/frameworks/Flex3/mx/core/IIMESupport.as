﻿package mx.core
{
	/**
	 *  The IIMESupport interface defines the interface for any component that supports IME 
	 */
	public interface IIMESupport
	{
		/**
		 *  The IME mode of the component.
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;

	}
}