﻿package mx.controls.fileSystemClasses
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	import mx.collections.ArrayCollection;
	import mx.controls.FileSystemEnumerationMode;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.mx_internal;
	import mx.events.FileEvent;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.DirectoryEnumeration;

	/**
	 *  @private
	 */
	public class FileSystemControlHelper
	{
		/**
		 *  @private
		 */
		public static var COMPUTER : File;
		/**
		 *  @private
		 */
		local var owner : Object;
		/**
		 *  @private
		 */
		local var hierarchical : Boolean;
		/**
		 *  @private
		 */
		local var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _directory : File;
		/**
		 *  @private
		 */
		private var directoryChanged : Boolean;
		/**
		 *  @private
		 */
		local var directoryEnumeration : DirectoryEnumeration;
		/**
		 *  @private
		 */
		private var _enumerationMode : String;
		/**
		 *  @private
		 */
		private var enumerationModeChanged : Boolean;
		/**
		 *  @private
		 */
		private var _extensions : Array;
		/**
		 *  @private
		 */
		private var extensionsChanged : Boolean;
		/**
		 *  @private
		 */
		private var _filterFunction : Function;
		/**
		 *  @private
		 */
		private var filterFunctionChanged : Boolean;
		/**
		 *  @private
		 */
		public var history : Array;
		/**
		 *  @private
		 */
		public var historyIndex : int;
		/**
		 *  @private
		 */
		private var _nativePathToIndexMap : Object;
		/**
		 *  @private
		 */
		private var _itemArray : Array;
		/**
		 *  @private
		 */
		private var _nameCompareFunction : Function;
		/**
		 *  @private
		 */
		private var nameCompareFunctionChanged : Boolean;
		/**
		 *  @private
		 */
		private var pendingOpenPaths : Array;
		/**
		 *  @private
		 */
		private var pendingSelectedPaths : Array;
		/**
		 *  @private
		 */
		private var _showExtensions : Boolean;
		/**
		 *  @private
		 */
		private var _showHidden : Boolean;
		/**
		 *  @private
		 */
		private var showHiddenChanged : Boolean;
		/**
		 *  @private
		 */
		private var _showIcons : Boolean;

		/**
		 *  @private
		 */
		public function get backHistory () : Array;
		/**
		 *  @private
		 */
		public function get canNavigateBack () : Boolean;
		/**
		 *  @private
		 */
		public function get canNavigateDown () : Boolean;
		/**
		 *  @private
		 */
		public function get canNavigateForward () : Boolean;
		/**
		 *  @private
		 */
		public function get canNavigateUp () : Boolean;
		/**
		 *  @private
		 */
		public function get directory () : File;
		/**
		 *  @private
		 */
		public function set directory (value:File) : void;
		/**
		 *  @private
		 */
		public function get enumerationMode () : String;
		/**
		 *  @private
		 */
		public function set enumerationMode (value:String) : void;
		/**
		 *  @private
		 */
		public function get extensions () : Array;
		/**
		 *  @private
		 */
		public function set extensions (value:Array) : void;
		/**
		 *  @private
		 */
		public function get filterFunction () : Function;
		/**
		 *  @private
		 */
		public function set filterFunction (value:Function) : void;
		/**
		 *  @private
		 */
		public function get forwardHistory () : Array;
		/**
		 *  @private
		 */
		function get nativePathToIndexMap () : Object;
		/**
		 *  @private
		 */
		function get itemArray () : Array;
		/**
		 *  @private
		 */
		public function get nameCompareFunction () : Function;
		/**
		 *  @private
		 */
		public function set nameCompareFunction (value:Function) : void;
		/**
		 *  An Array of <code>nativePath</code> Strings for the File items
		 */
		public function get openPaths () : Array;
		/**
		 *  @private
		 */
		public function set openPaths (value:Array) : void;
		/**
		 *  @private
		 */
		public function get selectedPath () : String;
		/**
		 *  @private
		 */
		public function set selectedPath (value:String) : void;
		/**
		 *  @private
		 */
		public function get selectedPaths () : Array;
		/**
		 *  @private
		 */
		public function set selectedPaths (value:Array) : void;
		/**
		 *  @private
		 */
		public function get showExtensions () : Boolean;
		/**
		 *  @private
		 */
		public function set showExtensions (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get showHidden () : Boolean;
		/**
		 *  @private
		 */
		public function set showHidden (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get showIcons () : Boolean;
		/**
		 *  @private
		 */
		public function set showIcons (value:Boolean) : void;

		/**
		 *  @private
		 */
		private static function initClass () : void;
		/**
		 *  @private
		 */
		private static function fileSystemIsCaseInsensitive () : Boolean;
		/**
		 *  Constructor.
		 */
		public function FileSystemControlHelper (owner:Object, hierarchical:Boolean);
		/**
		 *  @private
		 */
		public function commitProperties () : void;
		/**
		 *  Fills the list by enumerating the current directory
		 */
		function fill () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function setDirectory (value:File) : void;
		/**
		 *  @private
		 */
		function setDataProvider (value:Array) : void;
		/**
		 *  @private
		 */
		public function itemToUID (data:Object) : String;
		/**
		 *  @private
		 */
		public function isComputer (f:File) : Boolean;
		/**
		 *  @private
		 */
		private function getRootDirectories () : Array;
		/**
		 *  @private
		 */
		public function fileIconFunction (item:File) : Class;
		/**
		 *  @private
		 */
		public function fileLabelFunction (item:File, column:DataGridColumn = null) : String;
		/**
		 *  @private
		 */
		public function findIndex (nativePath:String) : int;
		/**
		 *  @private
		 */
		public function findItem (nativePath:String) : File;
		/**
		 *  @private
		 */
		function itemsChanged () : void;
		/**
		 *  @private
		 */
		private function rebuildEnumerationInfo () : void;
		/**
		 *  @private
		 */
		private function addItemToEnumerationInfo (index:int, item:File) : void;
		/**
		 *  @private
		 */
		private function enumerateItems (itemCallback:Function) : int;
		/**
		 *  @private
		 */
		private function enumerate (items:ArrayCollection, index:int, itemCallback:Function) : int;
		/**
		 *  @private
		 */
		public function navigateDown () : void;
		/**
		 *  @private
		 */
		public function navigateUp () : void;
		/**
		 *  @private
		 */
		public function navigateBack (index:int = 0) : void;
		/**
		 *  @private
		 */
		public function navigateForward (index:int = 0) : void;
		/**
		 *  @private
		 */
		private function navigateBy (n:int) : void;
		/**
		 *  @private
		 */
		public function navigateTo (directory:File) : void;
		/**
		 *  @private
		 */
		public function refresh () : void;
		/**
		 *  @private
		 */
		private function getOpenPaths () : Array;
		/**
		 *  @private
		 */
		private function getSelectedPaths () : Array;
		/**
		 *  @private
		 */
		private function getFirstVisiblePath () : String;
		/**
		 *  @private
		 */
		private function setOpenPaths (openPaths:Array) : void;
		/**
		 *  @private
		 */
		private function setSelectedPaths (selectedPaths:Array) : void;
		/**
		 *  @private
		 */
		private function setFirstVisiblePath (path:String) : Boolean;
		/**
		 *  @private
		 */
		public function clear () : void;
		/**
		 *  @private
		 */
		public function resetHistory (directory:File) : void;
		/**
		 *  @private
		 */
		private function pushHistory (directory:File) : void;
		/**
		 *  @private
		 */
		public function getParentChain (file:File) : Array;
		/**
		 *  @private
		 */
		function dispatchDirectoryChangingEvent (newDirectory:File) : Boolean;
		/**
		 *  @private
		 */
		function dispatchFileChooseEvent (file:File) : void;
		/**
		 *  @private
		 */
		private function getBackDirectory () : File;
		/**
		 *  @private
		 */
		private function getForwardDirectory () : File;
		/**
		 *  @private
		 */
		private function updateCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		public function itemDoubleClickHandler (event:ListEvent) : void;
		/**
		 *  @private
		 */
		public function handleKeyDown (event:KeyboardEvent) : Boolean;
	}
}