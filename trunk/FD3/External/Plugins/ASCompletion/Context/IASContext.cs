/*
 * Required Interface between ASFileParser 
 * and the application using the parser
 */

using System;
using System.Collections;
using ASCompletion.Model;
using ASCompletion.Settings;
using ASCompletion.Completion;
using System.Collections.Generic;

namespace ASCompletion.Context
{
	public interface IASContext
    {
        #region Types resolution
        /// <summary>
		/// Add additional classpathes
		/// </summary>
        void SetExternalClassPath(string classPath);

        /// <summary>
        /// Update the class/member context for the given line number.
        /// Be carefull to restore the context after calling it with a custom line number
        /// </summary>
        /// <param name="line"></param>
        void UpdateContext(int line);

        /// <summary>
        /// Resolve the class and member at the provided line number
        /// </summary>
        /// <param name="line"></param>
        /// <returns></returns>
        ASResult GetDeclarationAtLine(int line);

		/// <summary>
        /// Top-level elements lookup
        /// </summary>
        /// <param name="token">Element to search</param>
        /// <param name="result">Response structure</param>
        void ResolveTopLevelElement(string token, ASResult result);

		/// <summary>
		/// Retrieves a class model from its name
		/// </summary>
		/// <param name="cname">Class (short or full) name</param>
		/// <param name="inClass">Current file</param>
		/// <returns>A parsed class or an empty ClassModel if the class is not found</returns>
		ClassModel ResolveType(string cname, FileModel inFile);

        /// <summary>
        /// Update model if needed and warn user if it has problems
        /// </summary>
        /// <param name="onFileOpen">Flag indicating it is the first model check</param>
        void CheckModel(bool onFileOpen);

        /// <summary>
        /// Parse a packaged library file
        /// </summary>
        /// <param name="path">Models owner</param>
        void ExploreVirtualPath(PathModel path);

        /// <summary>
        /// Called afer:
        /// - a PathExplorer has finished exploring
        /// - a PathModel has some internal change
        /// - an import was generated
        /// Warning: can be called many times.
        /// </summary>
        /// <param name="path">File or classname</param>
        void RefreshContextCache(string path);
        
        /// <summary>
        /// Create a new file model using the default file parser
        /// </summary>
        /// <param name="filename">Full path</param>
        /// <returns>File model</returns>
		FileModel GetFileModel(string fileName);

        /// <summary>
        /// Parse a raw source code
        /// </summary>
        /// <param name="src"></param>
        /// <returns></returns>
        FileModel GetCodeModel(string src);

        /// <summary>
        /// Retrieve a fully qualified class in classpath
        /// </summary>
        /// <param name="package"></param>
        /// <param name="cname"></param>
        /// <param name="inPackage">Package reference for resolution</param>
        /// <returns></returns>
        ClassModel GetModel(string package, string cname, string inPackage);

        /// <summary>
        /// Called if a FileModel needs filtering
        /// </summary>
        /// <param name="src"></param>
        /// <returns></returns>
        string FilterSource(string src);

        /// <summary>
        /// Called if a FileModel needs filtering
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        void FilterSource(FileModel model);

		/// <summary>
        /// Return the elements (package, types, etc) visible from the current file
        /// </summary>
        /// <param name="typesOnly">Return only packages and types</param>
        /// <returns></returns>
        MemberList GetVisibleExternalElements(bool typesOnly);

        /// <summary>
        /// Return the full project classes list
        /// </summary>
        /// <returns></returns>
        MemberList GetAllProjectClasses();

        /// <summary>
        /// Retrieves a package content
        /// </summary>
        /// <param name="name">Package path</param>
        /// <param name="onlyUserDefined">Ignore language's intrinsic pathes</param>
        /// <returns>Package folders and types</returns>
        FileModel ResolvePackage(string name, bool onlyUserDefined);

		/// <summary>
        /// Return imported classes list (not null)
		/// </summary>
		/// <param name="package">Package to explore</param>
		/// <param name="inFile">Current file</param>
        MemberList ResolveImports(FileModel inFile);

        /// <summary>
        /// Check if a type is already in the file's imports
        /// </summary>
        /// <param name="member">Element to search in imports</param>
        /// <param name="atLine">Position in the file</param>
        bool IsImported(MemberModel member, int atLine);

        /// <summary>
        /// Returns the default inherited type for the given class
        /// </summary>
        /// <param name="package">File package</param>
        /// <param name="classname">Class name</param>
        /// <returns>Inherited type</returns>
        string DefaultInheritance(string package, string classname);

