﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import mx.managers.IFocusManager;
	import mx.managers.ISystemManager;

	/**
	 *  The IFocusManagerContainer interface defines the interface that 
	 */
	public interface IFocusManagerContainer extends IEventDispatcher
	{
		/**
		 *  The FocusManager for this component. 
		 */
		public function get focusManager () : IFocusManager;
		/**
		 *  @private
		 */
		public function set focusManager (value:IFocusManager) : void;
		/**
		 *  @copy mx.core.UIComponent#systemManager
		 */
		public function get systemManager () : ISystemManager;

		/**
		 *  Determines whether the specified display object is a child 
		 */
		public function contains (child:DisplayObject) : Boolean;
	}
}