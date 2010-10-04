﻿package fl.livepreview
{
	import flash.display.*;
	import flash.external.*;
	import flash.utils.*;

	/**
	 * The LivePreviewParent class provides the timeline for a SWC file 
	 */
	public class LivePreviewParent extends MovieClip
	{
		/**
		 * The component instance.
		 */
		public var myInstance : DisplayObject;

		/**
		 * Initializes the scale and align modes of the Stage, sets the 
		 */
		public function LivePreviewParent ();
		/**
		 * Resizes the component instance on the Stage to the specified
		 */
		public function onResize (width:Number, height:Number) : void;
		/**
		 * Updates the properties of the component instance.  
		 */
		public function onUpdate (...updateArray:Array) : void;
		/**
		 * @private
		 */
		private function updateCollection (collDesc:Object, index:String) : void;
	}
}