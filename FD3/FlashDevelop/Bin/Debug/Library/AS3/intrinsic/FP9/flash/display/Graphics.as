package flash.display
{
	import flash.geom.Matrix;
	import flash.display.BitmapData;

	/// The Graphics class contains a set of methods that you can use to create a vector shape.
	public class Graphics extends Object
	{
		/// Begins a bitmap filled shape.
		public function beginBitmapFill (bitmap:BitmapData = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false) : void;

		/// Specifies a single-color fill.
		public function beginFill (color:uint = null, alpha:Number = 1) : void;

		/// Specifies a gradient fill.
		public function beginGradientFill (type:String = null, colors:Array = null, alphas:Array = null, ratios:Array = null, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0) : void;

		/// Clears the graphics that were drawn to this Graphics object, and resets fill and line style settings.
		public function clear () : void;

		/// Draws a curve from the current drawing position to (anchorX, anchorY) using the control point specified by (controlX, controlY).
		public function curveTo (controlX:Number, controlY:Number, anchorX:Number, anchorY:Number) : void;

		/// Draws a circle.
		public function drawCircle (x:Number, y:Number, radius:Number) : void;

		/// Draws an ellipse.
		public function drawEllipse (x:Number, y:Number, width:Number, height:Number) : void;

		/// Draws a round rectangle.
		public function drawRect (x:Number, y:Number, width:Number, height:Number) : void;

		/// Draws a round rectangle.
		public function drawRoundRect (x:Number = null, y:Number = null, width:Number = null, height:Number = null, ellipseWidth:Number = null, ellipseHeight:Number = null) : void;

		public function drawRoundRectComplex (x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number) : void;

		/// Applies a fill to the lines and curves.
		public function endFill () : void;

		public function Graphics ();

		/// Specifies a gradient to use for the stroke when drawing lines.
		public function lineGradientStyle (type:String = null, colors:Array = null, alphas:Array = null, ratios:Array = null, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0) : void;

		/// Specifies a line style that Flash uses for drawing lines.
		public function lineStyle (thickness:Number = null, color:uint = 0, alpha:Number = 1, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3) : void;

		/// Draws a line from the current drawing position to (x, y).
		public function lineTo (x:Number, y:Number) : void;

		/// Moves the current drawing position to (x, y).
		public function moveTo (x:Number, y:Number) : void;
	}
}
