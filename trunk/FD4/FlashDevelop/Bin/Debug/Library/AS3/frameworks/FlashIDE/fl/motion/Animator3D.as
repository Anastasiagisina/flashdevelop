﻿package fl.motion
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import __AS3__.vec.Vector;
	import flash.geom.Point;

	/**
	 * The Animator3D class applies an XML description of a three-dimensional motion tween to a display object.
	 */
	public class Animator3D extends AnimatorBase
	{
		private var _initialPosition : Vector3D;
		private var _initialMatrixOfTarget : Matrix3D;
		/**
		 * @private
		 */
		protected static const EPSILON : Number = 0.00000001;

		/**
		 * Establishes, the x-, y-, and z- coordinates of the display object.
		 */
		public function set initialPosition (initPos:Array) : void;

		/**
		 * Creates an Animator3D object to apply the XML-based motion tween description in three dimensions to a display object.
		 */
		public function Animator3D (xml:XML = null, target:DisplayObject = null);
		/**
		 * @private
		 */
		protected function setTargetState () : void;
		/**
		 * @private
		 */
		protected function setTime3D (newTime:int, thisMotion:MotionBase) : Boolean;
		/**
		 * @private
		 */
		private function getScaleSkewMatrix (thisMotion:MotionBase, newTime:int, positionX:Number, positionY:Number) : Matrix;
		/**
		 * @private
		 */
		protected static function getSign (n:Number) : int;
		protected static function convertMatrixToMatrix3D (mat2D:Matrix) : Matrix3D;
	}
}