/**
 * Esta classe fornece a velocidade e a aceleração do mouse, além do raio e das coordenadas do centro da circunferência que representa a curvatura da trajetória do mouse.
 * Para utilizá-la basta criar uma instância dela no seu aplicativo.
 */
/*
 * 
 * Obs.: padrão de projeto Singleton baseado no blog de Darron Schall:
 * http://www.darronschall.com/weblog/2007/11/actionscript-3-singleton-redux.cfm
 */
package cepa.utils {
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class MouseMotionData extends Sprite {
		
		private var dt, t0:Number;
		
		private var r:Array;
		private var v:DynamicAveragePair;
		private var a:DynamicAveragePair;
		
		private var theRadius:Number = 0;
		private var theCenter:Point = new Point();
		
		private var previousSpeed:Point;
		
		private var hasSolution:Boolean = true;
		
		private var m1, m2:Number;
		private var pto1, pto2:Point;
		
		// Instância (única) desta classe (design pattern singleton)
		public static const instance:MouseMotionData = new MouseMotionData(SingletonLock);
		
		/**
		 * NÃO UTILIZE O CONSTRUTOR DESTA CLASSE. Para obter uma instância desta classe, utilize a propriedade
		 * <source>MouseMotion.instance</source>
		 * @param	lock - Chave de acesso (apenas a própria classe tem e, por isso, apenas ela pode executar o construtor)
		 */
		public function MouseMotionData (lock:Class) : void {
			
			if (lock != SingletonLock) throw new Error( "Invalid Singleton access. Use MouseMotion.instance to obtain an instance of this class." );
			
			t0 = getTimer();
			
			r = new Array();
			v = new DynamicAveragePair(1); // 1 definido por tentativa e erro
			a = new DynamicAveragePair(2); // 2 definido por tentativa e erro
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Retorna a velocidade do mouse, em pixels por segundo
		 */
		public function get speed () : Point {
			return v.mean;
		}

		/**
		 * Retorna a aceleração do mouse, em pixels por segundo por segundo
		 */
		public function get acceleration () : Point {
			return a.mean;
		}
		
		/**
		 * Retorna o raio associado à curvatura da trajetória do mouse
		 */
		public function get radius () : Number {
			return theRadius;
		}
		
		/**
		 * Retorna as coordenadas do centro da circunferência associada à trajetória do mouse
		 */
		public function get center () : Point {
			if (!isNaN(radius))	return theCenter;
			else return null;
		}
		
		/*
		 * Avalia a posição, velocidade e aceleração do mouse
		 */
		private function onEnterFrame (event:Event) : void {
			
			dt = (getTimer() - t0) / 1000;
			
			// Acrescenta a posição atual do mouse no vetor de posições, limitando-o às três últimas posições
			if (r.push(new Point(mouseX, mouseY)) > 3) r.shift();
			
			if (r.length > 1) {
				
				previousSpeed = v.mean;
				
				// Acrescenta a velocidade entre as duas últimas posições do mouse na média
				v.push(new Point(
					(r[r.length - 1].x - r[r.length - 2].x) / dt,
					(r[r.length - 1].y - r[r.length - 2].y) / dt
				));
				
				// Acrescenta a aceleração entre as duas últimas velocidades do mouse na média
				a.push(new Point(
					(v.mean.x - previousSpeed.x) / dt,
					(v.mean.y - previousSpeed.y) / dt
				));
			}
			
			// Atualiza as coordenadas do centro da curvatura da trajetória e seu raio
			update();
			
			t0 = getTimer();
		}
		
		/*
		 * Calcula o raio e as coordenadas do centro da circunferência associada à curvatura da trajetória do mouse
		 * TODO: calcular a circunferência através de máxima verossimilhança, para N pontos.
		 */
		private function update () : void {
			
			if (r.length < 3) return;
			
			var A:Boolean = r[0].x != r[1].x;
			var B:Boolean = r[0].y != r[1].y;
			var C:Boolean = r[1].x != r[2].x;
			var D:Boolean = r[1].y != r[2].y;
			
			hasSolution = true;
			
			pto1 = new Point((r[0].x + r[1].x) / 2, (r[0].y + r[1].y) / 2);
			pto2 = new Point((r[1].x + r[2].x) / 2, (r[1].y + r[2].y) / 2);
			
			if (A && B && C && D) {
				
				m1 = (r[1].y - r[0].y) / (r[1].x - r[0].x);
				m2 = (r[2].y - r[1].y) / (r[2].x - r[1].x);
				
				if (m1 != m2) {
					theCenter.x = (m2 * (pto1.x + m1 * pto1.y) - m1 * (pto2.x + m2 * pto2.y)) / (m2 - m1);
					theCenter.y = pto1.y - (theCenter.x - pto1.x) / m1;
				}
				else hasSolution = false;
			}
			else if (!A && B && C && D) {
				m2 = (r[2].y - r[1].y) / (r[2].x - r[1].x);
				
				theCenter.x = pto2.x - m2 * (pto1.y - pto2.y);
				theCenter.y = pto1.y;
			}
			else if (A && !B && C && D) {
				m2 = (r[2].y - r[1].y) / (r[2].x - r[1].x);
				
				theCenter.x = pto1.x;
				theCenter.y = pto2.y - (pto1.x - pto2.x) / m2;
			}
			else if (A && B && !C && D) {
				m1 = (r[1].y - r[0].y) / (r[1].x - r[0].x);
				
				theCenter.x = pto1.x - m1 * (pto2.y - pto1.x);
				theCenter.y = pto2.y;
			}
			else if (A && B && C && !D) {
				m1 = (r[1].y - r[0].y) / (r[1].x - r[0].x);
				
				theCenter.x = pto2.x;
				theCenter.y = pto1.y - (pto2.x - pto1.x) / m1;
			}
			else if (!A && B && C && !D) {
				theCenter.x = pto2.x;
				theCenter.y = pto1.y;
			}
			else if (A && !B && !C && D) {
				theCenter.x = pto1.x;
				theCenter.y = pto2.y;
			}
			else {
				theCenter.x = theCenter.y = 0;
				hasSolution = false;
			}
			
			if (hasSolution) theRadius = Point.distance(theCenter, r[0]);
			else theRadius = NaN;
		}
		
	}
}

// Chave de acesso ao construtor: apenas as classes neste arquivo tem acesso a ela.
class SingletonLock {}