package math.integration
{
	
	/**
	 * @param	a Lower limit of integration.
	 * @param	b Upper limit of integration.
	 * @param	f Function to integrate.
	 * @param	userData ??
	 * @author	Ivan Ramos Pagnossin (translated from geometrictools.com)
	 * @version	2011.09.17
	 */
	public function gaussianQuadrature (a:Number, b:Number, f:Function, userData:Array) : Number
	{	
		const DEGREE:uint = 5;
		
		// Roots of the Legendre polynomial of specified degree.
		const ROOT:Vector.<Number> = Vector.<Number>(
		[
			-0.9061798459,
			-0.5384693101,
			+0.0,
			+0.5384693101,
			+0.9061798459
		]);
		
		const COEFF:Vector.<Number> = Vector.<Number>(
		[
			0.2369268850,
			0.4786286705,
			0.5688888889,
			0.4786286705,
			0.2369268850
		]);

		// Need to transform domain [a,b] to [-1,1]. 
		// If a <= x <= b and -1 <= t <= 1, then x = ((b-a)*t+(b+a))/2.
		var radius:Number = (b - a) / 2;
		var center:Number = (b + a) / 2;

		var result:Number = 0;
		for (var i:int = 0; i < DEGREE; ++i) result += COEFF[i] * f(radius * ROOT[i] + center, userData);
		result *= radius;

		return result;
	}
}
