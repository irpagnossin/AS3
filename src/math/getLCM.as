package {
	/**
     * Returns the LCM (least common multiple) of unsigned integerers <source>a</source> and <source>b</source>.
	 * @param	a - First unsigned int.
	 * @param	b - Second unsigned int.
	 * @return	LCD of <source>a</source> and <source>b</source>.
	 *
	 * @pt-BR
	 * Retorna o MMC (mínimo múltiplo comum) dos inteiros <source>a</source> e <source>b</source>.
	 * @param	a - O primeiro número inteiro.
	 * @param	b - O segundo número inteiro.
	 * @return	O MMC de <source>a</source> e <source>b</source>.
	 */
	public function getLCM (a:uint, b:uint) : uint {
		
		trace("WARNING: getMMC method is beta version yet.")
		
		var tmpA:Array = getFactors(a);
		var tmpB:Array = getFactors(b);
		
		var factor:int;
		var lcm:int = 1;
		
		for each (factor in tmpA) lcm *= factor;
		for each (factor in tmpB) if (tmpA.indexOf(factor) == -1) lcm *= factor;
		
		return lcm;
	}
}
