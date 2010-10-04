﻿package fl.transitions
{
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;

	/**
	 * @eventType fl.transitions.TweenEvent.MOTION_CHANGE
	 */
	[Event(name="motionChange", type="fl.transitions.TweenEvent")] 
	/**
	 * @eventType fl.transitions.TweenEvent.MOTION_FINISH
	 */
	[Event(name="motionFinish", type="fl.transitions.TweenEvent")] 
	/**
	 * @eventType fl.transitions.TweenEvent.MOTION_LOOP
	 */
	[Event(name="motionLoop", type="fl.transitions.TweenEvent")] 
	/**
	 * @eventType fl.transitions.TweenEvent.MOTION_RESUME
	 */
	[Event(name="motionResume", type="fl.transitions.TweenEvent")] 
	/**
	 * @eventType fl.transitions.TweenEvent.MOTION_START
	 */
	[Event(name="motionStart", type="fl.transitions.TweenEvent")] 
	/**
	 * @eventType fl.transitions.TweenEvent.MOTION_STOP
	 */
	[Event(name="motionStop", type="fl.transitions.TweenEvent")] 

	/**
	 * The Tween class lets you use ActionScript to move, resize, and fade movie clips 
	 */
	public class Tween extends EventDispatcher
	{
		/**
		 * @private
		 */
		protected static var _mc : MovieClip;
		/**
		 * Indicates whether the tween is currently playing.
		 */
		public var isPlaying : Boolean;
		/**
		 * The target object that is being tweened.
		 */
		public var obj : Object;
		/**
		 * The name of the property affected by the tween of the target object.
		 */
		public var prop : String;
		/**
		 * The initial value of the target object's designated property before the tween starts.
		 */
		public var begin : Number;
		/**
		 * @private
		 */
		public var change : Number;
		/**
		 * Indicates whether the tween plays over a period of frames or seconds. A value of <code>true</code> will
		 */
		public var useSeconds : Boolean;
		/**
		 * @private
		 */
		public var prevTime : Number;
		/**
		 * @private
		 */
		public var prevPos : Number;
		/**
		 * Indicates whether the tween will loop. If the value is <code>true</code>, the tween will restart 
		 */
		public var looping : Boolean;
		/**
		 * @private
		 */
		private var _duration : Number;
		/**
		 * @private
		 */
		private var _time : Number;
		/**
		 * @private
		 */
		private var _fps : Number;
		/**
		 * @private
		 */
		private var _position : Number;
		/**
		 * @private
		 */
		private var _startTime : Number;
		/**
		 * @private
		 */
		private var _intervalID : uint;
		/**
		 * @private
		 */
		private var _finish : Number;
		/**
		 * @private
		 */
		private var _timer : Timer;

		/**
		 * The current time within the duration of the animation.
		 */
		public function get time () : Number;
		/**
		 * @private (setter)
		 */
		public function set time (t:Number) : void;
		/**
		 * The duration of the tweened animation in frames or seconds. This property is set as
		 */
		public function get duration () : Number;
		/**
		 * @private (setter)
		 */
		public function set duration (d:Number) : void;
		/**
		 * The number of frames per second calculated into the tweened animation. By default the
		 */
		public function get FPS () : Number;
		/**
		 * @private (setter)
		 */
		public function set FPS (fps:Number) : void;
		/**
		 * The current value of the target object property being tweened. This value updates 
		 */
		public function get position () : Number;
		/**
		 * @private (setter)
		 */
		public function set position (p:Number) : void;
		/**
		 * A number indicating the ending value of the target object property that is to be tweened. 
		 */
		public function get finish () : Number;
		/**
		 * @private (setter)
		 */
		public function set finish (value:Number) : void;

		/**
		 * The easing function which is used with the tween.
		 */
		public function func (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 * @private
		 */
		public function getPosition (t:Number = NaN) : Number;
		/**
		 * @private
		 */
		public function setPosition (p:Number) : void;
		/**
		 * Creates an instance of the Tween class. Use the constructor function with the <code>new</code> operator: <code>var myTween:Tween = new Tween()</code>.
		 */
		function Tween (obj:Object, prop:String, func:Function, begin:Number, finish:Number, duration:Number, useSeconds:Boolean = false);
		/**
		 * Instructs the tweened animation to continue tweening from its current animation point to
		 */
		public function continueTo (finish:Number, duration:Number) : void;
		/**
		 * Instructs the tweened animation to play in reverse from its last direction of tweened 
		 */
		public function yoyo () : void;
		/**
		 * @private
		 */
		protected function startEnterFrame () : void;
		/**
		 * @private
		 */
		protected function stopEnterFrame () : void;
		/**
		 * Starts the play of a tweened animation from its starting point. This method is used for 
		 */
		public function start () : void;
		/**
		 * Stops the play of a tweened animation at its current value.
		 */
		public function stop () : void;
		/**
		 * Resumes the play of a tweened animation that has been stopped. Use this method to continue
		 */
		public function resume () : void;
		/**
		 * Moves the play of a tweened animation back to its starting value. If 
		 */
		public function rewind (t:Number = 0) : void;
		/**
		 * Forwards the tweened animation directly to the final value of the tweened animation.
		 */
		public function fforward () : void;
		/**
		 * Forwards the tweened animation to the next frame of an animation that was stopped. Use this
		 */
		public function nextFrame () : void;
		/**
		 * @private
		 */
		protected function onEnterFrame (event:Event) : void;
		/**
		 * @private
		 */
		protected function timerHandler (timerEvent:TimerEvent) : void;
		/**
		 * Plays the previous frame of the tweened animation from the current stopping point of an 
		 */
		public function prevFrame () : void;
		/**
		 * @private
		 */
		private function fixTime () : void;
		/**
		 * @private
		 */
		private function update () : void;
	}
}