﻿package fl.controls.listClasses
{
	import fl.controls.ButtonLabelPlacement;
	import fl.controls.listClasses.ListData;
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.LabelButton;
	import fl.core.UIComponent;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @copy fl.controls.LabelButton#style:upSkin
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:downSkin
	 */
	[Style(name="downSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:overSkin
	 */
	[Style(name="overSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:disabledSkin
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedDisabledSkin
	 */
	[Style(name="selectedDisabledSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedUpSkin
	 */
	[Style(name="selectedUpSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedDownSkin
	 */
	[Style(name="selectedDownSkin", type="Class")] 
	/**
	 *  @copy fl.controls.LabelButton#style:selectedOverSkin
	 */
	[Style(name="selectedOverSkin", type="Class")] 
	/**
	 *  @copy fl.core.UIComponent#style:textFormat
	 */
	[Style(name="textFormat", type="flash.text.TextFormat")] 
	/**
	 *  @copy fl.core.UIComponent#style:disabledTextFormat
	 */
	[Style(name="disabledTextFormat", type="flash.text.TextFormat")] 
	/**
	 *  @copy fl.controls.LabelButton#style:textPadding
	 */
	[Style(name="textPadding", type="Number", format="Length")] 

	/**
	 * The CellRenderer class defines methods and properties for  
	 */
	public class CellRenderer extends LabelButton implements ICellRenderer
	{
		/**
		 * @private (protected)
		 */
		protected var _listData : ListData;
		/**
		 * @private (protected)
		 */
		protected var _data : Object;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;

		/**
		 * @copy fl.controls.listClasses.ICellRenderer#listData
		 */
		public function get listData () : ListData;
		/**
		 * @private (setter)
		 */
		public function set listData (value:ListData) : void;
		/**
		 * @copy fl.controls.listClasses.ICellRenderer#data
		 */
		public function get data () : Object;
		/**
		 * @private (setter)
		 */
		public function set data (value:Object) : void;
		/**
		 * @copy fl.controls.listClasses.ICellRenderer#selected
		 */
		public function get selected () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set selected (value:Boolean) : void;

		/**
		 * Creates a new CellRenderer instance.
		 */
		public function CellRenderer ();
		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Specifies the dimensions at which the data should be rendered. 
		 */
		public function setSize (width:Number, height:Number) : void;
		/**
		 * @private (protected)
		 */
		protected function toggleSelected (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
	}
}