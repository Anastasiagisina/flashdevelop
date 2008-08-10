/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.messages {
	public interface IMessage {
		/**
		 * The body of a message contains the specific data that needs to be
		 *  delivered to the remote destination.
		 */
		public function get body():Object;
		public function set body(value:Object):void;
		/**
		 * The clientId indicates which client sent the message.
		 */
		public function get clientId():String;
		public function set clientId(value:String):void;
		/**
		 * The message destination.
		 */
		public function get destination():String;
		public function set destination(value:String):void;
		/**
		 * Provides access to the headers of the message.
		 *  The headers of a message are an associative array where the key is the
		 *  header name.
		 *  This property provides access to specialized meta information for the
		 *  specific message instance.
		 */
		public function get headers():Object;
		public function set headers(value:Object):void;
		/**
		 * The unique id for the message.
		 *  The message id can be used to correlate a response to the original
		 *  request message in request-response messaging scenarios.
		 */
		public function get messageId():String;
		public function set messageId(value:String):void;
		/**
		 * Provides access to the time stamp for the message.
		 *  A time stamp is the date and time that the message was sent.
		 *  The time stamp is used for tracking the message through the system,
		 *  ensuring quality of service levels and providing a mechanism for
		 *  expiration.
		 */
		public function get timestamp():Number;
		public function set timestamp(value:Number):void;
		/**
		 * The time to live value of a message indicates how long the message
		 *  should be considered valid and deliverable.
		 *  This value works in conjunction with the timestamp value.
		 *  Time to live is the number of milliseconds that this message remains
		 *  valid starting from the specified timestamp value.
		 *  For example, if the timestamp value is 04/05/05 1:30:45 PST
		 *  and the timeToLive value is 5000, then this message will
		 *  expire at 04/05/05 1:30:50 PST.
		 *  Once a message expires it will not be delivered to any other clients.
		 */
		public function get timeToLive():Number;
		public function set timeToLive(value:Number):void;
		/**
		 * This method will return a string representation of the message.
		 *
		 * @return                  <String> String representation of the message.
		 */
		public function toString():String;
	}
}
