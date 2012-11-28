package math {
	
	public class Frac {
	
		/**
		 * Creates an integer fraction.	
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(-3,2); // Represents -3/2
		 * </listing>
		 * @throws Error If denominator is zero (division by zero).
		 */
		public function Frac (numerator:int = 1, denominator:int = 1) {
			setFrac(numerator, denominator);
		}
				
		/**
		 * Creates a copy of the current fraction instance.
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3, 2);
		 * var f2:Frac = f1.clone();
		 * trace(f1 + " = " + f2); // Prints 3/2 = 3/2
		 * </listing>
		 */
		public function clone () : Frac {
			return new Frac(numerator, denominator);
		}

		/**
		 * Reads the numerator of the fraction (signed).
		 * @return Numerator
		 */
		public function get numerator () : int {
			return _sign * _numerator;
		}
		
		/**
		 * Reads the denominator of the fraction (unsigned).
		 * @return Denominator
		 */
		public function get denominator () : int {
			return _denominator;
		}		

		/**
		 * Simplify the current fraction instance (by default, fractions are not simplified).
		 * <p>Attention: this method changes internal representation of the fraction.</p>
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(9/6);
		 * frac.simplify();
		 * trace(frac); // Prints 3/2 (simplified fraction)
		 * </listing>
		 */
		public function simplify () : void {
			var gcd:uint = getGCD(_numerator, _denominator);
			setFrac(_numerator / gcd, _denominator / gcd);
		}

		/**
		 * Builds a Number representation of the current fraction instance.
		 * @return Number representation.
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(-3,2);
		 * var number:Number = frac.toNumber();
		 * trace(number); // Prints -1.5
		 * </listing>
		 
		 */
		public function toNumber () : Number {
			var ans:Number = numerator / denominator;
			return ans;
		}

		/**
		 * Builds a String representation of the current fraction instance.
		 * @return String representation in the format numerator/denominator.
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(-3,2);
		 * trace(frac); // Prints -3/2
		 * </listing>
		 */
		public function toString () : String {
			var ans:String = numerator.toString();
			if (denominator != 1) ans = ans + "/" + denominator;
			return ans;
		}

		/**
		 * Calculates de sum of two fractions. By default, fractions are not simplified.
		 * @return f1 + f2
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(2,2);
		 * var f2:Frac = new Frac(7,5);
		 * trace(Frac.add(f1,f2)); // Prints 24/10 (not simplified)
		 * </listing>
		 * @throws Error If any of the arguments is null.
		 */
		public static function add (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Arguments cannot be null.");
			return new Frac(f1.numerator * f2.denominator + f2.numerator * f1.denominator, f1.denominator * f2.denominator);
		}

		/**
		 * Calculates de subtraction of two fractions.
		 * @return f2 - f1
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(7,3);
		 * trace(Frac.subtract(f1,f2)); // Prints -5/6
		 * </listing>
		 * @throws Error If any of the arguments is null.
		 */
		public static function subtract (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Arguments cannot be null.");
			return Frac.add(f1, Frac.opposite(f2));
		}

		/**
		 * Calculates de product of two fractions:
		 * @return f1 * f2		
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(7,3);
		 * trace(Frac.multiply(f1,f2)); // Prints 7/2
		 * </listing>
		 * @throws Error If any of the arguments is null.	
		 */
		public static function multiply (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Arguments cannot be null.");
			return new Frac(f1.numerator * f2.numerator, f1.denominator * f2.denominator);
		}

		/**
		 * Calculates de division of two fractions.
		 * @param f1 Dividend
		 * @param f2 Divisor
		 * @return f1 / f2
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(3,7);
		 * trace(Frac.divide(f1,f2)); // Prints 7/2
		 * </listing>
		 * @throws Error If any of the arguments is null.
		 */
		public static function divide (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Arguments cannot be null.");
			return Frac.multiply(f1, Frac.inverse(f2));
		}

		/**
		 * Inverts a fraction.
		 * @param f The fraction to be inverted.
		 * @return 1 / f
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(3,2);
		 * trace(Frac.inverse(frac)); // Prints 2/3
		 * </listing>
		 * @throws Error If argument is null.
		 */
		public static function inverse (f:Frac) : Frac {
			if (f == null) throw new Error("Argument cannot be null.");

			var ans:Frac;
			if (f.numerator == 0) ans = f.clone();
			else ans = new Frac(f.denominator, f.numerator);

			return ans;
		}	

		/**
		 * Creates the opposite fraction.
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3, 2);
		 * var f2:Frac = Frac.opposite(f1);
		 * trace(f2); // Prints -3/2
		 * </listing>
		 */
		public static function opposite (f:Frac) : Frac {
			return new Frac(-f.numerator, f.denominator);
		}

		/**
		 * Checks whether two fractions are equal.
		 * @return true if fractions are equal; false otherwise.
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(3,4);
		 * var f3:Frac = new Frac(6,4);
		 * trace(Frac.equals(f1,f2)); // Prints false
		 * trace(Frac.equals(f1,f3)); // Prints true
		 * </listing>
		 * @throws Error If any of the arguments is null.
		 */
		public static function equals (f1:Frac, f2:Frac) : Boolean {
			if (f1 == null || f2 == null) throw new Error("Arguments cannot be null.");
			var sf1:Frac = f1.clone();
			var sf2:Frac = f2.clone();
			sf1.simplify();
			sf2.simplify();
			return (sf1.numerator == sf2.numerator) && (sf1.denominator == sf2.denominator);
		}

		/**
		 * Compares two fractions.		
		 * @return -1 if f1 &lt; f2, 0 if they are equal; +1 otherwise.
		 * @throws Error If any of the arguments is null.
		 */
		public static function compare (f1:Frac, f2:Frac) : int {
			if (f1 == null || f2 == null) throw new Error("Arguments cannot be null.");

			var a:Number = f1.toNumber();
			var b:Number = f2.toNumber();

			// TODO: isto está errado!! float comparison
			if (a < b) return -1
			else if (a > b) return +1;
			else return 0;
		}

		/**
		 * Creates a simplified fraction representation of a number.
		 * @param Number Number whose fractional representation must be created.
		 * @param decplaces The number of decimal places to consider.
		 * @return The fractional representation.
		 * @example
		 * <listing version="3.0">
		 * var number:Number = -3.8921;
		 * var frac:Frac = Frac.create(number, 3);
		 * trace(frac); // Produces -973/250 (simplified)
		 * </listing>
		 */
		// TODO: tratar dízimas
		public static function create (number:Number, decplaces:uint) : Frac {

			var denominator:int = Math.pow(10, decplaces);
			var numerator:int = Math.floor(number * denominator);
			var ans:Frac = new Frac(numerator, denominator);
			ans.simplify();
	
			return ans;
		}

		private var _numerator:int;
		private var _denominator:int;
		private var _sign:int;

		/**
		 * @private
		 * Builds the internal representation of the fraction, through _numerator, _denominator and _sign.
		 * @throws Error If denominator is zero (division by zero).
		 */
		private function setFrac (numerator:int, denominator:int) : void {
			
			if (denominator == 0) throw new Error("Division by zero!");

			_numerator = Math.abs(numerator);
			_denominator = Math.abs(denominator);
			_sign = (numerator * denominator < 0 ? -1 : +1);
		}
	}
}

