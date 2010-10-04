﻿package mx.controls.fileSystemClasses
{
	import flash.filesystem.File;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.controls.fileSystemClasses.FileSystemControlHelper;
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class FileSystemTreeDataDescriptor extends DefaultDataDescriptor
	{
		/**
		 *  @private
		 */
		local var parentToChildrenMap : Object;

		/**
		 *  Constructor.
		 */
		public function FileSystemTreeDataDescriptor ();
		/**
		 *  @private
		 */
		public function getChildren (node:Object, model:Object = null) : ICollectionView;
		/**
		 *  @private
		 */
		public function isBranch (node:Object, model:Object = null) : Boolean;
		/**
		 *  @private
		 */
		public function hasChildren (node:Object, model:Object = null) : Boolean;
		/**
		 *  @private
		 */
		public function reset () : void;
		/**
		 *  @private
		 */
		public function setChildren (node:Object, children:ArrayCollection) : void;
	}
}