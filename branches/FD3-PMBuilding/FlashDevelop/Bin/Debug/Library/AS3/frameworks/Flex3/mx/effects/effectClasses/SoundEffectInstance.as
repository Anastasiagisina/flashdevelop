﻿package mx.effects.effectClasses
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.Tween;

	/**
	 *  The SoundEffectInstance class implements the instance class
	 */
	public class SoundEffectInstance extends EffectInstance
	{
		/**
		 *  @private.
		 */
		private var origVolume : Number;
		/**
		 *  @private.
		 */
		private var origPan : Number;
		/**
		 *  @private.
		 */
		private var volumeTween : Tween;
		/**
		 *  @private.
		 */
		private var panTween : Tween;
		/**
		 *  @private.
		 */
		private var soundDuration : Number;
		/**
		 *  @private.
		 */
		private var tweenCount : int;
		/**
		 *  @private.
		 */
		private var intervalID : Number;
		/**
		 *  @private.
		 */
		private var endOnTweens : Boolean;
		/**
		 *  @private.
		 */
		private var pausedPosition : Number;
		/**
		 *  @private.
		 */
		private var resumedPosition : Number;
		/**
		 *  @private.
		 */
		private var pausedTransform : SoundTransform;
		/**
		 *  The SoundEffect class uses an internal Sound object to control
		 */
		public var bufferTime : Number;
		/**
		 *	The number of times to play the sound in a loop, where a value of 
		 */
		public var loops : int;
		/**
		 *	The easing function for the pan effect.
		 */
		public var panEasingFunction : Function;
		/**
		 *	Initial pan of the Sound object.
		 */
		public var panFrom : Number;
		/**
		 *	Final pan of the Sound object.
		 */
		public var panTo : Number;
		/**
		 *  @private
		 */
		private var _soundChannel : SoundChannel;
		/**
		 *  Reference to the internal Sound object. The SoundEffect uses this
		 */
		public var sound : Sound;
		/**
		 *  @private
		 */
		private var _source : Object;
		/**
		 *  The initial position in the MP3 file, in milliseconds, 
		 */
		public var startTime : Number;
		/**
		 *  If <code>true</code>, stop the effect
		 */
		public var useDuration : Boolean;
		/**
		 *	The easing function for the volume effect.
		 */
		public var volumeEasingFunction : Function;
		/**
		 *	Initial volume of the Sound object.
		 */
		public var volumeFrom : Number;
		/**
		 *	Final volume of the Sound object.
		 */
		public var volumeTo : Number;

		/**
		 *  @private
		 */
		private function get totalDuration () : Number;
		/**
		 *	This property is <code>true</code> if the MP3 has been loaded.
		 */
		public function get isLoading () : Boolean;
		/**
		 *	The SoundChannel object that the MP3 file has been loaded into.
		 */
		public function get soundChannel () : SoundChannel;
		/**
		 *	The URL or class of the MP3 file to play.
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function SoundEffectInstance (target:Object);
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function pause () : void;
		/**
		 *  @private
		 */
		public function stop () : void;
		/**
		 *  @private
		 */
		public function resume () : void;
		/**
		 *  @private
		 */
		public function end () : void;
		/**
		 *  @private
		 */
		public function finishEffect () : void;
		/**
		 *  @private
		 */
		function onVolumeTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		function onVolumeTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		function onPanTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		function onPanTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		private function finishTween () : void;
		/**
		 *  @private
		 */
		private function durationEndHandler (event:TimerEvent) : void;
		/**
		 *  @private
		 */
		private function soundCompleteHandler (event:Event) : void;
	}
}