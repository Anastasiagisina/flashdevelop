﻿package mx.rpc.xml
{
	/**
	 * This internal utility class is used by XMLDecoder, to store some properties
	 */
	public class DecodingContext
	{
		public var index : int;
		public var hasContextSiblings : Boolean;
		public var anyIndex : int;

		public function DecodingContext ();
	}
}