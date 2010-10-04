﻿package mx.controls.menuClasses
{
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import mx.controls.Menu;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListData;
	import mx.core.FlexVersion;
	import mx.core.IDataRenderer;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.FlexVersion;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UITextField;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Text color of the menu item label.
	 */
	[Style(name="color", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Color of the menu item if it is disabled.
	 */
	[Style(name="disabledColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The MenuItemRenderer class defines the default item renderer
	 */
	public class MenuItemRenderer extends UIComponent implements IDataRenderer
	{
		/**
		 *  The internal IFlexDisplayObject that displays the branch icon
		 */
		protected var branchIcon : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _icon : IFlexDisplayObject;
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
		private var _menu : Menu;
		/**
		 *  The internal IFlexDisplayObject that displays the separator icon in this renderer
		 */
		protected var separatorIcon : IFlexDisplayObject;
		/**
		 *  The internal IFlexDisplayObject that displays the type icon in this renderer for
		 */
		protected var typeIcon : IFlexDisplayObject;

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
		 *  @private
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;
		/**
		 *  The internal IFlexDisplayObject that displays the icon in this renderer.
		 */
		protected function get icon () : IFlexDisplayObject;
		/**
		 *  @private
		 */
		protected function set icon (value:IFlexDisplayObject) : void;
		/**
		 *  The implementation of the <code>listData</code> property
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;
		/**
		 *  Contains a reference to the associated Menu control.
		 */
		public function get menu () : Menu;
		/**
		 *  @private
		 */
		public function set menu (value:Menu) : void;
		/**
		 *  The width of the icon
		 */
		public function get measuredIconWidth () : Number;
		/**
		 *  The width of the type icon (radio/check)
		 */
		public function get measuredTypeIconWidth () : Number;
		/**
		 *  The width of the branch icon
		 */
		public function get measuredBranchIconWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function MenuItemRenderer ();
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
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function createLabel (childIndex:int) : void;
		/**
		 *  @private
		 */
		function removeLabel () : void;
		/**
		 *  @private
		 */
		function getLabel () : IUITextField;
	}
}