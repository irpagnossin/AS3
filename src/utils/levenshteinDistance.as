package utils
{
	/**
	 * Retorna a distância de Levenshtein entre duas strings.
	 * @param	string1 Primeira string.
	 * @param	string2 Segunda string.
	 * @return	A distância de Levenshtein.
	 * @author Ivan Ramos Pagnossin
	 * @version 1.0 (2011.01.27)
	 */
	public function levenshteinDistance (string1:String, string2:String) : uint
	{
		string1 = (string1 ? string1 : "");
		string2 = (string2 ? string2 : "");
		
		if (string1 == string2) return 0;

		var d:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
		var cost:uint;
		var i:uint;
		var j:uint;
		var n:uint = string1.length;
		var m:uint = string2.length;

		if (n == 0) return m;
		if (m == 0) return n;

		for (i = 0; i <= n; i++) d[i] = new Vector.<uint>();
		for (i = 0; i <= n; i++) d[i][0] = i;
		for (j = 0; j <= m; j++) d[0][j] = j;

		for (i = 1; i <= n; i++)
		{
			for (j = 1; j <= m; j++)
			{
				cost = (string1.charAt(i - 1) == string2.charAt(j-1) ? 0 : 1);
				d[i][j] = Math.min(d[i-1][j]+1, d[i][j-1]+1, d[i-1][j-1]+cost);
			}
		}
		
		return d[n][m];
	}
}