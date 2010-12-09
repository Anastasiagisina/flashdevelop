﻿package mx.events
{
	import flash.events.Event;

	/**
	 *  The FlexEvent class represents the event object passed to
	 */
	public class FlexEvent extends Event
	{
		/**
		 *  The <code>FlexEvent.ADD</code> constant defines the value of the
		 */
		public static const ADD : String = "add";
		/**
		 *  The <code>FlexEvent.APPLICATION_COMPLETE</code> constant defines the value of the
		 */
		public static const APPLICATION_COMPLETE : String = "applicationComplete";
		/**
		 *  The <code>FlexEvent.BUTTON_DOWN</code> constant defines the value of the
		 */
		public static const BUTTON_DOWN : String = "buttonDown";
		/**
		 *  The <code>FlexEvent.CREATION_COMPLETE</code> constant defines the value of the
		 */
		public static const CREATION_COMPLETE : String = "creationComplete";
		/**
		 *  The <code>FlexEvent.CURSOR_UPDATE</code> constant defines the value of the
		 */
		public static const CURSOR_UPDATE : String = "cursorUpdate";
		/**
		 *  The <code>FlexEvent.DATA_CHANGE</code> constant defines the value of the
		 */
		public static const DATA_CHANGE : String = "dataChange";
		/**
		 *  The <code>FlexEvent.ENTER</code> constant defines the value of the
		 */
		public static const ENTER : String = "enter";
		/**
		 *  The <code>FlexEvent.ENTER_FRAME</code> constant defines the value of the
		 */
		public static const ENTER_FRAME : String = "flexEventEnterFrame";
		/**
		 *  The <code>FlexEvent.ENTER_STATE</code> constant defines the value of the
		 */
		public static const ENTER_STATE : String = "enterState";
		/**
		 *  The <code>FlexEvent.EXIT_STATE</code> constant defines the value of the
		 */
		public static const EXIT_STATE : String = "exitState";
		/**
		 *  The <code>FlexEvent.HIDE</code> constant defines the value of the
		 */
		public static const HIDE : String = "hide";
		/**
		 *  The <code>FlexEvent.IDLE</code> constant defines the value of the
		 */
		public static const IDLE : String = "idle";
		/**
		 *  Dispatched when a Flex application finishes initialization.
		 */
		public static const INIT_COMPLETE : String = "initComplete";
		/**
		 *  Dispatched when the Flex application completes an initialization phase,
		 */
		public static const INIT_PROGRESS : String = "initProgress";
		/**
		 *  The <code>FlexEvent.INITIALIZE</code> constant defines the value of the
		 */
		public static const INITIALIZE : String = "initialize";
		/**
		 *  The <code>FlexEvent.INVALID</code> constant defines the value of the
		 */
		public static const INVALID : String = "invalid";
		/**
		 *  The <code>FlexEvent.LOADING</code> constant defines the value of the
		 */
		public static const LOADING : String = "loading";
		/**
		 *  The <code>FlexEvent.PREINITIALIZE</code> constant defines the value of the
		 */
		public static const PREINITIALIZE : String = "preinitialize";
		/**
		 *  @private
		 */
		public static const PRELOADER_DONE : String = "preloaderDone";
		/**
		 *  The <code>FlexEvent.RENDER</code> constant defines the value of the
		 */
		public static const RENDER : String = "flexEventRender";
		/**
		 *  The <code>FlexEvent.REMOVE</code> constant defines the value of the
		 */
		public static const REMOVE : String = "remove";
		/**
		 *  The <code>FlexEvent.REPEAT</code> constant defines the value of the
		 */
		public static const REPEAT : String = "repeat";
		/**
		 *  The <code>FlexEvent.REPEAT_END</code> constant defines the value of the
		 */
		public static const REPEAT_END : String = "repeatEnd";
		/**
		 *  The <code>FlexEvent.REPEAT_START</code> constant defines the value of the
		 */
		public static const REPEAT_START : String = "repeatStart";
		/**
		 *  The <code>FlexEvent.SHOW</code> constant defines the value of the
		 */
		public static const SHOW : String = "show";
		/**
		 *  The <code>FlexEvent.TRANSFORM_CHANGE</code> constant defines the value of the
		 */
		public static const TRANSFORM_CHANGE : String = "transformChange";
		/**
		 *  The <code>FlexEvent.UPDATE_COMPLETE</code> constant defines the value of the
		 */
		public static const UPDATE_COMPLETE : String = "updateComplete";
		/**
		 *  The <code>FlexEvent.URL_CHANGED</code> constant defines the value of the
		 */
		public static const URL_CHANGED : String = "urlChanged";
		/**
		 *  The <code>FlexEvent.VALID</code> constant defines the value of the
		 */
		public static const VALID : String = "valid";
		/**
		 *  The <code>FlexEvent.VALUE_COMMIT</code> constant defines the value of the
		 */
		public static const VALUE_COMMIT : String = "valueCommit";

		/**
		 *  Constructor.
		 */
		public function FlexEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}