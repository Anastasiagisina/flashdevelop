﻿package mx.controls.listClasses
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IToolTip;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ToolTipEvent;
	import mx.managers.ISystemManager;

	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Text color of a component label.
	 */
	[Style(name="color", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Text color of the component if it is disabled.
	 */
	[Style(name="disabledColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The ListItemRenderer class defines the default item renderer
	 */
	public class ListItemRenderer extends UIComponent implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var listOwner : ListBase;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  The internal IFlexDisplayObject that displays the icon in this renderer.
		 */
		protected var icon : IFlexDisplayObject;
		/**
		 *  The internal UITextField that displays the text in this renderer.
		 */
		protected var label : IUITextField;
		/**
		 *  @private
		 */
		private var _listData : ListData;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  The implementation of the <code>data</code> property
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The implementation of the <code>listData</code> property
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  Constructor.
		 */
		public function ListItemRenderer ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Positions the ToolTip object.
		 */
		protected function toolTipShowHandler (event:ToolTipEvent) : void;
		/**
		 *  @private
		 */
		function getLabel () : IUITextField;
	}
}