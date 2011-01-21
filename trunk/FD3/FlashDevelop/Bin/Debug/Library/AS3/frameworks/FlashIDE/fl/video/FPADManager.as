﻿package fl.video
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;

	/**
	 * <p>Handles downloading and parsing fpad xml format for
	 */
	public class FPADManager
	{
		private var _owner : INCManager;
		local var xml : XML;
		local var xmlLoader : URLLoader;
		local var rtmpURL : String;
		local var _url : String;
		local var _uriParam : String;
		local var _parseResults : ParseResults;

		/**
		 * constructor
		 */
		public function FPADManager (owner:INCManager);
		/**
		 * <p>Starts download of XML file.  Will be parsed and based
		 */
		function connectXML (urlPrefix:String, uriParam:String, urlSuffix:String, uriParamParseResults:ParseResults) : Boolean;
		/**
		 * <p>Handles load of XML.
		 */
		function xmlLoadEventHandler (e:Event) : void;
	}
}