        /// <summary>
        /// Evaluates the visibility of one given type from another
        /// </summary>
        /// <param name="inClass"></param>
        /// <param name="withClass"></param>
        /// <returns>Completion visibility</returns>
        Visibility TypesAffinity(ClassModel inClass, ClassModel withClass);

        /// <summary>
        /// Track text modifications
        /// </summary>
        void TrackTextChange(ScintillaNet.ScintillaControl sender, int position, int length, int linesAdded);

        /// <summary>
		/// Set current model out-of-date to force re-parse of the code when needed
		/// </summary>
		void SetOutOfDate();

		/// <summary>
		/// Flag the model as up to date
        /// <returns>Model state before reseting the flag</returns>
		/// </summary>
        bool UnsetOutOfDate();
        #endregion

        #region Specific actions
        /// <summary>
        /// Clear context state and classpaths
        /// </summary>
        void Reset();

        /// <summary>
        /// Check current file's syntax
        /// </summary>
        void CheckSyntax();

        /// <summary>
        /// Retrieve the context's default compiler path
        /// </summary>
        string GetCompilerPath();

        /// <summary>
        /// Delete current class's cached file of the compiler
        /// </summary>
        void RemoveClassCompilerCache();

        /// <summary>
		/// Generate an instrinsic class
		/// </summary>
		/// <param name="files">Semicolon-separated source & destination files</param>
        void MakeIntrinsic(string files);

        /// <summary>
		/// Browse to the first package folder in the classpath
		/// </summary>
		/// <param name="package">Package to show in the Files Panel</param>
		/// <returns>A folder was found and displayed</returns>
        bool BrowseTo(string package);

        /// <summary>
        /// Run the command-line compiler in the current files's context
        /// </summary>
        /// <param name="append">Additional compiler switches</param>
        void RunCMD(string append);

        /// <summary>
		/// Calls compiler with default/automatic parameters (ie. quick build)
		/// </summary>
        bool BuildCMD(bool failSilently);

        /// <summary>
		/// End of the CMD execution
		/// </summary>
		/// <param name="result">Execution result</param>
        void OnProcessEnd(string result);

        /// <summary>
        /// When an item from the completion list is inserted
        /// </summary>
        /// <param name="sci"></param>
        /// <param name="position"></param>
        /// <param name="text"></param>
        /// <returns>Indicator that the event is handled</returns>
        bool OnCompletionInsert(ScintillaNet.ScintillaControl sci, int position, string text);

        /// <summary>
        /// When selecting a node in the outline view
        /// </summary>
        /// <param name="node"></param>
        void OnSelectOutlineNode(System.Windows.Forms.TreeNode node);

        #endregion

        #region Custom code completion
        /// <summary>
        /// Let contexts handle code completion
        /// </summary>
        /// <param name="sci">Scintilla control</param>
        /// <param name="expression">Completion context</param>
        /// <param name="autoHide">Auto-started completion (is false when pressing Ctrl+Space)</param>
        /// <returns>Null (not handled) or member list</returns>
        MemberList ResolveDotContext(ScintillaNet.ScintillaControl sci, ASExpr expression, bool autoHide);

        /// <summary>
        /// Let contexts resolve function at give position
        /// </summary>
        /// <param name="sci">Scintilla control</param>
        /// <param name="expression">Completion context</param>
        /// <returns>Null (not handled) or function signature</returns>
        MemberModel ResolveFunctionContext(ScintillaNet.ScintillaControl sci, ASExpr expression);
        #endregion

        #region Properties

        IContextSettings Settings { get; }

        /// <summary>
        /// Tells completion engine the language features
        /// </summary>
        ContextFeatures Features { get; }

        /// <summary>
        /// Default types/member visibility
        /// </summary>
        Visibility DefaultVisibility { get; }

        /// <summary>
        /// Top-level elements
        /// </summary>
        FileModel TopLevel { get; }

        string CurrentFile { get; set; }
        int CurrentLine { get; set; }
        FileModel CurrentModel { get; }

        /// <summary>
        /// Class at cursor position
        /// - must never be null: use ClassModel.VoidClass
        /// </summary>
        ClassModel CurrentClass { get; }

        /// <summary>
        /// Member at cursor position (can be null)
        /// </summary>
        MemberModel CurrentMember { get; }

        /// <summary>
        /// Language classpath
        /// </summary>
        List<PathModel> Classpath { get; }

        /// <summary>
        /// Completion happens in an AS3 class private section
        /// </summary>
        bool InPrivateSection { get; }

        /// <summary>
        /// File is valid for completion
        /// </summary>
        bool IsFileValid { get; }

        #endregion
    }
}
