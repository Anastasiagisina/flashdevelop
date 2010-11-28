﻿package mx.effects
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.TweenEvent;

	/**
	 *  The Tween class defines a tween, a property animation performed
	 */
	public class Tween extends EventDispatcher
	{
		/**
		 *  @private
		 */
		static var activeTweens : Array;
		/**
		 *  @private
		 */
		private static var interval : Number;
		/**
		 *  @private
		 */
		private static var timer : Timer;
		/**
		 *  @private    
		 */
		static var intervalTime : Number;
		/**
		 *  @private
		 */
		local var needToLayout : Boolean;
		/**
		 *  @private
		 */
		private var id : int;
		/**
		 *  @private
		 */
		private var maxDelay : Number;
		/**
		 *  @private
		 */
		private var arrayMode : Boolean;
		/**
		 *  @private
		 */
		private var _doSeek : Boolean;
		/**
		 *  @private
		 */
		private var _isPlaying : Boolean;
		/**
		 *  @private
		 */
		private var _doReverse : Boolean;
		/**
		 *  @private
		 */
		local var startTime : Number;
		/**
		 *  @private
		 */
		private var previousUpdateTime : Number;
		/**
		 *  @private
		 */
		private var userEquation : Function;
		/**
		 *  @private
		 */
		private var updateFunction : Function;
		/**
		 *  @private
		 */
		private var endFunction : Function;
		/**
		 *  @private
		 */
		private var endValue : Object;
		/**
		 *  @private
		 */
		private var startValue : Object;
		/**
		 *  @private
		 */
		private var started : Boolean;
		/**
		 *  Duration of the animation, in milliseconds.
		 */
		public var duration : Number;
		/**
		 *  Object that is notified at each interval of the animation.
		 */
		public var listener : Object;
		/**
		 *  @private
		 */
		private var _playheadTime : Number;
		/**
		 *  @private
		 */
		private var _invertValues : Boolean;

		/**
		 *  @private
		 */
		function get playheadTime () : Number;
		/**
		 *  @private
		 */
		function get playReversed () : Boolean;
		/**
		 *  @private
		 */
		function set playReversed (value:Boolean) : void;
		/**
		 *  Sets the easing function for the animation.
		 */
		public function set easingFunction (value:Function) : void;

		/**
		 *  @private
		 */
		private static function addTween (tween:Tween) : void;
		/**
		 *  @private
		 */
		private static function removeTweenAt (index:int) : void;
		/**
		 *  @private
		 */
		static function removeTween (tween:Tween) : void;
		/**
		 *  @private
		 */
		private static function timerHandler (event:TimerEvent) : void;
		/**
		 *  Constructor.
		 */
		public function Tween (listener:Object, startValue:Object, endValue:Object, duration:Number = -1, minFps:Number = -1, updateFunction:Function = null, endFunction:Function = null);
		/**
		 *  By default, the Tween class invokes the 
		 */
		public function setTweenHandlers (updateFunction:Function, endFunction:Function) : void;
		/**
		 *  Interrupt the tween, jump immediately to the end of the tween, 
		 */
		public function endTween () : void;
		/**
		 *  @private
		 */
		function doInterval () : Boolean;
		/**
		 *  @private
		 */
		function getCurrentValue (currentTime:Number) : Object;
		/**
		 *  @private
		 */
		private function defaultEasingFunction (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 *  Advances the tween effect to the specified position. 
		 */
		public function seek (playheadTime:Number) : void;
		/**
		 *  Plays the effect in reverse,
		 */
		public function reverse () : void;
		/**
		 *  Pauses the effect until you call the <code>resume()</code> method.
		 */
		public function pause () : void;
		/**
		 *  Stops the tween, ending it without dispatching an event or calling
		 */
		public function stop () : void;
		/**
		 *  Resumes the effect after it has been paused 
		 */
		public function resume () : void;
	}
}