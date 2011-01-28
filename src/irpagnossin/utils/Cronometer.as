/*
  arquivo: Cronometer.java
  autor: Ivan Ramos Pagnossin
  data: 2006.01.20
  copyright: viavoip
 */
package irpagnossin.utils
{
	import flash.utils.getTimer;

	/**
	 * A classe Cronometer encapsula um cronômetro. Um exemplo de uso é:
	 * <code>
	 * <p>Cronometer cron = new Cronometer();
	 * <p>cron.start();
	 * <p>System.out.println( cron.read() );</p>
	 * <p>cron.stop();</p>
	 * </code>
	 * 
	 * @author Ivan Ramos Pagnossin
	 */

	public class Cronometer{
		
		private var beginning:Number;	// Hora inicial do sistema, em milisegundos.
		private var elapsed:Number;    // Tempo total decorrido desde o primeiro start.
		private var running:Boolean;	// Estado do cronômetro: cronometrando ou não.

		/**
		 * Cria um cronômetro.
		 */
		public function Cronometer () {
			this.elapsed = 0;
			this.running = false;
		}

		/**
		 * Inicia a cronometragem.
		 * <p>obs.: iniciar uma cronometragem já iniciada não incorre em nada. Assim, no código
		 * <p><code>cron.start();</code>
		 * <p><code>cron.start();</code>
		 * <p>o segundo <code>start</code> não faz nada.
		 */
		public final function start() : void {
			if ( !this.running ){
				beginning = getTimer();
				this.running = true;
			}		
		}

		/**
		 * Encerra a cronometragem.
		 * <p>obs.: encerrar uma cronometragem já encerrada não incorre em nada. Assim, no código
		 * <p><code>cron.stop();</code>
		 * <p><code>cron.stop();</code>
		 * <p>o segundo <code>stop</code> não faz nada.	 
		 */
		public final function pause() : void {
			if ( this.running ){
				elapsed += getTimer() - beginning;
				this.running = false;
			}		
		}

		/**
		 * Zera o tempo total cronometrado.
		 */
		public final function reset() : void{
			beginning = getTimer();
			this.elapsed = 0;
		}
		
		/**
		 * Pára a cronometragem e zera o cronômetro. Equivale a executar
		 * <code>pause()</code> e <code>reset()</code>.
		 */
		public function stop() : void {
			pause();
			reset();
		}
		
		/**
		 * Fornece o tempo decorrido em milisegundos.
		 * @return o tempo total em estado de cronometragem, ou seja, a soma de todos os tempos entre as execuções dos métodos <code>start</code> e
		 * <code>stop</code> ou <code>read</code>, nesta ordem.
		 */
		public final function read() : Number {
			return( running ? getTimer() - beginning + elapsed : elapsed );
		}

		/**
		 * Indica se o cronômetro está rodando ou não.
		 * @return <code>true</code> caso o cronômetro esteja rodando ou <code>false</code> em caso contrário.
		 */
		public function isRunning() : Boolean {
			return( running );
		}
		
		/**
		 * Imprime o tempo decorrido no formato hh:mm:ss.sss 
		 */
		public function toString () : String {
			
			var millis:Number = this.elapsed % 1000;
			var secs:Number = this.elapsed / 1000;
			var mins:Number = secs / 60;
			var hours:Number = mins / 60;
			
			return( hours + ":" + mins + ":" + secs + "." + millis );
		}
	}
}

