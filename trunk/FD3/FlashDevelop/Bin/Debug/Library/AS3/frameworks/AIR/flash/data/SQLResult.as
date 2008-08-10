/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.data {
	public class SQLResult {
		/**
		 * Indicates whether all the resulting data from a statement execution has been returned.
		 */
		public function get complete():Boolean;
		/**
		 * The data returned as a result of the statement execution, specifically when
		 *  a SQL SELECT statement is executed.
		 */
		public function get data():Array;
		/**
		 * The last generated row identifier generated by a SQL INSERT
		 *  statement.
		 */
		public function get lastInsertRowID():Number;
		/**
		 * Indicates how many rows were affected by the operation.
		 *  Only changes that are directly specified by an INSERT,
		 *  UPDATE, or DELETE statement are counted.
		 */
		public function get rowsAffected():Number;
		/**
		 * Creates a SQLResult instance. Generally, developer code does not call the SQLResult
		 *  constructor directly. To retrieve a SQLResult instance associated with a particular SQLStatement
		 *  instance, call the instance's getResult() method. A SQLResult
		 *  instance is also passed as an argument to the result handler function when
		 *  a Responder instance is specified for an execute() or next()
		 *  method call.
		 *
		 * @param data              <Array (default = null)> The array of rows returned from the execution of a statement. If
		 *                            the statement doesn't return any rows this value should be null.
		 * @param rowsAffected      <Number (default = 0)> Indicates how many rows the executed statement affected.
		 * @param complete          <Boolean (default = true)> Indicates whether there are additional rows that can
		 *                            be fetched or whether all data has been returned.
		 * @param rowID             <Number (default = 0)> If the statement was a SQL INSERT operation this is the new
		 *                            unique identifier for the row.
		 */
		public function SQLResult(data:Array = null, rowsAffected:Number = 0, complete:Boolean = true, rowID:Number = 0);
	}
}
