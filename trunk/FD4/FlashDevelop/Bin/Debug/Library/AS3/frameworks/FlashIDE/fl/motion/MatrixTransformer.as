﻿package fl.motion
{
	import flash.geom.*;

	/**
	 * The MatrixTransformer class contains methods for modifying individual properties of a transformation matrix:
	 */
	public class MatrixTransformer
	{
		/**
		 * Calculates the horizontal scale present in a matrix.
		 */
		public static function getScaleX (m:Matrix) : Number;
		/**
		 * Changes the horizontal scale in a matrix.
		 */
		public static function setScaleX (m:Matrix, scaleX:Number) : void;
		/**
		 * Calculates the vertical scale present in a matrix.
		 */
		public static function getScaleY (m:Matrix) : Number;
		/**
		 * Changes the vertical scale in a matrix.
		 */
		public static function setScaleY (m:Matrix, scaleY:Number) : void;
		/**
		 * Calculates the angle of horizontal skew present in a matrix, in radians.
		 */
		public static function getSkewXRadians (m:Matrix) : Number;
		/**
		 * Changes the horizontal skew in a matrix.
		 */
		public static function setSkewXRadians (m:Matrix, skewX:Number) : void;
		/**
		 * Calculates the angle of vertical skew present in a matrix, in radians.
		 */
		public static function getSkewYRadians (m:Matrix) : Number;
		/**
		 * Changes the vertical skew in a matrix.
		 */
		public static function setSkewYRadians (m:Matrix, skewY:Number) : void;
		/**
		 * Calculates the angle of horizontal skew present in a matrix, in degrees.
		 */
		public static function getSkewX (m:Matrix) : Number;
		/**
		 * Changes the horizontal skew in a matrix.
		 */
		public static function setSkewX (m:Matrix, skewX:Number) : void;
		/**
		 * Calculates the angle of vertical skew present in a matrix, in degrees.
		 */
		public static function getSkewY (m:Matrix) : Number;
		/**
		 * Changes the vertical skew in a matrix.
		 */
		public static function setSkewY (m:Matrix, skewY:Number) : void;
		/**
		 * Calculates the angle of rotation present in a matrix, in radians.
		 */
		public static function getRotationRadians (m:Matrix) : Number;
		/**
		 * Changes the angle of rotation in a matrix.
		 */
		public static function setRotationRadians (m:Matrix, rotation:Number) : void;
		/**
		 * Calculates the angle of rotation present in a matrix, in degrees.
		 */
		public static function getRotation (m:Matrix) : Number;
		/**
		 * Changes the angle of rotation in a matrix.
		 */
		public static function setRotation (m:Matrix, rotation:Number) : void;
		/**
		 * Rotates a matrix about a point defined inside the matrix's transformation space.
		 */
		public static function rotateAroundInternalPoint (m:Matrix, x:Number, y:Number, angleDegrees:Number) : void;
		/**
		 * Rotates a matrix about a point defined outside the matrix's transformation space.
		 */
		public static function rotateAroundExternalPoint (m:Matrix, x:Number, y:Number, angleDegrees:Number) : void;
		/**
		 * Moves a matrix as necessary to align an internal point with an external point.
		 */
		public static function matchInternalPointWithExternal (m:Matrix, internalPoint:Point, externalPoint:Point) : void;
	}
}