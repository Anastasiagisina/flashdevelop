﻿package mx.core
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManagerGlobals;

	/**
	 *  The UITextFormat class represents character formatting information
	 */
	public class UITextFormat extends TextFormat
	{
		/**
		 *  @private
		 */
		private static var _embeddedFontRegistry : IEmbeddedFontRegistry;
		/**
		 *  @private
		 */
		private static var _textFieldFactory : ITextFieldFactory;
		/**
		 *  @private
		 */
		private var systemManager : ISystemManager;
		/**
		 * @private
		 */
		private var cachedEmbeddedFont : EmbeddedFont;
		/**
		 *  Defines the anti-aliasing setting for the UITextField class.
		 */
		public var antiAliasType : String;
		/**
		 *  Defines the grid-fitting setting for the UITextField class.
		 */
		public var gridFitType : String;
		/**
		 *  @private
		 */
		private var _moduleFactory : IFlexModuleFactory;
		/**
		 *  Defines the sharpness setting for the UITextField class.
		 */
		public var sharpness : Number;
		/**
		 *  Defines the thickness setting for the UITextField class.
		 */
		public var thickness : Number;

		/**
		 *  @private
		 */
		private static function get embeddedFontRegistry () : IEmbeddedFontRegistry;
		/**
		 *  @private
		 */
		private static function get textFieldFactory () : ITextFieldFactory;
		/**
		 *  The moduleFactory used to create TextFields for embedded fonts.
		 */
		public function get moduleFactory () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set moduleFactory (value:IFlexModuleFactory) : void;

		/**
		 *  Constructor.
		 */
		public function UITextFormat (systemManager:ISystemManager, font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null);
		/**
		 *  Returns measurement information for the specified text, 
		 */
		public function measureText (text:String, roundUp:Boolean = true) : TextLineMetrics;
		/**
		 *  Returns measurement information for the specified HTML text, 
		 */
		public function measureHTMLText (htmlText:String, roundUp:Boolean = true) : TextLineMetrics;
		/**
		 *  @private
		 */
		private function measure (s:String, html:Boolean, roundUp:Boolean) : TextLineMetrics;
		/**
		 * @private
		 */
		private function getEmbeddedFont (fontName:String, bold:Boolean, italic:Boolean) : EmbeddedFont;
		/**
		 *  @private
		 */
		function copyFrom (source:TextFormat) : void;
	}
}