﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import mx.containers.Panel;
	import mx.controls.alertClasses.AlertForm;
	import mx.core.Application;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.graphics.RadialGradient;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Name of the CSS style declaration that specifies 
	 */
	[Style(name="buttonStyleName", type="String", inherit="no")] 
	/**
	 *  Name of the CSS style declaration that specifies
	 */
	[Style(name="messageStyleName", type="String", inherit="no")] 
	/**
	 *  Name of the CSS style declaration that specifies styles
	 */
	[Style(name="titleStyleName", type="String", inherit="no")] 

	/**
	 *  The Alert control is a pop-up dialog box that can contain a message,
	 */
	public class Alert extends Panel
	{
		/**
		 *  Value that enables a Yes button on the Alert control when passed
		 */
		public static const YES : uint = 0x0001;
		/**
		 *  Value that enables a No button on the Alert control when passed
		 */
		public static const NO : uint = 0x0002;
		/**
		 *  Value that enables an OK button on the Alert control when passed
		 */
		public static const OK : uint = 0x0004;
		/**
		 *  Value that enables a Cancel button on the Alert control when passed
		 */
		public static const CANCEL : uint = 0x0008;
		/**
		 *  Value that makes an Alert nonmodal when passed as the
		 */
		public static const NONMODAL : uint = 0x8000;
		/**
		 *  @private
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private static var _resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private static var initialized : Boolean;
		/**
		 *  Height of each Alert button, in pixels.
		 */
		public static var buttonHeight : Number;
		/**
		 *  Width of each Alert button, in pixels.
		 */
		public static var buttonWidth : Number;
		/**
		 *  @private
		 */
		private static var _cancelLabel : String;
		/**
		 *  @private
		 */
		private static var cancelLabelOverride : String;
		/**
		 *  @private
		 */
		private static var _noLabel : String;
		/**
		 *  @private
		 */
		private static var noLabelOverride : String;
		/**
		 *  @private
		 */
		private static var _okLabel : String;
		/**
		 *  @private
		 */
		private static var okLabelOverride : String;
		/**
		 *  @private
		 */
		private static var _yesLabel : String;
		/**
		 *  @private
		 */
		private static var yesLabelOverride : String;
		/**
		 *  @private
		 */
		local var alertForm : AlertForm;
		/**
		 *  A bitmask that contains <code>Alert.OK</code>, <code>Alert.CANCEL</code>, 
		 */
		public var buttonFlags : uint;
		/**
		 *  A bitflag that contains either <code>Alert.OK</code>, 
		 */
		public var defaultButtonFlag : uint;
		/**
		 *  The class of the icon to display.
		 */
		public var iconClass : Class;
		/**
		 *  The text to display in this alert dialog box.
		 */
		public var text : String;

		/**
		 *  @private
		 */
		private static function get resourceManager () : IResourceManager;
		/**
		 *  The label for the Cancel button.
		 */
		public static function get cancelLabel () : String;
		/**
		 *  @private
		 */
		public static function set cancelLabel (value:String) : void;
		/**
		 *  The label for the No button.
		 */
		public static function get noLabel () : String;
		/**
		 *  @private
		 */
		public static function set noLabel (value:String) : void;
		/**
		 *  The label for the OK button.
		 */
		public static function get okLabel () : String;
		/**
		 *  @private
		 */
		public static function set okLabel (value:String) : void;
		/**
		 *  The label for the Yes button.
		 */
		public static function get yesLabel () : String;
		/**
		 *  @private
		 */
		public static function set yesLabel (value:String) : void;

		/**
		 *  Static method that pops up the Alert control. The Alert control 
		 */
		public static function show (text:String = "", title:String = "", flags:uint = 0x4, parent:Sprite = null, closeHandler:Function = null, iconClass:Class = null, defaultButtonFlag:uint = 0x4) : Alert;
		/**
		 *  @private
		 */
		private static function initialize () : void;
		/**
		 *  @private
		 */
		private static function static_resourcesChanged () : void;
		/**
		 *  @private
		 */
		private static function static_resourceManager_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private static function static_creationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  Constructor.
		 */
		public function Alert ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;
	}
}