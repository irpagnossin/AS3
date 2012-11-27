package cepa.display
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class ExtendedMovieClip extends MovieClip
	{
		//--------------------------------------------------------------------------------
		// Membros públicos (interface)
		//--------------------------------------------------------------------------------
		
		
		public function ExtendedMovieClip ()
		{
			super();
			init();
			reset();
		}
		
		/**
		 * Define o eixo de rotação, que por sua vez é definido por um ponto no plano xy.
		 * @param	point O ponto que define o eixo de rotação, no sistema de coordenadas do pai deste <code>MovieClip</code>.
		 */
		public function setRotationAxis (point:Point) : void
		{
			if (point != null)
			{
				_rotationAxis = point.clone();
			}
			else
			{
				trace("AVISO: o eixo de rotação deve ser não-nulo.");
			}
		}
		
		/**
		 * Define o eixo de reflexão (reta), que por sua vez é definida por dois pontos no plano xy e não sobrepostos.
		 * @param	pointA Um ponto da reta que define o eixo de reflexão, no sistema de coordenadas do pai deste <code>MovieClip</code>, diferente de <code>pB</code>.
		 * @param	pointB Um ponto da reta que define o eixo de reflexão, no sistema de coordenadas do pai deste <code>MovieClip</code>, diferente de <code>pA</code>.
		 */
		public function setReflectionAxis (pointA:Point, pointB:Point) : void
		{
			if (pointA != null && pointB != null)
			{
				if (Point.distance(pointA, pointB) > MINIMUM_AXIS_DISTANCE)
				{
					_reflectionAxis = [pointA, pointB];
				}
				else
				{
					trace("AVISO: os pontos " + pointA + " e " + pointB + " são muito próximos.");
				}
			}
			else
			{
				trace("AVISO: ambos os pontos que definem o eixo de reflexão devem ser não-nulos.");
			}
		}
		
		/**
		 * Define um ponto-de-restauração, ou ainda, salva a configuração atual deste <code>MovieClip</code>.
		 * @see restore
		 */
		public function setRestorePoint () : void
		{
			_transformHistory.push(this.transform.matrix.clone());
		}
		
		/**
		 * Restaura a configuração salva deste <code>MovieClip</code>.
		 * @see setRestorePoint
		 */
		public function restore () : void
		{
			if (_transformHistory.length == 1)
			{
				this.transform.matrix = _transformHistory[0].clone();
			}
			else
			{
				this.transform.matrix = _transformHistory.pop();
			}
		}
		
		/*
		 * Explicação do método displace()
		 * 
		 * Este método serve apenas para unificar a nomenclatura das três transformações afins utilizadas. Utilizar este método
		 * é exatamente o mesmo que valer-se dos atributos x e y do MovieClip.
		 */
		/**
		 * Desloca o <code>MovieClip</code>. Equivale a utilizar os atributos <code>x</code> e <code>y</code>.
		 * @param	dx Deslocamento em x, em pixels.
		 * @param	dy Deslocamento em y, em pixels.
		 */
		public function displace (dx:Number, dy:Number) :  void
		{
			x += dx;
			y += dy;
		}
		
		/*
		 *	Explicação do método rotate()
		 * 
		 * Para rotacionar um DisplayObject com relação a um eixo [ponto (x,y)] dado, é necessário rotacionar o próprio DisplayObject
		 * com relação ao seu registration-point, de um ângulo igual àquele dado como parâmetro. Além disso, é necessário reposicionar
		 * o registration-point do DisplayObject.
		 * 
		 * Observação importante: a transformação de rotação aplicada ao DisplayObject através deste método é feita sobre a última
		 * configuração salva (matriz de transformação transform.matrix). Isto é necessário pois acumular diversas rotações, uma após
		 * a outra, leva a propagações de erros observáveis. Isto é bastante evidente em animações da rotação.
		 */
		/**
		 * Rotaciona o <code>MovieClip</code> com relação ao eixo de rotação, previamente definido.
		 * 
		 * Importante: a transformação de rotação é aplicada sempre sobrea última configuração salva, através do método <code>setRestorePoint()</code>.
		 * Assim, para acumular rotações, é necessário utilizar este método entre rotações sucessivas. Por exemplo:
		 * <listing>
		 * rotate(Math.PI/2);
		 * setRestorePoint();
		 * rotate(Math.PI/2);
		 * </listing>
		 * corresponde a uma rotação de 180º, mas
		 * <listing>
		 * rotate(Math.PI/2);
		 * rotate(Math.PI/2);
		 * </listing>
		 * só executa UMA rotação de 90º.
		 * 
		 * @param	angle O ângulo da rotação, em radianos.
		 * @see setRotationAxis
		 */
		public function rotate (angle:Number) : void
		{
			var cosseno:Number = Math.cos(angle);
			var seno:Number = Math.sin(angle);
			
			// Lê a última transformação salva [método addRestorePoint()]
			var currentTransform:Matrix = _transformHistory[_transformHistory.length - 1].clone();
			
			// Calcula a posição-imagem do registration-point deste DisplayObject
			var registrationPointPosition:Point = new Point(
				_rotationAxis.x - cosseno * _rotationAxis.x - seno * _rotationAxis.y + cosseno * currentTransform.tx + seno * currentTransform.ty,
				_rotationAxis.y + seno * _rotationAxis.x - cosseno * _rotationAxis.y - seno * currentTransform.tx + cosseno * currentTransform.ty
			);
			
			// Orienta este DisplayObject (rotação local; com relação ao sistema de referências do próprio DisplayObject)
			var localRotation:Matrix = new Matrix();
			localRotation.rotate(-angle);
			
			// Concatena as transformações anteriores com a rotação local
			currentTransform.tx = 0;
			currentTransform.ty = 0;
			currentTransform.concat(localRotation);
			currentTransform.tx = registrationPointPosition.x;
			currentTransform.ty = registrationPointPosition.y;
			
			// Aplica a transformação total neste DisplayObject
			this.transform.matrix = currentTransform;
		}
		
		/*
		 * Explicação do método reflect()
		 * 
		 * Para refletir um DisplayObject com relação a um eixo (reta) qualquer é necessário efetuar a reflexão do registration-point
		 * deste DisplayObject e aplicar duas transformações locais nele (com relação ao registration-point), nesta ordem: uma reflexão
		 * horizontal (scaleX = -1) e uma rotação de (2 * angulo), onde "angulo" é o ângulo de inclinação do eixo de reflexão (reta)
		 * com relação à vertical (eixo y).
		 */
		/**
		 * Reflete o <code>DisplayObject</code> com relação a um eixo (reta) pré-definido.
		 * @see setReflectionAxis
		 */
		public function reflect () : void
		{
			// Calcula o ponto de simetria da reflexão e o ângulo de inclinação do eixo com relação a vertical
			var a:Number = ((x - _reflectionAxis[0].x) * (_reflectionAxis[1].x - _reflectionAxis[0].x) + (y - _reflectionAxis[0].y) * (_reflectionAxis[1].y - _reflectionAxis[0].y)) / (Math.pow(_reflectionAxis[1].x - _reflectionAxis[0].x, 2) + Math.pow(_reflectionAxis[1].y - _reflectionAxis[0].y, 2));
			var pivot:Point = new Point(_reflectionAxis[0].x + a * (_reflectionAxis[1].x - _reflectionAxis[0].x), _reflectionAxis[0].y + a * (_reflectionAxis[1].y - _reflectionAxis[0].y));
			var angle:Number = Math.atan2(_reflectionAxis[1].x - _reflectionAxis[0].x, _reflectionAxis[1].y - _reflectionAxis[0].y);
			
			// A reflexão aplicada ao DisplayObject, com relação à sua origem (registration-point)
			var localReflection:Matrix = new Matrix();
			localReflection.scale(-1, 1);
			
			// A rotação aplicada ao DisplayObject, com relação à sua origem (registration-point)
			var localRotation:Matrix = new Matrix();
			localRotation.rotate(-2 * angle);
			
			// As duas transformações locais acima em conjunção orientam corretamente o DisplayObject
			localReflection.concat(localRotation);
			
			// Posiciona o (registration-point do) DisplayObject no ponto-imagem da reflexão
			var currentTransform:Matrix = this.transform.matrix.clone();
			currentTransform.tx = currentTransform.ty = 0;
			currentTransform.concat(localReflection);
			currentTransform.tx = 2 * pivot.x - x;
			currentTransform.ty = 2 * pivot.y - y;
			
			// Aplica todas as transformações acima no DisplayObject
			this.transform.matrix = currentTransform;
		}
		
		//--------------------------------------------------------------------------------
		// Membros privados
		//--------------------------------------------------------------------------------
		
		/**
		 * @private
		 * Menor distância permitida entre dois pontos do plano xy que definem o eixo de reflexão.
		 */
		private const MINIMUM_AXIS_DISTANCE:Number = 1;
		
		/**
		 * @private
		 * O eixo de rotação, definido por um ponto (x,y).
		 */
		private var _rotationAxis:Point;
		
		/**
		 * @private
		 * O eixo de reflexão, definido por dois pontos (x,y).
		 */
		private var _reflectionAxis:Array;
		
		/**
		 * @private
		 * Lista de transformações salvas.
		 */
		private var _transformHistory:Array;
		
		/**
		 * @private
		 * Configurações iniciais.
		 */
		private function init () : void
		{
		}
		
		/**
		 * @private
		 * Configurações de reset.
		 */
		private function reset () : void
		{
			// Configuração inicial dos eixos de rotação e de reflexão
			var zero:Point = new Point(0, 0);
			_reflectionAxis = [zero, zero];
			_rotationAxis = zero;
			
			// Cria a matriz que contém o histórico de transformações salvas [através do método addRestorePoint()]
			_transformHistory = new Array();
			setRestorePoint();
		}
	}
}