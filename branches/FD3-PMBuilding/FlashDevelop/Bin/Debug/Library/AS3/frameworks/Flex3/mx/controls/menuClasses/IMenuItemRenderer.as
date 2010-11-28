﻿package mx.controls.menuClasses
{
	import mx.controls.Menu;

	/**
	 *  The IMenuItemRenderer interface defines the interface
	 */
	public interface IMenuItemRenderer
	{
		/**
		 *  A reference to this menu item renderer's Menu control, 
		 */
		public function get menu () : Menu;
		/**
		 *  @private
		 */
		public function set menu (value:Menu) : void;
		/**
		 *  The width of the icon.
		 */
		public function get measuredIconWidth () : Number;
		/**
		 *  The width of the type icon (radio/check).
		 */
		public function get measuredTypeIconWidth () : Number;
		/**
		 *  The width of the branch icon.
		 */
		public function get measuredBranchIconWidth () : Number;

	}
}