package irpagnossin.utils
{
	/**
	 * Esta classe permite ao usuário manter o valor médio dos últimos <code>n</code> itens adicionados a ela.
	 * Por exemplo, a coordeanda <code>x</code> média do mouse nos últimos 5 quadros (frames) pode ser obtida assim:
	 * <listings>
	 * var posicao:DynamicAverage = new DynamicAverage(5);
	 * 
	 * addEventListener(Event.ENTER_FRAME, function (event:Event) : void {
	 *   posicao.push(mouseX);
	 *   trace("Posição média: " + posicao.mean);
	 * });
	 * </listings>
	 * 
	 * @author Ivan Ramos Pagnossin
	 * @version 1.0 (2011.01.27)
	 */
	public class DynamicAverage
	{
		private var _mean:Number;	// Média.
		private var _n:uint;			// Quantidade de itens inseridos.
		private var numbers:Vector.<Number>;
		
		/**
		 * Constrói uma média dinâmica de <code>n</code> valores
		 * @param	n
		 */
		public function DynamicAverage (n:uint = 5) : void {
			this.n = n;
			numbers = new Vector.<Number>();
			
			reset();
		}
		
		/**
		 * Push an item to the mean.
		 * @param	item	The item to be pushed.
		 */
		public function push (item:Number):void {
			
			if (numbers.length > _n) numbers.shift();
			numbers.push(item);
			
			_mean = 0;
			for (var i:uint = 0; i < _n; i++) _mean += numbers[i];
			_mean /= _n;
		}
		
		/**
		 * The mean (read-only).
		 */
		public function get mean ():Number {
			return _mean;
		}
		
		/**
		 * Reset the mean (make it zero).
		 */
		public function reset ():void {
			_mean = 0;
			for (var i:uint = 0; i < _n; i++) numbers.push(0);
		}	
		
		/**
		 * The amount of items to use in the mean.
		 */
		public function get n () : uint
		{
			return _n;
		}
		
		/**
		 * @private
		 */
		public function set n (value:uint) : void
		{
			if (value > 1) _n = value;
			else throw new Error("The amount of items must be greater than one.");
		}
	}
}