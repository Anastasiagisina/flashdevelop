﻿package mx.graphics.codec
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 *  The IImageEncoder interface defines the interface
	 */
	public interface IImageEncoder
	{
		/**
		 *  The MIME type for the image format that this encoder produces.
		 */
		public function get contentType () : String;

		/**
		 *  Encodes a BitmapData object as a ByteArray.
		 */
		public function encode (bitmapData:BitmapData) : ByteArray;
		/**
		 *  Encodes a ByteArray object containing raw pixels
		 */
		public function encodeByteArray (byteArray:ByteArray, width:int, height:int, transparent:Boolean = true) : ByteArray;
	}
}