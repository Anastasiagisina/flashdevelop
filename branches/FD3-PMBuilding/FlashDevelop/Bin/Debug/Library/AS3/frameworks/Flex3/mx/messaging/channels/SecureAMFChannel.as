﻿package mx.messaging.channels
{
	/**
	 *  The SecureAMFChannel class is identical to the AMFChannel class except that it uses a
	 */
	public class SecureAMFChannel extends AMFChannel
	{
		/**
		 *  Returns the protocol for this channel (https).
		 */
		public function get protocol () : String;

		/**
		 *  Creates an new SecureAMFChannel instance.
		 */
		public function SecureAMFChannel (id:String = null, uri:String = null);
	}
}