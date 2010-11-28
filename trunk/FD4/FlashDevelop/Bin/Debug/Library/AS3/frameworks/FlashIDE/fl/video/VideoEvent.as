﻿package fl.video
{
	import flash.events.Event;

	/**
	 * Flash<sup>&#xAE;</sup> Player dispatches a VideoEvent object when the user 
	 */
	public class VideoEvent extends Event implements IVPEvent
	{
		/**
		 * Defines the value of the <code>type</code> property of an <code>autoRewound</code> 
		 */
		public static const AUTO_REWOUND : String = "autoRewound";
		/**
		 * Defines the value of the <code>type</code> property of a <code>bufferingStateEntered</code> 
		 */
		public static const BUFFERING_STATE_ENTERED : String = "bufferingStateEntered";
		/**
		 * Defines the value of the <code>type</code> property of a <code>close</code> 
		 */
		public static const CLOSE : String = "close";
		/**
		 * Defines the value of the <code>type</code> property of a <code>complete</code> event object. 
		 */
		public static const COMPLETE : String = "complete";
		/**
		 * Defines the value of the <code>type</code> property of a <code>fastForward</code> 
		 */
		public static const FAST_FORWARD : String = "fastForward";
		/**
		 * Defines the value of the <code>type</code> property of a <code>pausedStateEntered</code> 
		 */
		public static const PAUSED_STATE_ENTERED : String = "pausedStateEntered";
		/**
		 * Defines the value of the <code>type</code> property of a <code>playheadUpdate</code> 
		 */
		public static const PLAYHEAD_UPDATE : String = "playheadUpdate";
		/**
		 * Defines the value of the <code>type</code> property of a <code>playingStateEntered</code> 
		 */
		public static const PLAYING_STATE_ENTERED : String = "playingStateEntered";
		/**
		 * Defines the value of the <code>type</code> property of a <code>ready</code> 
		 */
		public static const READY : String = "ready";
		/**
		 * Defines the value of the <code>type</code> property of a <code>rewind</code> 
		 */
		public static const REWIND : String = "rewind";
		/**
		 * Defines the value of the <code>type</code> property of a <code>scrubFinish</code> 
		 */
		public static const SCRUB_FINISH : String = "scrubFinish";
		/**
		 * Defines the value of the <code>type</code> property of a <code>scrubStart</code> 
		 */
		public static const SCRUB_START : String = "scrubStart";
		/**
		 * Defines the value of the <code>type</code> property of a <code>seeked</code> event object.
		 */
		public static const SEEKED : String = "seeked";
		/**
		 * Defines the value of the <code>type</code> property of a <code>skinLoaded</code> event object.
		 */
		public static const SKIN_LOADED : String = "skinLoaded";
		/**
		 * Defines the value of the <code>type</code> property of a <code>stateChange</code> event object.
		 */
		public static const STATE_CHANGE : String = "stateChange";
		/**
		 * Defines the value of the <code>type</code> property of a <code>stoppedStateEntered</code> 
		 */
		public static const STOPPED_STATE_ENTERED : String = "stoppedStateEntered";
		private var _state : String;
		private var _playheadTime : Number;
		private var _vp : uint;

		/**
		 * A string identifying the constant from the VideoState 
		 */
		public function get state () : String;
		/**
		 * @private (setter)
		 */
		public function set state (s:String) : void;
		/**
		 * A number that is the current playhead time or position, measured in seconds, 
		 */
		public function get playheadTime () : Number;
		/**
		 * @private (setter)
		 */
		public function set playheadTime (t:Number) : void;
		/**
		 * The index of the VideoPlayer object involved in this event.
		 */
		public function get vp () : uint;
		/**
		 * @private (setter)
		 */
		public function set vp (n:uint) : void;

		/**
		 * Creates an Event object that contains information about video events. 
		 */
		public function VideoEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, state:String = null, playheadTime:Number = NaN, vp:uint = 0);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}