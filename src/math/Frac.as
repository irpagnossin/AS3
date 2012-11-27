package math {
	
	public class Frac {
		
		public function Frac (numerator:int = 1, denominator:int = 1) {
			setFrac(numerator, denominator);
		}
		
		public function setFrac (numerator:int, denominator:int) : void {
			
			if (denominator == 0) throw new Error ("Division by zero!");
			else {
				_numerator = Math.abs(numerator);
				_denominator = Math.abs(denominator);
			}
			
			if (numerator * denominator >= 0) _sign = +1;
			else _sign = -1;
		}
		
		public function get numerator () : int {
			return _numerator;
		}
		
		public function get denominator () : int {
			return _denominator;
		}
		
		public function get sign () : int {
			return _sign;
		}
		
		public function simplify () : void {
			var gcd:uint = getGCD(_numerator, _denominator);
			setFraction(_numerator / gcd, _denominator / gcd);
		}

		public function toNumber () : Number {
			var ans:Number = sign * numerator / denominator;
			return ans;
		}
		
		public function toString () : String {
			var ans:String = numerator + "/" + denominator;
			if (sign < 0) ans = "-" + ans;
			return ans;
		}

		public static function add (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return new Frac(f1.sign * f1.numerator * f2.denominator + f2.sign * f2.numerator * f1.denominator, f1.denominator * f2.denominator);
		}

		public static function multiply (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return new Frac(f1.sign * f1.numerator * f2.sign * f2.numerator, f1.denominator * f2.denominator);
		}

		public static function inverse (frac:Frac) : Frac {
			if (frac == null) throw new Error("Frac cannot be null.");
			return new Frac(frac.sign * frac.denominator, frac.numerator);
		}
		
		public static function divide (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return Frac.multiply(f1, Frac.inverse(f2));
		}

		public static function subtract (f1:Frac, f2:Frac) : Frac {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			var opposite:Frac = new Frac(-f2.numerator, f2.denominator);
			return Frac.add(f1, opposite);
		}

		public static function equals (f1:Frac, f2:Frac) : Boolean {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");
			return (f1.sign == f2.sign) && (f1.numerator == f2.numerator) && (f1.denominator == f2.denominator);
		}

		/**
		 * To be used with Array.sortOn()
		 */
		public static function compare (f1:Frac, f2:Frac) : int {
			if (f1 == null || f2 == null) throw new Error("Frac cannot be null.");

			var a:Number = f1.sign * f1.numerator / f1.denominator;
			var b:Number = f2.sign * f2.numerator / f2.denominator;

			if (a < b) return -1
			else if (a > b) return +1;
			else return 0;
		}

		// obs.: numa linguagem que permita polimorfismo do construtor, esse método seria um construtor
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
	}
}

