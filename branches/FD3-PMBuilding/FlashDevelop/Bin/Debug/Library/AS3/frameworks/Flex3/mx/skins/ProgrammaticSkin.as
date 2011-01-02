﻿package mx.skins
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import mx.core.IInvalidating;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.managers.ILayoutManagerClient;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.utils.GraphicsUtil;
	import mx.utils.NameUtil;
	import mx.core.FlexShape;
	import mx.core.IProgrammaticSkin;

	/**
	 *  This class is the base class for skin elements
	 */
	public class ProgrammaticSkin extends FlexShape implements IFlexDisplayObject
	{
		/**
		 *  @private
		 */
		private static var tempMatrix : Matrix;
		/**
		 *  @private
		 */
		private var invalidateDisplayListFlag : Boolean;
		/**
		 *  @private
		 */
		private var _height : Number;
		/**
		 *  @private
		 */
		private var _width : Number;
		/**
		 *  @private
		 */
		private var _initialized : Boolean;
		/**
		 *  @private
		 */
		private var _nestLevel : int;
		/**
		 *  @private
		 */
		private var _processedDescriptors : Boolean;
		/**
		 *  @private
		 */
		private var _updateCompletePendingFlag : Boolean;
		/**
		 *  @private
		 */
		private var _styleName : IStyleClient;

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
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  The measured height of this object.
		 */
		public function get measuredHeight () : Number;
		/**
		 *  The measured width of this object.
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @copy mx.core.UIComponent#initialized
		 */
		public function get initialized () : Boolean;
		/**
		 *  @private
		 */
		public function set initialized (value:Boolean) : void;
		/**
		 *  @copy mx.core.UIComponent#nestLevel
		 */
		public function get nestLevel () : int;
		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;
		/**
		 *  @copy mx.core.UIComponent#processedDescriptors
		 */
		public function get processedDescriptors () : Boolean;
		/**
		 *  @private
		 */
		public function set processedDescriptors (value:Boolean) : void;
		/**
		 *  A flag that determines if an object has been through all three phases
		 */
		public function get updateCompletePendingFlag () : Boolean;
		/**
		 *  @private
		 */
		public function set updateCompletePendingFlag (value:Boolean) : void;
		/**
		 *  A parent component used to obtain style values. This is typically set to the
		 */
		public function get styleName () : Object;
		/**
		 *  @private
		 */
		public function set styleName (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function ProgrammaticSkin ();
		/**
		 *  Moves this object to the specified x and y coordinates.
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  Sets the height and width of this object.
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  This function is an empty stub so that ProgrammaticSkin
		 */
		public function validateProperties () : void;
		/**
		 *  This function is an empty stub so that ProgrammaticSkin
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  This function is called by the LayoutManager
		 */
		public function validateDisplayList () : void;
		/**
		 *  Whenever any style changes, redraw this skin.
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @copy mx.core.UIComponent#invalidateDisplayList()
		 */
		public function invalidateDisplayList () : void;
		/**
		 *  Programmatically draws the graphics for this skin.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @inheritDoc
		 */
		public function invalidateSize () : void;
		/**
		 *  @inheritDoc
		 */
		public function invalidateProperties () : void;
		/**
		 *  Validate and update the properties and layout of this object
		 */
		public function validateNow () : void;
		/**
		 *  Returns the value of the specified style property.
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  Utility function to create a horizontal gradient matrix.
		 */
		protected function horizontalGradientMatrix (x:Number, y:Number, width:Number, height:Number) : Matrix;
		/**
		 *  Utility function to create a vertical gradient matrix.
		 */
		protected function verticalGradientMatrix (x:Number, y:Number, width:Number, height:Number) : Matrix;
		/**
		 *  Utility function to create a rotated gradient matrix.
		 */
		protected function rotatedGradientMatrix (x:Number, y:Number, width:Number, height:Number, rotation:Number) : Matrix;
		/**
		 *  Programatically draws a rectangle into this skin's Graphics object.
		 */
		protected function drawRoundRect (x:Number, y:Number, width:Number, height:Number, cornerRadius:Object = null, color:Object = null, alpha:Object = null, gradientMatrix:Matrix = null, gradientType:String = "linear", gradientRatios:Array = null, hole:Object = null) : void;
	}
}