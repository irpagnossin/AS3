package math {
	
	public class Frac {
	
		public static const ZERO:Frac = new Frac(0,1);
	
		/**
		 * Creates an integer fraction. For instance, <source>var frac:Frac = new Frac(-3,2)</source> represents -3/2.
		 */
		public function Frac (numerator:int = 1, denominator:int = 1) {
			setFrac(numerator, denominator);
		}
				
		/**
		 * Reads the <emph>signed</emph> numerator of the fraction.
		 * @returns Numerator
		 */
		public function get numerator () : int {
			return _sign * _numerator;
		}
		
		/**
		 * Reads the <emph>unsigned</emph> denominator of the fraction.
		 * @returns Denominator
		 */
		public function get denominator () : int {
			return _denominator;
		}		

		/**
		 * Simplify the current instance of <source>Frac</source>. By default, fractions are NOT simplified.
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(9/6);
		 * trace(frac); // Prints 9/6
		 * frac.simplify();
		 * trace(frac); // Prints 3/2 (simplified fraction)
		 * </listing>
		 */
		public function simplify () : void {
			var gcd:uint = getGCD(_numerator, _denominator);
			setFrac(_numerator / gcd, _denominator / gcd);
		}

		/**
		 * Returns a <source>Number</source> representation of the current instance of <source>Frac</source>.
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(-3,2);
		 * var number:Number = frac.toNumber();
		 * trace(number); // Prints -1.5
		 * </listing>
		 * @returns <source>Number</source> representation of <source>Frac</source>.
		 */
		public function toNumber () : Number {
			var ans:Number = numerator / denominator;
			return ans;
		}

		/**
		 * Returns a <source>String</source> representation of the current instance of <source>Frac</source>.
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(-3,2);
		 * trace(frac); // Prints -1.5
		 * </listing>
		 * @returns <source>String</source> representation of <source>Frac</source>.
		 */
		public function toString () : String {
			var ans:String = numerator.toString();
			if (denominator != 1) ans = ans + "/" + denominator;
			return ans;
		}

		/**
		 * Adds two <source>Frac</source>s:
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(7,3);
		 * trace(Frac.add(f1,f2)); // Prints 23/6
		 * </listing>
		 */
		public static function add (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return new Frac(f1.numerator * f2.denominator + f2.numerator * f1.denominator, f1.denominator * f2.denominator);
		}

		/**
		 * Multiply two <source>Frac</source>s:
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(7,3);
		 * trace(Frac.multiply(f1,f2)); // Prints 7/2
		 * </listing>
		 * @param f1 First <source>Frac</source>
		 * @param f2 Second <source>Frac</source>
		 * @returns The product of <souce>f1</source> and <source>f2</source>.		
		 */
		public static function multiply (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return new Frac(f1.numerator * f2.numerator, f1.denominator * f2.denominator);
		}

		/**
		 * Inverts a <source>Frac</source>s:
		 * @example
		 * <listing version="3.0">
		 * var frac:Frac = new Frac(3,2);
		 * trace(Frac.inverse(frac)); // Prints 2/3
		 * </listing>
		 * @param frac The <source>Frac</source> to be inverted.
		 * @return The inverse of <source>frac</source>.
		 */
		public static function inverse (frac:Frac) : Frac {
			if (frac == null) throw new Error("Frac cannot be null.");
			return new Frac(frac.denominator, frac.numerator);
		}
	
		/**
		 * Divide two <source>Frac</source>s.
		 * @param f1 Dividend
		 * @param f2 Divisor
		 * @return Resulting <source>Frac</source>.
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(3,7);
		 * trace(Frac.divide(f1,f2); // Prints 7/2
		 */
		public static function divide (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return Frac.multiply(f1, Frac.inverse(f2));
		}

		/**
		 * Subtracts <source>f2</source> from <source>f1</source>.
		 *
		 * @example
		 * <listing version="3.0">
		 * var f1:Frac = new Frac(3,2);
		 * var f2:Frac = new Frac(7,3);
		 * trace(Frac.subtract(f1,f2)); // Prints -5/6
		 * </listing>
		 * @param f1 First <source>Frac</source>
		 * @param f2 Second <source>Frac</source>
		 * @returns The subrtaciont of <souce>f2</source> from <source>f1</source>.		
		 */
		public static function subtract (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			var opposite:Frac = new Frac(-f2.numerator, f2.denominator);
			return Frac.add(f1, opposite);
		}

		/**
		 * Checks wheter two <source>Frac</source>s are equal.
		 * @param f1 First <source>Frac</frac>.
		 * @param f2 Second <source>Frac</frac>.
		 * @return <source>true</source> if fractions are equal; <source>false</source> otherwise.
		 */
		public static function equals (f1:Frac, f2:Frac) : Boolean {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return (f1.numerator == f2.numerator) && (f1.denominator == f2.denominator);
		}

		/**
		 * Compare two <source>Frac</source>s, as prescribed on <source>Array.sortOn()</source>.
		 * @param f1 First <source>Frac</frac>.
		 * @param f2 Second <source>Frac</frac>.
		 * @return -1 if <source>f1</source> &#60; <source>f2</source>, 0 if they are equal; +1 otherwise.
		 * @throw flash.error.Error If any of the arguments is <source>null</source>.
		 */
		public static function compare (f1:Frac, f2:Frac) : int {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");

			var a:Number = f1.toNumber();
			var b:Number = f2.toNumber();

			if (a < b) return -1
			else if (a > b) return +1;
			else return 0;
		}

		// obs.: numa linguagem que permita polimorfismo do construtor, esse método seria um construtor
		// TODO: tratar sinais
		public static function createFrac (number:Number, simplify:Boolean = true, numCasas:int = -1) : Frac {
		
			if (numCasas == -1) {
				var tmp:Array = number.toString().split(".");
				if (tmp.length == 0 || tmp.length == 1) numCasas = 0;
				else numCasas = tmp[1].length;
			}
			else {
				number = new Number(number.toFixed(numCasas));
			}
	
			var denominator:int = Math.pow(10, numCasas);
			var numerator:int = number * denominator;

			var ans:Frac = new Frac(numerator, denominator);
			if (simplify) ans.simplify();
	
			return ans;
		}

		private var _numerator:int;
		private var _denominator:int;
		private var _sign:int;

		private function setFrac (numerator:int, denominator:int) : void {
			
			if (denominator == 0) throw new Error ("Division by zero!");
			else {
				_numerator = Math.abs(numerator);
				_denominator = Math.abs(denominator);
			}
			
			if (numerator * denominator < 0) _sign = -1;
			else _sign = +1;
		}
	}
}

