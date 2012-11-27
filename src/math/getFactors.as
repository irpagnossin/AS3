package math {
	/**
	 * Retorna um vetor contendo os fatores de <source>number</source>.
	 * @param	number - O número cuja fatoração se deseja.
	 * @return	Uma matriz contendo os fatores de <source>number</source>. Por exemplo, na instrução
	 * var fatores:Array = CEPA.getFactors(12);
	 * 
	 * o conteúdo de <source>fatores</fatores> será [1, 2, 2, 3] pois
	 * 12 = 1 * 2 * 2 * 3
	 * 
	 * obs.: se <source>fatores</fatores> contiver dois elementos, pode-se concluir que <source>number</source> é primo.
	 */
	public function getFactors (number:uint) : Vector.<uint> {
		
		var factors:Vector.<uint> = new Vector.<uint>();
		factors.push(number < 0 ? -1 : 1);
		
		number *= (number < 0 ? -1 : 1);
		
		var tmp:int = number;
		var product:int = 1;
		var factor:int = 1;
		
		for (var integer:int = 2; integer <= number && product != number; integer++) {
			while (tmp % integer == 0) {
				tmp /= integer;
				factors.push(integer);
			}
			
			product = 1;
			for each (factor in factors) product *= factor;
		}
		
		return factors;
	}
}
