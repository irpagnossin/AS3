// TODO: criar um método análogo para vários números: getMDC(a, b, c, d, ...)
package math {
	/**
	 * Returns the GCD (greathest common divisor) of unsigned integers <source>a</source> and <source>b</source>. 
	 * @param	a - First unsigned int.
	 * @param	b - Second unsigned int.
	 * @return	GCD of <source>a</source> and <source>b</source>.
	 */
	public function getGCD (a:uint, b:uint) : uint {
	
		var mdc:uint = a;
		var aux:uint = b;
	
		var remainder:uint;
		while (aux != 0){
			remainder = mdc % aux;
			mdc = aux;
			aux = remainder;
		}
	
		return mdc;
	}
}
