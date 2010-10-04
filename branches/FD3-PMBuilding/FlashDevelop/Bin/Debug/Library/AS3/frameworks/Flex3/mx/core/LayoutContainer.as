﻿package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.utils.describeType;
	import flash.utils.setInterval;
	import mx.containers.BoxDirection;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.containers.utilityClasses.CanvasLayout;
	import mx.containers.utilityClasses.ConstraintColumn;
	import mx.containers.utilityClasses.ConstraintRow;
	import mx.containers.utilityClasses.IConstraintLayout;
	import mx.containers.utilityClasses.Layout;
	import mx.effects.EffectManager;
	import mx.events.FlexEvent;
	import mx.managers.ISystemManager;
	import mx.managers.LayoutManager;
	import mx.managers.SystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;

	/**
	 *  Number of pixels between the bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  Flex defines a default, or Application, container that lets you start
	 */
	public class LayoutContainer extends Container implements IConstraintLayout
	{
		/**
		 *  @private
		 */
		static var useProgressiveLayout : Boolean;
		/**
		 *  @private
		 */
		protected var layoutObject : Layout;
		/**
		 *  The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var canvasLayoutClass : Class;
		/**
		 *  The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var boxLayoutClass : Class;
		/**
		 *  @private
		 */
		private var resizeHandlerAdded : Boolean;
		/**
		 *  @private
		 */
		private var preloadObj : Object;
		/**
		 *  @private
		 */
		private var creationQueue : Array;
		/**
		 *  @private
		 */
		private var processingCreationQueue : Boolean;
		/**
		 *  @private
		 */
		private var _constraintColumns : Array;
		/**
		 *  @private
		 */
		private var _constraintRows : Array;
		/**
		 *  @private
		 */
		private var _layout : String;

		/**
		 *  @copy mx.containers.utilityClasses.IConstraintLayout#constraintColumns
		 */
		public function get constraintColumns () : Array;
		/**
		 *  @private
		 */
		public function set constraintColumns (value:Array) : void;
		/**
		 *  @copy mx.containers.utilityClasses.IConstraintLayout#constraintRows
		 */
		public function get constraintRows () : Array;
		/**
		 *  @private
		 */
		public function set constraintRows (value:Array) : void;
		/**
		 *  Specifies the layout mechanism used for this application. 
		 */
		public function get layout () : String;
		/**
		 *  @private
		 */
		public function set layout (value:String) : void;
		/**
		 *  @private
		 */
		function get usePadding () : Boolean;

		/**
		 *  Constructor.
		 */
		public function LayoutContainer ();
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}