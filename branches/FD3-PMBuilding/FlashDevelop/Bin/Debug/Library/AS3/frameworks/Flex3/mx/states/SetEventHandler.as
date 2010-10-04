﻿package mx.states
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import mx.core.ComponentDescriptor;
	import mx.core.UIComponent;

	/**
	 *  The event handler function to execute in response to the event that is
	 */
	[Event(name="handler", type="Object")] 

	/**
	 *  The SetEventHandler class specifies an event handler that is active 
	 */
	public class SetEventHandler extends EventDispatcher implements IOverride
	{
		/**
		 *  @private
		 */
		private var oldHandlerFunction : Function;
		/**
		 *  @private
		 */
		private static var installedHandlers : Dictionary;
		/**
		 *  The name of the event whose handler is being set.
		 */
		public var name : String;
		/**
		 *  The handler function for the event.
		 */
		public var handlerFunction : Function;
		/**
		 *  The component that dispatches the event.
		 */
		public var target : EventDispatcher;

		/**
		 *  Constructor.
		 */
		public function SetEventHandler (target:EventDispatcher = null, name:String = null);
		/**
		 *  @private
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 *  IOverride interface method; this class implements it as an empty method.
		 */
		public function initialize () : void;
		/**
		 *  @inheritDoc
		 */
		public function apply (parent:UIComponent) : void;
		/**
		 *  @inheritDoc
		 */
		public function remove (parent:UIComponent) : void;
	}
}