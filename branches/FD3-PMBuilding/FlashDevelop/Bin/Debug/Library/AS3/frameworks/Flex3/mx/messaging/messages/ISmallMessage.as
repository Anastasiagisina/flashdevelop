﻿package mx.messaging.messages
{
	/**
	 * A marker interface that is used to indicate that an IMessage has an
	 */
	public interface ISmallMessage extends IMessage
	{
		/**
		 * This method must be implemented by subclasses that have a "small" form,
		 */
		public function getSmallMessage () : IMessage;
	}
}