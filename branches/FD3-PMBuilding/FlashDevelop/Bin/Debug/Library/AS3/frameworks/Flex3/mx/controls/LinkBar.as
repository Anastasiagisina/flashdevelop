﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  Number of pixels between the LinkButton controls in the horizontal direction.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the link
	 */
	[Style(name="linkButtonStyleName", type="String", inherit="no")] 
	/**
	 *  Number of pixels between the bottom border and the LinkButton controls.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the top border and the LinkButton controls.
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 
	/**
	 *  Color of links as you roll the mouse pointer over them.
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Background color of the LinkButton control as you press it.
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Separator color used by the default separator skin.
	 */
	[Style(name="separatorColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Seperator symbol between LinkButton controls in the LinkBar. 
	 */
	[Style(name="separatorSkin", type="Class", inherit="no")] 
	/**
	 *  Separator pixel width, in pixels.
	 */
	[Style(name="separatorWidth", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Text color of the link as you move the mouse pointer over it.
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Text color of the link as you press it.
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Number of pixels between children in the vertical direction.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  A LinkBar control defines a horizontal or vertical row of LinkButton controls
	 */
	public class LinkBar extends NavBar
	{
		/**
		 *  @private
		 */
		private static const SEPARATOR_NAME : String = "_separator";
		/**
		 *  @private
		 */
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var _selectedIndexChanged : Boolean;

		/**
		 *  The index of the last selected LinkButton control if the LinkBar 
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function LinkBar ();
		/**
		 *  @inheritDoc
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Responds to size changes by setting the positions and sizes
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;
		/**
		 *  @private
		 */
		protected function hiliteSelectedNavItem (index:int) : void;
		/**
		 *  @private
		 */
		protected function resetNavItems () : void;
		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function defaultClickHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}