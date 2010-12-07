﻿package fl.video
{
	/**
	 * <p>Holds client-side functions for remote procedure calls (rpc)
	 */
	public class ReconnectClient
	{
		public var owner : NCManager;

		public function ReconnectClient (owner:NCManager);
		public function close () : void;
		public function onBWDone (...rest) : void;
	}
}