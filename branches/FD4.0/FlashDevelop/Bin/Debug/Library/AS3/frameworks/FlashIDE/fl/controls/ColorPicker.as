﻿package fl.controls
{
	import fl.core.UIComponent;
	import fl.core.InvalidationType;
	import fl.controls.BaseButton;
	import fl.controls.TextInput;
	import fl.controls.TextArea;
	import fl.events.ComponentEvent;
	import fl.events.ColorPickerEvent;
	import fl.managers.IFocusManager;
	import fl.managers.IFocusManagerComponent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.system.IME;

	/**
	 * Dispatched when the user opens the color palette.
	 */
	[Event(name="open", type="flash.events.Event")] 
	/**
	 * Dispatched when the user closes the color palette.
	 */
	[Event(name="close", type="flash.events.Event")] 
	/**
	 * Dispatched when the user clicks a color in the palette.
	 */
	[Event(name="change", type="fl.events.ColorPickerEvent")] 
	/**
	 * Dispatched when the user rolls over a swatch in the color palette.
	 */
	[Event(name="itemRollOver", type="fl.events.ColorPickerEvent")] 
	/**
	 * Dispatched when the user rolls out of a swatch in the color palette.
	 */
	[Event(name="itemRollOut", type="fl.events.ColorPickerEvent")] 
	/**
	 * Dispatched when the user presses the Enter key after editing the internal text field of the ColorPicker component.
	 */
	[Event(name="enter", type="fl.events.ColorPickerEvent")] 
	/**
	 * Defines the padding that appears around each swatch in the color palette, in pixels.
	 */
	[Style(name="swatchPadding", type="Number", format="Length")] 
	/**
	 * The class that provides the skin for a disabled button in the ColorPicker.
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 * The padding that appears around the color TextField, in pixels.
	 */
	[Style(name="textPadding", type="Number", format="Length")] 
	/**
	 * The class that provides the skin for the color well when the pointing device rolls over it.
	 */
	[Style(name="overSkin", type="Class")] 
	/**
	 * The padding that appears around the group of color swatches, in pixels.
	 */
	[Style(name="backgroundPadding", type="Number", format="Length")] 
	/**
	 * The class that provides the skin for the color well when it is filled with a color.
	 */
	[Style(name="colorWell", type="Class")] 
	/**
	 * The class that provides the skin for the ColorPicker button when it is in the down position.
	 */
	[Style(name="downSkin", type="Class")] 
	/**
	 * The class that provides the background for the text field of the ColorPicker component.
	 */
	[Style(name="textFieldSkin", type="Class")] 
	/**
	 * The class that provides the background of the palette that appears in the ColorPicker component. 
	 */
	[Style(name="background", type="Class")] 
	/**
	 * The class that provides the skin which is used to draw the swatches contained in the ColorPicker component.
	 */
	[Style(name="swatchSkin", type="Class")] 
	/**
	 * The class that provides the skin which is used to highlight the currently selected color.
	 */
	[Style(name="swatchSelectedSkin", type="Class")] 
	/**
	 * The width of each swatch, in pixels.
	 */
	[Style(name="swatchWidth", type="Number", format="Length")] 
	/**
	 * The height of each swatch, in pixels.
	 */
	[Style(name="swatchHeight", type="Number", format="Length")] 
	/**
	 * The number of columns to be drawn in the ColorPicker color palette.
	 */
	[Style(name="columnCount", type="Number", format="Length")] 
	/**
	 * The class that provides the skin for the ColorPicker button when it is in the up position.
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:embedFonts
	 */
	[Style(name="embedFonts", type="Boolean")] 

	/**
	 * The ColorPicker component displays a list of one or more swatches 
	 */
	public class ColorPicker extends UIComponent implements IFocusManagerComponent
	{
		/**
		 * A reference to the internal text field of the ColorPicker component.
		 */
		public var textField : TextField;
		/**
		 * @private (protected)
		 */
		protected var customColors : Array;
		/**
		 * @private (protected)
		 */
		public static var defaultColors : Array;
		/**
		 * @private (protected)
		 */
		protected var colorHash : Object;
		/**
		 * @private (protected)
		 */
		protected var paletteBG : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var selectedSwatch : Sprite;
		/**
		 * @private (protected)
		 */
		protected var _selectedColor : uint;
		/**
		 * @private (protected)
		 */
		protected var rollOverColor : int;
		/**
		 * @private (protected)
		 */
		protected var _editable : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _showTextField : Boolean;
		/**
		 * @private (protected)
		 */
		protected var isOpen : Boolean;
		/**
		 * @private (protected)
		 */
		protected var doOpen : Boolean;
		/**
		 * @private (protected)
		 */
		protected var swatchButton : BaseButton;
		/**
		 * @private (protected)
		 */
		protected var colorWell : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var swatchSelectedSkin : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var palette : Sprite;
		/**
		 * @private (protected)
		 */
		protected var textFieldBG : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var swatches : Sprite;
		/**
		 * @private (protected)
		 */
		protected var swatchMap : Array;
		/**
		 * @private (protected)
		 */
		protected var currRowIndex : int;
		/**
		 * @private (protected)
		 */
		protected var currColIndex : int;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;
		/**
		 * @private (protected)
		 */
		protected static const POPUP_BUTTON_STYLES : Object;
		/**
		 * @private (protected)
		 */
		protected const SWATCH_STYLES : Object;

		/**
		 * Gets or sets the swatch that is currently highlighted in the palette of the ColorPicker component.
		 */
		public function get selectedColor () : uint;
		/**
		 * @private (setter)
		 */
		public function set selectedColor (value:uint) : void;
		/**
		 * Gets the string value of the current color selection.
		 */
		public function get hexValue () : String;
		/**
		 * @copy fl.core.UIComponent#enabled
		 */
		public function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the internal text field of the
		 */
		public function get editable () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set editable (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the internal text field 
		 */
		public function get showTextField () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set showTextField (value:Boolean) : void;
		/**
		 * Gets or sets the array of custom colors that the ColorPicker component
		 */
		public function get colors () : Array;
		/**
		 * @private (setter)
		 */
		public function set colors (value:Array) : void;
		/**
		 * @copy fl.controls.TextArea#imeMode
		 */
		public function get imeMode () : String;
		/**
		 * @private (protected)
		 */
		public function set imeMode (value:String) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Shows the color palette. Calling this method causes the <code>open</code> 
		 */
		public function open () : void;
		/**
		 * Hides the color palette. Calling this method causes the <code>close</code> 
		 */
		public function close () : void;
		/**
		 * @private
		 */
		private function addCloseListener (event:Event);
		/**
		 * @private (protected)
		 */
		protected function onStageClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function setStyles () : void;
		/**
		 * @private (protected)
		 */
		protected function cleanUpSelected () : void;
		/**
		 * @private (protected)
		 */
		protected function onPopupButtonClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function showPalette () : void;
		/**
		 * @private (protected)
		 */
		protected function setEmbedFonts () : void;
		/**
		 * @private (protected)
		 */
		protected function drawSwatchHighlight () : void;
		/**
		 * @private (protected)
		 */
		protected function drawPalette () : void;
		/**
		 * @private (protected)
		 */
		protected function drawTextField () : void;
		/**
		 * @private (protected)
		 */
		protected function drawSwatches () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBG () : void;
		/**
		 * @private (protected)
		 */
		protected function positionPalette () : void;
		/**
		 * @private (protected)
		 */
		protected function setTextEditable () : void;
		/**
		 * @private (protected)
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function positionTextField () : void;
		/**
		 * @private (protected)
		 */
		protected function setColorDisplay () : void;
		/**
		 * @private (protected)
		 */
		protected function setSwatchHighlight (swatch:Sprite) : void;
		/**
		 * @private (protected)
		 */
		protected function findSwatch (color:uint) : Sprite;
		/**
		 * @private (protected)
		 */
		protected function onSwatchClick (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onSwatchOver (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function onSwatchOut (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function setColorText (color:uint) : void;
		/**
		 * @private (protected)
		 */
		protected function colorToString (color:uint) : String;
		/**
		 * @private (protected)
		 */
		protected function setColorWellColor (colorTransform:ColorTransform) : void;
		/**
		 * @private (protected)
		 */
		protected function createSwatch (color:uint) : Sprite;
		/**
		 * @private (protected)
		 */
		protected function addStageListener (event:Event = null) : void;
		/**
		 * @private (protected)
		 */
		protected function removeStageListener (event:Event = null) : void;
		/**
		 * @private (protected)
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 * @private (protected)
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
	}
}