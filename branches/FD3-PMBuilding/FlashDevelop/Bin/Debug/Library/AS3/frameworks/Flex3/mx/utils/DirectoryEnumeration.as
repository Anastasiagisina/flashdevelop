﻿package mx.utils
{
	import flash.filesystem.File;
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;

	/**
	 *  @private
	 */
	public class DirectoryEnumeration
	{
		/**
		 *  @private
		 */
		private var extensionsSet : Object;
		/**
		 *  @private
		 */
		private var _collection : ArrayCollection;
		/**
		 *  @private
		 */
		private var _enumerationMode : String;
		/**
		 *  @private
		 */
		private var _extensions : Array;
		/**
		 *  @private
		 */
		private var _filterFunction : Function;
		/**
		 *  @private
		 */
		private var _nameCompareFunction : Function;
		/**
		 *  @private
		 */
		private var _showHidden : Boolean;
		private var _source : Array;

		/**
		 *  An ArrayCollection representing a filtered and sorted view
		 */
		public function get collection () : ArrayCollection;
		/**
		 *  A String specifying whether the <code>collection</code>
		 */
		public function get enumerationMode () : String;
		/**
		 *  @private
		 */
		public function set enumerationMode (value:String) : void;
		/**
		 *  An Array of extensions specifying which files
		 */
		public function get extensions () : Array;
		/**
		 *  @private
		 */
		public function set extensions (value:Array) : void;
		/**
		 *  A callback Function that you can use to perform additional filtering,
		 */
		public function get filterFunction () : Function;
		/**
		 *  @private
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  A callback Function that you can use to change how file and subdirectory
		 */
		public function get nameCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set nameCompareFunction (value:Function) : void;
		/**
		 *  A flag that specifies whether files and directories
		 */
		public function get showHidden () : Boolean;
		/**
		 *  @private
		 */
		public function set showHidden (value:Boolean) : void;
		/**
		 *  The source of data for the <code>collection</code>.
		 */
		public function get source () : Array;
		/**
		 *  @private
		 */
		public function set source (value:Array) : void;

		/**
		 *  Constructor.
		 */
		public function DirectoryEnumeration (source:Array = null);
		/**
		 *  Filters and sorts the <code>source</code> Array of File instances
		 */
		public function refresh () : void;
		/**
		 *  The filter function that is actually applied to filter
		 */
		public function fileFilterFunction (file:File) : Boolean;
		/**
		 *  The comparison function that is actually applied to sort
		 */
		public function fileCompareFunction (file1:File, file2:File, fields:Array = null) : int;
		/**
		 *  Performs a case-insensitive, locale-dependent comparison
		 */
		protected function defaultNameCompareFunction (name1:String, name2:String) : int;
	}
}