package irpagnossin.interfaces
{
	/**
	 * Esta interface padroniza um método de (des)serialização, quando necessário.
	 */
	public interface Serializable
	{
		/**
		 * Serializa um objeto.
		 * @return	A string que representa o objeto.
		 */
		function serialize () : String;
		
		/**
		 * Cria uma instância da classe que implementa esta interface a partir de uma serialização dada.
		 * @param	serialization	A string que representa o objeto.
		 */
		function deserialize (serialization:String) : void;
	}
}