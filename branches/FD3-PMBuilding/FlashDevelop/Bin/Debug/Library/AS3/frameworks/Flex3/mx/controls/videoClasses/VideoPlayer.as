﻿package mx.controls.videoClasses
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.MetadataEvent;
	import mx.events.VideoEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import mx.controls.videoClasses.VideoPlayer;

	/**
	 *  Dispatched when the <code>NetConnection</code> is closed,
	 */
	[Event(name="close", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when playing completes by reaching the end of the FLV.
	 */
	[Event(name="complete", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when a cue point is reached.
	 */
	[Event(name="cuePoint", type="mx.events.MetadataEvent")] 
	/**
	 *  Dispatched the first time the FLV metadata is reached.
	 */
	[Event(name="metadataReceived", type="mx.events.MetadataEvent")] 
	/**
	 *  Dispatched every 0.25 seconds while the video is playing.
	 */
	[Event(name="playheadUpdate", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched every 0.25 seconds while the video is downloading.
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	/**
	 *  Dispatched when the video is loaded and ready to display.
	 */
	[Event(name="ready", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when the video autorewinds.
	 */
	[Event(name="rewind", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when the playback state changes.
	 */
	[Event(name="stateChange", type="mx.events.VideoEvent")] 

	/**
	 *  @private
	 */
	public class VideoPlayer extends Video
	{
		/**
		 *  <p>State constant.  This is the state when the VideoPlayer is
		 */
		public static const DISCONNECTED : String = "disconnected";
		/**
		 *  <p>State constant.  FLV is loaded and play is stopped.  This state
		 */
		public static const STOPPED : String = "stopped";
		/**
		 *  <p>State constant.  FLV is loaded and is playing.
		 */
		public static const PLAYING : String = "playing";
		/**
		 *  <p>State constant.  FLV is loaded, but play is paused.
		 */
		public static const PAUSED : String = "paused";
		/**
		 *  <p>State constant.  State entered immediately after
		 */
		public static const BUFFERING : String = "buffering";
		/**
		 *  <p>State constant.  State entered immediately after
		 */
		public static const LOADING : String = "loading";
		/**
		 *  <p>State constant.  Stream attempted to load was unable to load
		 */
		public static const CONNECTION_ERROR : String = "connectionError";
		/**
		 *  <p>State constant.  State entered during a autorewind triggered
		 */
		public static const REWINDING : String = "rewinding";
		/**
		 *  <p>State constant.  State entered after <code>seek()</code>
		 */
		public static const SEEKING : String = "seeking";
		/**
		 *  <p>State constant.  State entered during autoresize.</p>
		 */
		public static const RESIZING : String = "resizing";
		/**
		 *  <p>State constant.  State during execution of queued command.
		 */
		public static const EXEC_QUEUED_CMD : String = "execQueuedCmd";
		/**
		 *  @private
		 */
		private static const BUFFER_EMPTY : String = "bufferEmpty";
		/**
		 *  @private
		 */
		private static const BUFFER_FULL : String = "bufferFull";
		/**
		 *  @private
		 */
		private static const BUFFER_FLUSH : String = "bufferFlush";
		public static const DEFAULT_UPDATE_TIME_INTERVAL : Number = 250;
		public static const DEFAULT_UPDATE_PROGRESS_INTERVAL : Number = 250;
		public static const DEFAULT_IDLE_TIMEOUT_INTERVAL : Number = 300000;
		public static const AUTO_RESIZE_INTERVAL : Number = 100;
		public static const AUTO_RESIZE_PLAYHEAD_TIMEOUT : Number = .5;
		public static const AUTO_RESIZE_METADATA_DELAY_MAX : Number = 5;
		public static const FINISH_AUTO_RESIZE_INTERVAL : Number = 250;
		public static const RTMP_DO_STOP_AT_END_INTERVAL : Number = 500;
		public static const RTMP_DO_SEEK_INTERVAL : Number = 100;
		public static const HTTP_DO_SEEK_INTERVAL : Number = 250;
		public static const HTTP_DO_SEEK_MAX_COUNT : Number = 4;
		public static const CLOSE_NS_INTERVAL : Number = .25;
		public static const HTTP_DELAYED_BUFFERING_INTERVAL : Number = 100;
		/**
		 *  <p>Set this property to the name of your custom class to
		 */
		public static var DEFAULT_INCMANAGER : Class;
		/**
		 *  @private
		 */
		public var autoBandWidthDetection : Boolean;
		/**
		 *  @private
		 */
		private var cachedState : String;
		/**
		 *  @private
		 */
		private var bufferState : String;
		/**
		 *  @private
		 */
		private var sawPlayStop : Boolean;
		/**
		 *  @private
		 */
		private var cachedPlayheadTime : Number;
		/**
		 *  @private
		 */
		private var startingPlay : Boolean;
		/**
		 *  @private
		 */
		private var invalidSeekRecovery : Boolean;
		/**
		 *  @private
		 */
		private var invalidSeekTime : Boolean;
		/**
		 *  @private
		 */
		private var readyDispatched : Boolean;
		/**
		 *  @private
		 */
		private var lastUpdateTime : Number;
		/**
		 *  @private
		 */
		private var sawSeekNotify : Boolean;
		/**
		 *  @private
		 */
		public var ncMgrClassName : Class;
		/**
		 *  @private
		 */
		private var ns : VideoPlayerNetStream;
		/**
		 *  @private
		 */
		private var currentPos : Number;
		/**
		 *  @private
		 */
		private var atEnd : Boolean;
		/**
		 *  @private
		 */
		private var streamLength : Number;
		/**
		 *  @private
		 */
		private var autoPlay : Boolean;
		/**
		 *  @private
		 */
		private var _priorBytesLoaded : int;
		/**
		 *  @private
		 */
		private var internalVideoWidth : Number;
		private var internalVideoHeight : Number;
		private var prevVideoWidth : Number;
		private var prevVideoHeight : Number;
		/**
		 *  @private
		 */
		private var updateTimeTimer : Timer;
		private var updateProgressTimer : Timer;
		private var idleTimeoutTimer : Timer;
		private var autoResizeTimer : Timer;
		private var rtmpDoStopAtEndTimer : Timer;
		private var rtmpDoSeekTimer : Timer;
		private var httpDoSeekTimer : Timer;
		private var finishAutoResizeTimer : Timer;
		private var delayedBufferingTimer : Timer;
		/**
		 *  @private
		 */
		private var httpDoSeekCount : Number;
		/**
		 *  @private
		 */
		private var cmdQueue : Array;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _visible : Boolean;
		/**
		 *  @private
		 */
		private var _autoRewind : Boolean;
		/**
		 *  @private
		 */
		private var _url : String;
		/**
		 *  @private
		 */
		private var _volume : Number;
		/**
		 *  @private
		 */
		private var _soundTransform : SoundTransform;
		/**
		 *  @private
		 */
		private var _isLive : Boolean;
		/**
		 *  @private
		 */
		private var _state : String;
		/**
		 *  @private
		 */
		private var _bufferTime : Number;
		/**
		 *  @private
		 */
		private var _ncMgr : INCManager;
		/**
		 *  @private
		 */
		private var _metadata : Object;

		/**
		 *  100 is standard scale
		 */
		public function set scaleX (xs:Number) : void;
		/**
		 *  100 is standard scale
		 */
		public function set scaleY (ys:Number) : void;
		/**
		 *  <p>Width of video instance.  Not same as Video.width, that is videoWidth.</p>
		 */
		public function set width (value:Number) : void;
		/**
		 *  <p>Height of video.  Not same as Video.height, that is videoHeight.</p>
		 */
		public function set height (value:Number) : void;
		/**
		 *  <p>Source width of loaded FLV file.  Read only.  Returns
		 */
		public function get videoWidth () : int;
		/**
		 *  <p>Source height of loaded FLV file.  Read only.  Returns
		 */
		public function get videoHeight () : int;
		/**
		 * <p>Use this instead of <code>_visible</code> because we
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (v:Boolean) : void;
		/**
		 *  <p>Determines whether the FLV is rewound to the first frame
		 */
		public function get autoRewind () : Boolean;
		/**
		 *  @private
		 */
		public function set autoRewind (flag:Boolean) : void;
		/**
		 *  <p>The current playhead time in seconds.  Setting does a seek
		 */
		public function get playheadTime () : Number;
		/**
		 *  @private
		 */
		public function set playheadTime (position:Number) : void;
		/**
		 *  <p>url of currently loaded (or loading) stream. Will be url
		 */
		public function get url () : String;
		/**
		 *  <p>Volume control in range from 0 to 1.</p>
		 */
		public function get volume () : Number;
		/**
		 *  @private
		 */
		public function set volume (aVol:Number) : void;
		/**
		 *  <p>Provides direct access to the
		 */
		public function get soundTransform () : SoundTransform;
		/**
		 *  @private
		 */
		public function set soundTransform (s:SoundTransform) : void;
		/**
		 * True if stream is RTMP download (streaming from Flash
		 */
		public function get isRTMP () : Boolean;
		/**
		 * <p>True if stream is live, read only.  isLive only makes sense when
		 */
		public function get isLive () : Boolean;
		/**
		 * Get state.  Read only.  Set with <code>load</code>,
		 */
		public function get state () : String;
		/**
		 *  Read only. Gets whether state is responsive.  If state is
		 */
		public function get stateResponsive () : Boolean;
		/**
		 *  <p>property bytesLoaded, read only.  Returns -1 when there
		 */
		public function get bytesLoaded () : int;
		/**
		 *  <p>property bytesTotal, read only.  Returns -1 when there
		 */
		public function get bytesTotal () : int;
		/**
		 *  <p>property totalTime.  read only.  -1 means that property
		 */
		public function get totalTime () : Number;
		/**
		 * <p>Sets number of seconds to buffer in memory before playing
		 */
		public function get bufferTime () : Number;
		/**
		 *  @private
		 */
		public function set bufferTime (aTime:Number) : void;
		/**
		 * <p>Property idleTimeout, which is amount of time in
		 */
		public function get idleTimeout () : uint;
		/**
		 *  @private
		 */
		public function set idleTimeout (aTime:uint) : void;
		/**
		 * <p>Property playheadUpdateInterval, which is amount of time
		 */
		public function get playheadUpdateInterval () : uint;
		/**
		 *  @private
		 */
		public function set playheadUpdateInterval (aTime:uint) : void;
		/**
		 * <p>Property progressInterval, which is amount of time
		 */
		public function get progressInterval () : uint;
		/**
		 *  @private
		 */
		public function set progressInterval (aTime:uint) : void;
		/**
		 * <p>Access to instance of the class implementing
		 */
		public function get ncMgr () : INCManager;
		/**
		 *  <p>Read only.  Object received by call to onMetaData callback.
		 */
		public function get metadata () : Object;

		/**
		 *  <p>Constructor.</p>
		 */
		public function VideoPlayer (width:uint, height:uint, ncMgrClassName:Class = null);
		/**
		 *  <p>set width and height simultaneously.  Since setting either
		 */
		public function setSize (w:Number, h:Number) : void;
		/**
		 *  <p>set scaleX and scaleY simultaneously.  Since setting either
		 */
		public function setScale (xs:Number, ys:Number) : void;
		/**
		 *  <p>Causes the video to play.  Can be called while the video is
		 */
		public function play (url:String = null, isLive:Boolean = false, totalTime:Number = -1) : void;
		/**
		 *  <p>Similar to play, but causes the FLV to be loaded without
		 */
		public function load (url:String, isLive:Boolean = false, totalTime:Number = -1) : void;
		/**
		 *  <p>Pauses video playback.  If video is paused or stopped, has
		 */
		public function pause () : void;
		/**
		 *  <p>Stops video playback.  If <code>autoRewind</code> is set to
		 */
		public function stop () : void;
		/**
		 *  <p>Seeks to given second in video.  If video is playing,
		 */
		public function seek (time:Number) : void;
		/**
		 *  <p>Forces close of video stream and FCS connection.  Triggers
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		public function doUpdateTime (event:Event) : void;
		/**
		 *  @private
		 */
		public function doUpdateProgress (event:Event) : void;
		/**
		 *  @private
		 */
		public function rtmpOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private
		 */
		public function httpOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private 
		 */
		public function ncConnected () : void;
		/**
		 *  @private     
		 */
		public function ncReconnected () : void;
		/**
		 *  handles NetStream.onMetaData callback
		 */
		public function onMetaData (info:Object) : void;
		/**
		 *  handles NetStream.onCuePoint callback
		 */
		public function onCuePoint (info:Object) : void;
		/**
		 *  @private
		 */
		private function _load (url:String, isLive:Boolean, totalTime:Number) : void;
		/**
		 *  @private
		 */
		private function setState (s:String) : void;
		/**
		 *  @private
		 */
		private function setStateFromCachedState () : void;
		/**
		 * @private
		 */
		private function recoverInvalidSeek () : void;
		/**
		 *  @private
		 */
		private function createINCManager () : void;
		/**
		 *  @private
		 */
		private function rtmpDoStopAtEnd (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function rtmpDoSeek () : void;
		/**
		 *  @private
		 */
		private function httpDoStopAtEnd () : void;
		/**
		 *  @private
		 */
		private function doSeek (event:Event) : void;
		/**
		 *  @private
		 */
		private function closeNS (updateCurrentPos:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function doDelayedBuffering (event:Event) : void;
		/**
		 *  @private
		 */
		private function _pause (doPause:Boolean) : void;
		/**
		 *  @private
		 */
		private function _play (...rest) : void;
		/**
		 *  @private
		 */
		private function _seek (time:Number) : void;
		/**
		 *  @private
		 */
		private function isXnOK () : Boolean;
		/**
		 *  @private
		 */
		private function doAutoResize (event:Event) : void;
		/**
		 * <p>Makes video visible, turns on sound and starts
		 */
		private function finishAutoResize (event:Event) : void;
		/**
		 *  @private
		 */
		private function createStream () : void;
		/**
		 *  @private
		 */
		private function setUpStream () : void;
		/**
		 *  @private
		 */
		private function doIdleTimeout (event:Event) : void;
		/**
		 *  @private
		 */
		private function flushQueuedCmds () : void;
		/**
		 *  @private
		 */
		private function execQueuedCmds () : void;
		private function queueCmd (type:uint, url:String = null, isLive:Boolean = false, time:Number = 0) : void;
	}
	/**
	 *  @private
	 */
	internal dynamic class VideoPlayerNetStream extends NetStream
	{
		/**
		 *  @private
		 */
		private var videoPlayer : VideoPlayer;

		/**
		 *  Constructor.
		 */
		public function VideoPlayerNetStream (connection:NetConnection, videoPlayer:VideoPlayer);
		/**
		 *  @private
		 */
		public function onMetaData (info:Object, ...rest) : void;
		/**
		 *  @private
		 */
		public function onCuePoint (info:Object, ...rest) : void;
		/**
		 *  @private
		 */
		public function onPlayStatus (...rest) : void;
	}
}