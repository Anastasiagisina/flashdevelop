﻿package mx.containers.utilityClasses
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.core.IInvalidating;
	import mx.core.mx_internal;
	import mx.core.IMXMLObject;
	import flash.events.EventDispatcher;

	/**
	 *  The ConstraintColumn class partitions an absolutely
	 */
	public class ConstraintColumn extends EventDispatcher implements IMXMLObject
	{
		local var contentSize : Boolean;
		/**
		 *  @private
		 */
		private var _container : IInvalidating;
		/**
		 *  @private
		 */
		private var _id : String;
		/**
		 *  @private
		 */
		private var _explicitMaxWidth : Number;
		/**
		 *  @private
		 */
		private var _explicitMinWidth : Number;
		/**
		 *  @private
		 */
		local var _width : Number;
		/**
		 *  @private
		 */
		private var _explicitWidth : Number;
		/**
		 *  @private
		 */
		private var _percentWidth : Number;
		private var _x : Number;

		/**
		 *  The container which this ConstraintColumn instance is 
		 */
		public function get container () : IInvalidating;
		/**
		 *  @private
		 */
		public function set container (value:IInvalidating) : void;
		/**
		 *  ID of the ConstraintColumn instance. This value becomes the instance name of the
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  Number that specifies the maximum width of the ConstraintColumn 
		 */
		public function get maxWidth () : Number;
		/**
		 *  @private
		 */
		public function set maxWidth (value:Number) : void;
		/**
		 *  Number that specifies the minimum width of the ConstraintColumn instance,
		 */
		public function get minWidth () : Number;
		/**
		 *  @private
		 */
		public function set minWidth (value:Number) : void;
		/**
		 *  Number that specifies the width of the ConstraintColumn instance, in pixels,
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  Number that specifies the explicit width of the ConstraintColumn instance, 
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;
		/**
		 *  Number that specifies the width of a component as a percentage of its 
		 */
		public function get percentWidth () : Number;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;
		/**
		 *  @private
		 */
		public function get x () : Number;
		/**
		 *  @private
		 */
		public function set x (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function ConstraintColumn ();
		/**
		 *  Called automatically by the MXML compiler when the ConstraintColumn
		 */
		public function initialized (document:Object, id:String) : void;
		/**
		 *  Sizes the constraint column.
		 */
		public function setActualWidth (w:Number) : void;
	}
}