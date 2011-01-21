﻿package mx.controls
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import mx.core.Application;
	import mx.core.FlexLoader;
	import mx.core.FlexVersion;
	import mx.core.ISWFLoader;
	import mx.core.IFlexDisplayObject;
	import mx.core.ISWFBridgeProvider;
	import mx.core.ISWFLoader;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.InvalidateRequestData;
	import mx.events.InterManagerRequest;
	import mx.events.SWFBridgeEvent;
	import mx.events.SWFBridgeRequest;
	import mx.managers.CursorManager;
	import mx.managers.FocusManager;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManagerGlobals;
	import mx.styles.ISimpleStyleClient;
	import mx.utils.LoaderUtil;

	/**
	 *  Dispatched when content loading is complete.
	 */
	[Event(name="complete", type="flash.events.Event")] 
	/**
	 *  Dispatched when a network request is made over HTTP 
	 */
	[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")] 
	/**
	 *  Dispatched when the properties and methods of a loaded SWF file 
	 */
	[Event(name="init", type="flash.events.Event")] 
	/**
	 *  Dispatched when an input/output error occurs.
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 
	/**
	 *  Dispatched when a network operation starts.
	 */
	[Event(name="open", type="flash.events.Event")] 
	/**
	 *  Dispatched when content is loading.
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	/**
	 *  Dispatched when a security error occurs while content is loading.
	 */
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")] 
	/**
	 *  Dispatched when a loaded object is removed, 
	 */
	[Event(name="unload", type="flash.events.Event")] 
	/**
	 *  The name of class to use as the SWFLoader border skin if the control cannot
	 */
	[Style(name="brokenImageBorderSkin", type="Class", inherit="no")] 
	/**
	 *  The name of the class to use as the SWFLoader skin if the control cannot load
	 */
	[Style(name="brokenImageSkin", type="Class", inherit="no")] 
	/**
	 *  The horizontal alignment of the content when it does not have
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  The vertical alignment of the content when it does not have
	 */
	[Style(name="verticalAlign", type="String", enumeration="bottom,middle,top", inherit="no")] 

	/**
	 *  The SWFLoader control loads and displays a specified SWF file.
	 */
	public class SWFLoader extends UIComponent implements ISWFLoader
	{
		/**
		 *  @private
		 */
		local var contentHolder : DisplayObject;
		/**
		 *  @private
		 */
		private var contentChanged : Boolean;
		/**
		 *  @private
		 */
		private var scaleContentChanged : Boolean;
		/**
		 *  @private
		 */
		private var isContentLoaded : Boolean;
		/**
		 *  @private
		 */
		private var brokenImage : Boolean;
		/**
		 *  @private
		 */
		private var resizableContent : Boolean;
		/**
		 *  @private
		 */
		private var flexContent : Boolean;
		/**
		 *  @private
		 */
		private var contentRequestID : String;
		/**
		 *  @private
		 */
		private var attemptingChildAppDomain : Boolean;
		/**
		 *  @private
		 */
		private var requestedURL : URLRequest;
		/**
		 *  @private
		 */
		private var brokenImageBorder : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var explicitLoaderContext : Boolean;
		/**
		 *  @private
		 */
		private var mouseShield : Sprite;
		/**
		 *  @private
		 */
		private var useUnloadAndStop : Boolean;
		/**
		 *  @private
		 */
		private var unloadAndStopGC : Boolean;
		/**
		 *  @private
		 */
		private var _autoLoad : Boolean;
		/**
		 *  @private
		 */
		private var _loadForCompatibility : Boolean;
		/**
		 *  @private
		 */
		private var _bytesLoaded : Number;
		/**
		 *  @private
		 */
		private var _bytesTotal : Number;
		/**
		 *  @private
		 */
		private var _loaderContext : LoaderContext;
		/**
		 *  @private
		 */
		private var _maintainAspectRatio : Boolean;
		private var _swfBridge : IEventDispatcher;
		/**
		 *  @private
		 */
		private var _scaleContent : Boolean;
		/**
		 *  @private
		 */
		private var _showBusyCursor : Boolean;
		/**
		 *  @private
		 */
		private var _source : Object;
		/**
		 *  @private
		 */
		private var _trustContent : Boolean;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  A flag that indicates whether content starts loading automatically
		 */
		public function get autoLoad () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLoad (value:Boolean) : void;
		/**
		 *  A flag that indicates whether the content is loaded so that it can
		 */
		public function get loadForCompatibility () : Boolean;
		/**
		 *  @private
		 */
		public function set loadForCompatibility (value:Boolean) : void;
		/**
		 *  The number of bytes of the SWF or image file already loaded.
		 */
		public function get bytesLoaded () : Number;
		/**
		 *  The total size of the SWF or image file.
		 */
		public function get bytesTotal () : Number;
		/**
		 *  This property contains the object that represents
		 */
		public function get content () : DisplayObject;
		/**
		 *  Height of the scaled content loaded by the control, in pixels. 
		 */
		public function get contentHeight () : Number;
		/**
		 *  @private
		 */
		private function get contentHolderHeight () : Number;
		/**
		 *  @private
		 */
		private function get contentHolderWidth () : Number;
		/**
		 *  Width of the scaled content loaded by the control, in pixels. 
		 */
		public function get contentWidth () : Number;
		/**
		 *  A LoaderContext object to use to control loading of the content.
		 */
		public function get loaderContext () : LoaderContext;
		/**
		 *  @private
		 */
		public function set loaderContext (value:LoaderContext) : void;
		/**
		 *  A flag that indicates whether to maintain the aspect ratio
		 */
		public function get maintainAspectRatio () : Boolean;
		/**
		 *  @private
		 */
		public function set maintainAspectRatio (value:Boolean) : void;
		/**
		 *  The percentage of the image or SWF file already loaded.
		 */
		public function get percentLoaded () : Number;
		/**
		 *  A flag that indicates whether to scale the content to fit the
		 */
		public function get scaleContent () : Boolean;
		/**
		 *  @private
		 */
		public function set scaleContent (value:Boolean) : void;
		/**
		 *  A flag that indicates whether to show a busy cursor while
		 */
		public function get showBusyCursor () : Boolean;
		/**
		 *  @private
		 */
		public function set showBusyCursor (value:Boolean) : void;
		/**
		 *  The URL, object, class or string name of a class to
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;
		/**
		 *  If <code>true</code>, the content is loaded
		 */
		public function get trustContent () : Boolean;
		/**
		 *  @private
		 */
		public function set trustContent (value:Boolean) : void;
		/**
		 * @inheritDoc
		 */
		public function get swfBridge () : IEventDispatcher;
		/**
		 * @inheritDoc
		 */
		public function get childAllowsParent () : Boolean;
		/**
		 * @inheritDoc
		 */
		public function get parentAllowsChild () : Boolean;

		/**
		 *  Constructor.
		 */
		public function SWFLoader ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Loads an image or SWF file.
		 */
		public function load (url:Object = null) : void;
		/**
		 *  Unloads an image or SWF file. After this method returns the 
		 */
		public function unloadAndStop (invokeGarbageCollector:Boolean = true) : void;
		/**
		 *  @inheritDoc
		 */
		public function getVisibleApplicationRect (allApplications:Boolean = false) : Rectangle;
		/**
		 *  @private
		 */
		private function loadContent (classOrString:Object) : DisplayObject;
		/**
		 *  @private
		 */
		private function contentLoaded () : void;
		/**
		 *  @private
		 */
		private function doScaleContent () : void;
		/**
		 *  @private
		 */
		private function doScaleLoader () : void;
		/**
		 *  @private
		 */
		private function unScaleContent () : void;
		/**
		 *  @private
		 */
		private function getHorizontalAlignValue () : Number;
		/**
		 *  @private
		 */
		private function getVerticalAlignValue () : Number;
		/**
		 *  @private
		 */
		private function dispatchInvalidateRequest (invalidateProperites:Boolean, invalidateSize:Boolean, invalidateDisplayList:Boolean) : void;
		/**
		 *  @private
		 */
		private function initializeHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function addedToStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function contentLoaderInfo_completeEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_httpStatusEventHandler (event:HTTPStatusEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_initEventHandler (event:Event) : void;
		/**
		 * If we are loading a swf, listen for a message from the swf telling us it was loading
		 */
		private function addInitSystemManagerCompleteListener (loaderInfo:LoaderInfo) : void;
		/**
		 * Remove the listener after the swf is loaded.
		 */
		private function removeInitSystemManagerCompleteListener (loaderInfo:LoaderInfo) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_ioErrorEventHandler (event:IOErrorEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_openEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_progressEventHandler (event:ProgressEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_securityErrorEventHandler (event:SecurityErrorEvent) : void;
		/**
		 *  @private
		 */
		private function contentLoaderInfo_unloadEventHandler (event:Event) : void;
		/**
		 *      @private
		 */
		private function initSystemManagerCompleteEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function invalidateRequestHandler (event:Event) : void;
		/**
		 *      @private
		 */
		private function mouseShieldHandler (event:Event) : void;
		/**
		 *      @private
		 */
		private function sizeShield () : void;
		/**
		 *  @private
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		private function getContentSize () : Point;
	}
}