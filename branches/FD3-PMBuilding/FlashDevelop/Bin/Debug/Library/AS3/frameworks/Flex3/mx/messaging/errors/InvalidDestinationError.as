﻿package mx.messaging.errors
{
	/**
	 *  This error is thrown when a destination can't be accessed
	 */
	public class InvalidDestinationError extends ChannelError
	{
		/**
		 *  Constructs a new instance of an InvalidDestinationError with the specified message.
		 */
		public function InvalidDestinationError (msg:String);
	}
}