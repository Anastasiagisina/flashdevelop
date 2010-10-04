﻿package mx.utils
{
	import flash.utils.Dictionary;
	import mx.core.mx_internal;
	import mx.utils.IXMLNotifiable;

	/**
	 *  Used for watching changes to XML and XMLList objects.
	 */
	public class XMLNotifier
	{
		/**
		 *  @private
		 */
		private static var instance : XMLNotifier;

		/**
		 *  Get the singleton instance of the XMLNotifier.
		 */
		public static function getInstance () : XMLNotifier;
		/**
		 *  @private
		 */
		static function initializeXMLForNotification () : Function;
		/**
		 *  Constructor.
		 */
		public function XMLNotifier (x:XMLNotifierSingleton);
		/**
		 *  Given an XML or XMLList, add the notification function
		 */
		public function watchXML (xml:Object, notifiable:IXMLNotifiable, uid:String = null) : void;
		/**
		 *  Given an XML or XMLList, remove the specified notification function.
		 */
		public function unwatchXML (xml:Object, notifiable:IXMLNotifiable) : void;
	}
	/**
	 *  @private
	 */
	internal class XMLNotifierSingleton
	{
		/**
		 *  Constructor.
		 */
		public function XMLNotifierSingleton ();
	}
}