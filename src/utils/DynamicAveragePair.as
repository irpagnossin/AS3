/**
 * Versão extendida da classe DynamicAverage para pares ordenados representados pela classe Point.
 */
package cepa.utils {
	import flash.geom.Point;
	
	public class DynamicAveragePair {
		
		private const DEFAULT_N:uint = 5;
		private var x1:DynamicAverage, x2:DynamicAverage;
		
		/**
		 * Constrói uma média dinâmica de <code>N</code> pares (x,y)
		 * @param	N
		 */
		public function DynamicAveragePair (N:uint = DEFAULT_N) : void {
			x1 = new DynamicAverage(N);
			x2 = new DynamicAverage(N);
		}
		
		/**
		 * Acrescenta o par <code>pair</code> à média.
		 * @param	pair
		 */
		public function push (pair:Point) : void {
			x1.push(pair.x);
			x2.push(pair.y);
		}
		
		/**
		 * Retorna a média (\bar x,\bar y). [LaTeX]
		 */
		public function get mean () : Point {
			return new Point(x1.mean, x2.mean);
		}
		
		/**
		 * Apaga a média [retorna-a a (0,0)]
		 */
		public function reset () : void {
			x1.reset();
			x2.reset();
		}
	}
}