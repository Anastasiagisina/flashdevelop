﻿package fl.motion
{
	import fl.motion.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * The Source class stores information about the context in which a Motion instance was generated.
	 */
	public class Source
	{
		/**
		 * Indicates the frames per second of the movie in which the Motion instance was generated.
		 */
		public var frameRate : Number;
		/**
		 * Indicates the type of object from which the Motion instance was generated.
		 */
		public var elementType : String;
		/**
		 * Indicates the name of the symbol from which the Motion instance was generated.
		 */
		public var symbolName : String;
		/**
		 * Indicates the instance name given to the movie clip from which the Motion instance was generated.
		 */
		public var instanceName : String;
		/**
		 * Indicates the library linkage identifier for the symbol from which the Motion instance was generated.
		 */
		public var linkageID : String;
		/**
		 * Indicates the <code>x</code> value of the original object.
		 */
		public var x : Number;
		/**
		 * Indicates the <code>y</code> value of the original object.
		 */
		public var y : Number;
		/**
		 * Indicates the <code>scaleX</code> value of the original object.
		 */
		public var scaleX : Number;
		/**
		 * Indicates the <code>scaleY</code> value of the original object.
		 */
		public var scaleY : Number;
		/**
		 * Indicates the <code>skewX</code> value of the original object.
		 */
		public var skewX : Number;
		/**
		 * Indicates the <code>skewY</code> value of the original object.
		 */
		public var skewY : Number;
		/**
		 * Indicates the <code>rotation</code> value of the original object.
		 */
		public var rotation : Number;
		/**
		 * Specifies the location of the transformation or "pivot" point of the original object, 
		 */
		public var transformationPoint : Point;
		/**
		 * Indicates the position and size of the bounding box of the object from which the Motion instance was generated.
		 */
		public var dimensions : Rectangle;

		/**
		 * Constructor for Source instances.
		 */
		function Source (xml:XML = null);
		/**
		 * @private
		 */
		private function parseXML (xml:XML = null) : Source;
	}
}