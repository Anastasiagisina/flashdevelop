﻿package mx.controls.videoClasses
{
	/**
	 *  @private
	 */
	public class NCManagerReconnectClient
	{
		public var owner : NCManager;

		public function NCManagerReconnectClient (owner:NCManager = null);
		public function onBWCheck (...rest) : uint;
		public function onBWDone (...rest) : void;
	}
}