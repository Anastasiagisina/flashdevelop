﻿package mx.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	import mx.events.RSLEvent;
	import mx.utils.LoaderUtil;

	/**
	 *  @private
	 */
	public class RSLItem
	{
		/**
		 *  @private
		 */
		public var urlRequest : URLRequest;
		/**
		 *  @private
		 */
		public var total : uint;
		/**
		 *  @private
		 */
		public var loaded : uint;
		/**
		 *  @private
		 */
		public var rootURL : String;
		/**
		 *  @private
		 */
		protected var url : String;
		/**
		 *  @private
		 */
		private var errorText : String;
		/**
		 *  @private
		 */
		private var completed : Boolean;
		/**
		 *  @private
		 */
		protected var chainedProgressHandler : Function;
		protected var chainedCompleteHandler : Function;
		protected var chainedIOErrorHandler : Function;
		protected var chainedSecurityErrorHandler : Function;
		protected var chainedRSLErrorHandler : Function;

		/**
		 *  Create a RSLItem with a given URL.
		 */
		public function RSLItem (url:String, rootURL:String = null);
		/**
		 * 
		 */
		public function load (progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function) : void;
		/**
		 *  @private
		 */
		public function itemProgressHandler (event:ProgressEvent) : void;
		/**
		 *  @private
		 */
		public function itemCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function itemErrorHandler (event:ErrorEvent) : void;
	}
}