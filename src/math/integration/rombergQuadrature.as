package math.integration
{
	/**
	 * 
	 * @param	order
	 * @param	a
	 * @param	b
	 * @param	f
	 * @param	userData
	 * @return
	 * @author Ivan Ramos Pagnossin (translation to ActionScript from geometrictools.com)
	 */
	public function rombergQuadrature (order:uint, a:Number, b:Number, f:Function, userData:Array) : Number
	{
		var rom:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>(order, true);
		for (var o:int = 0; o < order; ++o) rom[o] = new Vector.<Number>();
		
		var h:Number = b - a;

		rom[0][0] = (f(a, userData) + f(b, userData)) * h/2;
		for (var i0:int = 2, p0:int = 1; i0 <= order; ++i0, p0 *= 2, h /= 2)
		{
			// Approximations via the trapezoid rule.
			var sum:Number = 0;
			var i1:int;
			
			for (i1 = 1; i1 <= p0; ++i1)
			{
				sum += f(a + h * (i1-0.5), userData);
			}

			// Richardson extrapolation.
			rom[1][0] = (rom[0][0] + h * sum) / 2;
			for (var i2:int = 1, p2:int = 4; i2 < i0; ++i2, p2 *= 4)
			{
				rom[1][i2] = (p2*rom[1][i2-1] - rom[0][i2-1])/(p2-1);
			}

			for (i1 = 0; i1 < i0; ++i1)
			{
				rom[0][i1] = rom[1][i1];
			}
		}

		return rom[0][order - 1];
	}
}