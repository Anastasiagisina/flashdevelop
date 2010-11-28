﻿package mx.core
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 *  Dispatched after the SWF asset has been fully loaded.
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/**
	 *  MovieClipLoaderAsset is a subclass of the MovieClipAsset class
	 */
	public class MovieClipLoaderAsset extends MovieClipAsset implements IFlexAsset
	{
		/**
		 *  @private
		 */
		private var loader : Loader;
		/**
		 *  @private
		 */
		private var initialized : Boolean;
		/**
		 *  @private
		 */
		private var requestedWidth : Number;
		/**
		 *  @private
		 */
		private var requestedHeight : Number;
		/**
		 *  Backing storage for the <code>measuredWidth</code> property.
		 */
		protected var initialWidth : Number;
		/**
		 *  Backing storage for the <code>measuredHeight</code> property.
		 */
		protected var initialHeight : Number;

		/**
		 *  @private
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  A ByteArray containing the inner content.
		 */
		public function get movieClipData () : ByteArray;

		/**
		 *  Constructor.
		 */
		public function MovieClipLoaderAsset ();
		/**
		 *  @private
		 */
		private function completeHandler (event:Event) : void;
	}
}