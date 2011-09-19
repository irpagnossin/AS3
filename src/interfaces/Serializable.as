package interfaces
{
	/**
	 * This interface defines a standard method to <code>serialize</code> and <code>deserialize</code> objects.
	 * @author Ivan Ramos Pagnossin
	 * @version 0.1
	 */
	public interface Serializable
	{
		/**
		 * A string representation of the object.
		 */
		function get serialization () : String;
		
		/**
		 * @private
		 */
		function set serialization (stream:String) : void;
	}
}