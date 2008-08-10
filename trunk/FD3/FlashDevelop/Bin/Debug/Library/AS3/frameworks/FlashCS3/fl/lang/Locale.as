﻿package fl.lang
{
import flash.system.Capabilities;
import flash.xml.*;
import flash.net.*;
import flash.events.*;

/**
* The fl.lang.Locale class allows you to control how multilanguage text is displayed in a SWF file.  * The Flash Strings panel allows you to use string IDs instead of string literals in dynamic text fields. This allows you to create a SWF file that displays text loaded from a language-specific XML file. The XML file must use the XML Localization Interchange File Format (XLIFF). There are three ways to display the language-specific strings contained in the XLIFF files: * <ul> *   <li><code>"automatically at runtime"</code>&#x2014;Flash Player replaces string IDs with strings from the XML file matching the default system language code returned by flash.system.capabilities.language.</li> *   <li><code>"manually using stage language"</code>&#x2014;String IDs are replaced by strings at compile time and cannot be changed by Flash Player.</li> *   <li><code>"via ActionScript at runtime"</code>&#x2014;String ID replacement is controlled using ActionScript at runtime. This option gives you control over both the
*/
public class Locale extends flash.events.EventDispatcher
{
		private static var flaName : String;
		private static var defaultLang : String;
		private static var xmlLang : String;
		private static var xmlMap : Object;
		private static var xmlDoc : XMLDocument;
		private static var stringMap : Object;
		private static var delayedInstanceArray : Array;
		private static var currentXMLMapIndex : Number;
		private static var callback : Function;
		private static var autoReplacement : Boolean;
		private static var currentLang : String;
		private static var stringMapList : Object;
		private static var _xmlLoaded : Boolean;

	/**
	* Determines whether strings are replaced automatically after loading the XML file. If set to <code>true</code>, the text      replacement method is equivalent to the Strings panel setting <code>"automatically at runtime"</code>. This means that Flash Player      will determine the default language of the host environment and automatically display the text in that language. If set to <code>     false</code>, the text replacement method is equivalent to the Strings panel setting <code>"via ActionScript at runtime"</code>.      This means that you are responsible for loading the appropriate XML file to display the text.     *     * <p>The default value of this property reflects the setting that you select for Replace strings in the Strings panel dialog box:      <code>true</code> for <code>"automatically at runtime"</code> (the default setting) and <code>false</code> for "via ActionScript at      runtime". </p>     *     * @example The following example uses the <code>Locale.autoReplace</code>
	*/
		public static function get autoReplace () : Boolean;

		public static function set autoReplace (auto:Boolean) : Void;

	/**
	* An array containing language codes for the languages that have been specified or loaded into the FLA file. The language codes are not sorted alphabetically.     *      * @example The following example loads a language XML file based on the current value of a ComboBox component. You drag a ComboBox component onto the Stage and give it an instance name of <code>lang_cb</code>. Using the Text tool, you create a dynamic text field and give it an instance name of <code>greeting_txt</code>. In the Strings panel, you add at least two active languages, set the replace strings radio option to <code>"via ActionScript at runtime"</code>, and click OK. Next, you add a string ID of <b>IDS_GREETING</b> and enter text for each active language. Finally, you add the following ActionScript code to Frame 1 of the main Timeline:     * <listing>     * Locale.setLoadCallback(localeListener);     * lang_cb.dataProvider = Locale.languageCodeArray.sort();     * lang_cb.addEventListener("change", langListener);     *
	*/
		public static function get languageCodeArray () : Array;

	/**
	* An array containing all the string IDs in the FLA file. The string IDs are not sorted alphabetically.     *      * @example The following example traces the <code>Locale.stringIDArray</code> property for the currently loaded language XML file.      Click the Settings button in the Strings panel to open the Settings dialog box. Next, you add two active languages: English (en) and     French (fr), set the replace strings radio control to <code>"via ActionScript at runtime"</code>, and click OK. In the Strings      panel, you add a string ID of <b>IDS_GREETING</b>, and then add text for each active language.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("fr");     * function localeCallback(success:Boolean) {     *  trace(success);     *  trace(Locale.stringIDArray); // IDS_GREETING     *  trace(Locale.loadStringEx("IDS_GREETING", "fr")); // bonjour     * }     * </listing>     * @playerversion Flash 9     * @langversion 3.0     * @helpid
	*/
		public static function get stringIDArray () : Array;

	/**
	* @private No need to document this, users won't need it. This is old code that isn't used by Flash Player 8,      * but is used when SWFs are published for Flash Player 7.
	*/
		public static function setFlaName (name:String) : void;
	/**
	* The default language code as set in the Strings panel dialog box or by calling the <code>setDefaultLang()</code> method.     *      * @return Returns the default language code.     *      * @example The following example creates a variable called <code>defLang</code>, which is used to hold the initial default language      for the Flash document. You click the Settings button in the Strings panel to launch the Settings dialog box. Then you add two active      languages: English (en) and French (fr), set the replace strings radio control to <code>"via ActionScript at runtime"</code>, and      click OK. In the Strings panel, you add a string ID of <b>IDS_GREETING</b>, and then add text for each active language.     * <listing>     * var defLang:String = "fr";     * Locale.setDefaultLang(defLang);     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML(Locale.getDefaultLang());     * function localeCallback(success:Boolean) {     *  if (success) {     *      trace(Local
	*/
		public static function getDefaultLang () : String;
	/**
	* Sets the default language code.     * @param langCode A string representing a language code.     *      * @example The following example creates a variable called <code>defLang</code>, which is used to hold the initial default language for the Flash document. You click the Settings button in the Strings panel to open the Settings dialog box. Then you add two active languages: English (en) and French (fr), set the replace strings radio control to <code>"via ActionScript at runtime"</code>, and click OK. In the Strings panel, you add a string ID of <b>IDS_GREETING</b>, and then add text for each active language.     * <listing>     * var defLang:String = "fr";     * Locale.setDefaultLang(defLang);     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML(Locale.getDefaultLang());     * function localeCallback(success:Boolean) {     *  if (success) {     *      trace(Locale.stringIDArray); // IDS_GREETING     *      trace(Locale.loadString("IDS_GREETING"));     *  } else {
	*/
		public static function setDefaultLang (langCode:String) : void;
	/**
	* Adds the {languageCode and languagePath} pair into the internal array for later use.     * This is primarily used by Flash when the strings replacement method is <code>"automatically at runtime"</code>     * or <code>"via ActionScript at runtime"</code>.      * @param langCode The language code.     * @param path The XML path to add.     *      * @example The following example uses the <code>setInterval()</code> method to check whether the language XML file has successfully      loaded.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("en");     * // create interval to check if language XML file is loaded     * var locale_int:Number = setInterval(checkLocaleStatus, 10);     * function checkLocaleStatus():void {     *  if (Locale.checkXMLStatus()) {     *      clearInterval(locale_int);     *      trace("clearing interval &#64; " + getTimer() + " ms");     *  }     * }     * // callback function for Locale.setLoadCallback()     * function l
	*/
		public static function addXMLPath (langCode:String, path:String) : void;
	/**
	* Adds the {instance, string ID} pair into the internal array for later use.     * This is primarily used by Flash when the strings replacement method is <code>"automatically at runtime"</code>.      * @param instance Instance name of the text field to populate.     * @param stringID Language string ID.     *      * @example The following example uses the <code>autoReplace</code> property and <code>addDelayedInstance()</code> method to populate     a text field on the Stage with the <code>IDS_GREETING</code> string from the English XML language file.     * <listing>     * greeting_txt.autoSize = TextFieldAutoSize.LEFT;     * Locale.autoReplace = true;     * Locale.addDelayedInstance(greeting_txt, "IDS_GREETING");     * Locale.loadLanguageXML("en");     * </listing>     * @playerversion Flash 9     * @langversion 3.0      * @helpid      * @category Method
	*/
		public static function addDelayedInstance (instance:Object, stringID:String);
	/**
	* Returns <code>true</code> if the XML file is loaded; <code>false</code> otherwise.      * @return Returns <code>true</code> if the XML file is loaded; <code>false</code> otherwise.     *      * @example The following example uses an interval to check every 10 milliseconds to see if the language file has successfully      loaded. Once the XML file has loaded, the <code>greeting_txt</code> text field instance on the Stage is populated with the      <code>IDS_GREETING</code> string from the language XML file.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("en");     * // create interval to check if language XML file is loaded     * var locale_int:Number = setInterval(checkLocaleStatus, 10);     * function checkLocaleStatus():void {     *  if (Locale.checkXMLStatus()) {     *      clearInterval(locale_int);     *      trace("clearing interval &#64; " + getTimer() + " ms");     *  }     * }     * // callback function for Locale.setLoadCallback()
	*/
		public static function checkXMLStatus () : Boolean;
	/**
	* Sets the callback function that is called after the XML file is loaded.     * @param loadCallback The function to call when the XML language file loads.     *      * @example The following example uses an interval to check every 10 milliseconds to see if the language file has successfully      loaded. Once the XML file has loaded, the <code>greeting_txt</code> text field instance on the Stage is populated with the      <code>IDS_GREETING</code> string from the XML language file.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("en");     * // create interval to check if language XML file is loaded     * var locale_int:Number = setInterval(checkLocaleStatus, 10);     * function checkLocaleStatus():void {     *  if (Locale.checkXMLStatus()) {     *      clearInterval(locale_int);     *      trace("clearing interval &#64; " + getTimer() + " ms");     *  }     * }     * // callback function for Locale.setLoadCallback()     * function localeCallba
	*/
		public static function setLoadCallback (loadCallback:Function);
	/**
	* Returns the string value associated with the given string ID in the current language.     * @param id The identification (ID) number of the string to load.     * @return The string value associated with the given string ID in the current language.     *      * @example The following example uses an interval to check every 10 milliseconds to see if the language file has successfully      loaded. Once the XML file has loaded, the <code>greeting_txt</code> text field instance on the Stage is populated with the      <code>IDS_GREETING</code> string from the XML language file.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("en");     * // create interval to check if language XML file is loaded     * var locale_int:Number = setInterval(checkLocaleStatus, 10);     * function checkLocaleStatus():void {     *  if (Locale.checkXMLStatus()) {     *      clearInterval(locale_int);     *      trace("clearing interval &#64; " + getTimer() + " ms");     *
	*/
		public static function loadString (id:String) : String;
	/**
	* Returns the string value associated with the given string ID and language code.     * To avoid unexpected XML file loading, <code>loadStringEx()</code> does not load the XML language file if the XML file is not      already loaded. You should decide on the right time to call the <code>loadLanguageXML()</code> method if you want to load a XML      language file.     * @param stringID The identification (ID) number of the string to load.     * @param languageCode The language code.     * @return The string value associated with the given string ID in the language specified by the <code>languageCode</code> parameter.     *      * @example The following example uses the <code>loadStringEx()</code> method to trace the value of the <code>IDS_GREETING</code>      string for the currently loaded French language XML file.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("fr");     * function localeCallback(success:Boolean) {     *  trace(success);     *
	*/
		public static function loadStringEx (stringID:String, languageCode:String) : String;
	/**
	* Sets the new string value of a given string ID and language code.     *     * @param stringID The identification (ID) number of the string to set.     * @param languageCode The language code.     * @param stringValue A string value.     *     * @example The following example uses the <code>setString()</code> method to set the <code>IDS_WELCOME</code> string for both English     (en) and French (fr).     * <listing>     * Locale.setString("IDS_WELCOME", "en", "hello");     * Locale.setString("IDS_WELCOME", "fr", "bonjour");     * trace(Locale.loadStringEx("IDS_WELCOME", "en")); // hello     * </listing>     *     * @playerversion Flash 9     * @langversion 3.0      * @helpid      * @category Method
	*/
		public static function setString (stringID:String, languageCode:String, stringValue:String) : void;
	/**
	* Automatically determines the language to use and loads the XML language file.     * This is primarily used by Flash when the strings replacement method is <code>"automatically at runtime"</code>.     *      * @example This example shows how to use the <code>initialize()</code> method to automatically populate the <code>greeting_txt     </code> text field on the Stage with the user's current OS language. Instead of using the <code>initialize()</code> method directly,     use the string replacement method of <code>"automatically at runtime"</code>.     * <listing>     * trace(System.capabilities.language);     * Locale.autoReplace = true;     * Locale.addDelayedInstance(greeting_txt, "IDS_GREETING");     * Locale.initialize();     * </listing>     * @playerversion Flash 9     * @langversion 3.0      * @helpid      * @category Method
	*/
		public static function initialize () : void;
	/**
	* Loads the specified XML language file.     *      * @param xmlLanguageCode The language code for the XML language file that you want to load.     * @param customXmlCompleteCallback Custom callback function to call when XML language file loads.     *      * @example The following example uses the <code>loadLanguageXML()</code> method to load the English (en) XML language file. Once the     language file loads, the <code>localeCallback()</code> method is called and populates the <code>greeting_txt</code> text field on      the Stage with the contents of the <code>IDS_GREETING</code> string in the XML file.     * <listing>     * Locale.setLoadCallback(localeCallback);     * Locale.loadLanguageXML("en");     * // create interval to check if language XML file is loaded     * var locale_int:Number = setInterval(checkLocaleStatus, 10);     * function checkLocaleStatus():void {     *  if (Locale.checkXMLStatus()) {     *      clearInterval(locale_int);     *      trace("clearing interval &#64
	*/
		public static function loadLanguageXML (xmlLanguageCode:String, customXmlCompleteCallback:Function =null) : void;
		private static function loadXML (langCode:String);
		private static function onXMLLoad (eventObj:Event);
		private static function parseStringsXML (doc:XMLDocument) : void;
		private static function parseXLiff (node:XMLNode) : void;
		private static function parseFile (node:XMLNode) : void;
		private static function parseBody (node:XMLNode) : void;
		private static function parseTransUnit (node:XMLNode) : void;
		private static function parseSource (node:XMLNode) : String;
		private static function assignDelayedInstances () : void;
}
}
