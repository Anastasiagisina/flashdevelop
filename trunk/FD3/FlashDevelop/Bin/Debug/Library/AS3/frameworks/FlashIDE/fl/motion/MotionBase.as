﻿package fl.motion
{
	import flash.filters.*;
	import flash.geom.ColorTransform;
	import flash.utils.*;

	/**
	 * The MotionBase class stores a keyframe animation sequence that can be applied to a visual object.
	 */
	public class MotionBase
	{
		/**
		 * An array of keyframes that define the motion's behavior over time.
		 */
		public var keyframes : Array;
		/**
		 * @private
		 */
		private var _duration : int;
		private var _is3D : Boolean;
		/**
		 * Indicates whether property values for scale, skew, and rotate added in subsequent
		 */
		private var _overrideScale : Boolean;
		private var _overrideSkew : Boolean;
		private var _overrideRotate : Boolean;

		/**
		 * Controls the Motion instance's length of time, measured in frames.
		 */
		public function get duration () : int;
		/**
		 * @private (setter)
		 */
		public function set duration (value:int) : void;
		/**
		 * Specifies whether the motion contains 3D property changes. If <code>true</code>, the 
		 */
		public function get is3D () : Boolean;
		/**
		 * Sets flag that indicates whether the motion contains 3D properties. 
		 */
		public function set is3D (enable:Boolean) : void;

		/**
		 * Constructor for MotionBase instances.
		 */
		function MotionBase (xml:XML = null);
		public function overrideTargetTransform (scale:Boolean = true, skew:Boolean = true, rotate:Boolean = true) : void;
		/**
		 * @private
		 */
		private function indexOutOfRange (index:int) : Boolean;
		/**
		 * Retrieves the keyframe that is currently active at a specific frame in the Motion instance.
		 */
		public function getCurrentKeyframe (index:int, tweenableName:String = '') : KeyframeBase;
		/**
		 * Retrieves the next keyframe after a specific frame in the Motion instance.
		 */
		public function getNextKeyframe (index:int, tweenableName:String = '') : KeyframeBase;
		/**
		 * Sets the value of a specific tweenables property at a given time index in the Motion instance.
		 */
		public function setValue (index:int, tweenableName:String, value:Number) : void;
		/**
		 * Retrieves an interpolated ColorTransform object at a specific time index in the Motion instance.
		 */
		public function getColorTransform (index:int) : ColorTransform;
		/**
		 * Returns the Matrix3D object for the specified index position of
		 */
		public function getMatrix3D (index:int) : Object;
		/**
		 * Rotates the target object when data for the motion is supplied by the <code>addPropertyArray()</code> method.
		 */
		public function useRotationConcat (index:int) : Boolean;
		/**
		 * Retrieves an interpolated array of filters at a specific time index in the Motion instance.
		 */
		public function getFilters (index:Number) : Array;
		/**
		 * @private
		 */
		protected function findTweenedValue (index:Number, tweenableName:String, curKeyframeBase:KeyframeBase, timeFromKeyframe:Number, begin:Number) : Number;
		/**
		 * Retrieves the value for an animation property at a point in time.
		 */
		public function getValue (index:Number, tweenableName:String) : Number;
		/**
		 * Adds a keyframe object to the Motion instance. 
		 */
		public function addKeyframe (newKeyframe:KeyframeBase) : void;
		/**
		 * Stores an array of values in corresponding keyframes for a declared property of the Motion class.
		 */
		public function addPropertyArray (name:String, values:Array, startFrame:int = -1, endFrame:int = -1) : void;
		/**
		 * Initializes the filters list for the target object and copies the list of filters to each Keyframe
		 */
		public function initFilters (filterClasses:Array, gradientSubarrayLengths:Array, startFrame:int = -1, endFrame:int = -1) : void;
		/**
		 * Modifies a filter property in all corresponding keyframes for a Motion object. Call <code>initFilters()</code> before
		 */
		public function addFilterPropertyArray (index:int, name:String, values:Array, startFrame:int = -1, endFrame:int = -1) : void;
		/**
		 * @private
		 */
		protected function getNewKeyframe (xml:XML = null) : KeyframeBase;
	}
}