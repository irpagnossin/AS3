package utils
{
	import interfaces.Serializable;
	
	/**
	 * A classe <code>Angle</code> representa um ângulo, em graus ou em radianos, no intervalo [-π,+π[ ou [0,+2π[.
	 * @author Ivan Ramos Pagnossin
	 * @version 1.0 (2011.01.24)
	 */
	public class Angle implements Serializable
	{
		//--------------------------------
		// Membros públicos (interface).
		//--------------------------------
		
		/**
		 * Domínio [-π,+π].
		 * @see domain
		 */
		public static const MINUS_PI_TO_PLUS_PI:String = "MINUS_PI_TO_PLUS_PI";
		
		/**
		 * Domínio [0,+2π].
		 * @see domain
		 */
		public static const ZERO_TO_PLUS_2PI:String = "ZERO_TO_PLUS_2PI";
		
		/**
		 * Cria um objeto do tipo ângulo com valor padrão igual a zero e domínio [-π,+π[.
		 * Se for dado um argumento ao construtor, cria um novo ângulo com o mesmo valor e domínio do ângulo dado.
		 */
		public function Angle (angle:Angle = null)
		{
			if (angle)
			{
				_radians = angle.radians;
				_domain = angle.domain;
			}
			else
			{
				_radians = 0;
				_domain = MINUS_PI_TO_PLUS_PI;
			}
		}
		
		/**
		 * O ângulo em radianos, no domínio definido por <code>domain</code>.
		 * @see domain
		 */
		public function get radians () : Number
		{
			return _radians;
		}
		
		/**
		 * @private
		 */
		public function set radians (angle:Number) : void
		{
			_radians = wrap(angle);
		}
		
		/**
		 * O ângulo em graus, no domínio definido por <code>domain</code>.
		 * @see domain
		 */
		public function get degrees () : Number
		{
			return toDegrees(_radians);
		}
		
		/**
		 * @private
		 */
		public function set degrees (angle:Number) : void
		{
			_radians = wrap(toRadians(angle));
		}
		
		/**
		 * O domínio do ângulo.
		 * @see MINUS_PI_TO_PLUS_PI
		 * @see ZERO_TO_PLUS_2PI
		 */
		public function get domain () : String
		{
			return _domain;
		}
		
		/**
		 * @private
		 */
		public function set domain (name:String) : void
		{
			if (name == MINUS_PI_TO_PLUS_PI || name == ZERO_TO_PLUS_2PI)
			{
				_domain = name;
				_radians = wrap(_radians);
			}
			else
			{
				throw new Error("Domínio desconhecido.");
			}
		}
		
		/**
		 * O seno do ângulo.
		 * @return	O seno do ângulo.
		 */
		public function sin () : Number
		{
			return Math.sin(_radians);
		}
		
		/**
		 * O cosseno do ângulo.
		 * @return	O cosseno do ângulo.
		 */
		public function cos () : Number
		{
			return Math.cos(_radians);
		}
		
		/**
		 * A tangente do ângulo.
		 * @return	A tangente do ângulo.
		 */
		public function tan () : Number
		{
			return Math.tan(_radians);
		}

		/**
		 * Retorna uma string que representa o ângulo.
		 * @return Representação do ângulo.
		 */
		public function toString () : String
		{
			return "Ângulo " + Math.round(degrees) + "º = " + radians.toFixed(1) + " rad no domínio " + (_domain == MINUS_PI_TO_PLUS_PI ? "[-π, +π[." : "[0, +2π[.");
		}
		
		/**
		 * Serializa o ângulo (numa string).
		 * @return	A serialização do ângulo.
		 * @see deserialize
		 */
		public function get serialization () : String
		{
			return "_radians:" + _radians + "\t_domain:" + _domain;
		}
		
		/**
		 * Constrói o ângulo (Angle) a partir de uma serialização dada.
		 * @param	serialization	Serialização, criada pelo método <code>serialize()</code>.
		 * @see serialize
		 */
		public function set serialization (serialization:String) : void
		{
			var properties:Array = serialization.split("\t");
			var error:Error = new Error("Isto não é um ângulo (Angle).");
			
			try
			{
				if (properties.length != 2) throw error;
				
				var angle_definition:Array = properties[0].split(":");
				if (angle_definition.length != 2 || angle_definition[0] != "_radians") throw error;
				var angle_value:Number = Number(angle_definition[1]);
				if (isNaN(angle_value)) throw error;
				
				var domain_definition:Array = properties[1].split(":");
				if (domain_definition.length != 2 || domain_definition[0] != "_domain") throw error;
				var domain_value:String = domain_definition[1];
				
				_domain = domain_value;
				_radians = wrap(angle_value);
			}
			catch (e:Error)
			{
				throw e;
			}
		}
		
		//--------------------------------
		// Membros privados.
		//--------------------------------
		
		/*
		 * Mantém o ângulo no domínio.
		 */
		private function wrap (angle:Number) : Number
		{
			var ans:Number;
			
			if (_domain == MINUS_PI_TO_PLUS_PI) ans = angle - Math.floor((angle + Math.PI) / (2 * Math.PI)) * (2 * Math.PI);
			else ans = ans = angle - Math.floor(angle / (2 * Math.PI)) * (2 * Math.PI);
			
			return ans;
		}
		
		/*
		 * Converte radianos para graus.
		 */
		private function toDegrees (radians:Number) : Number
		{
			return radians * 180 / Math.PI;
		}
		
		/*
		 * Converte graus para radianos.
		 */
		private function toRadians (degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
		
		private var _radians:Number; // O valor do ângulo, sempre dentro do domínio definido.
		private var _domain:String; // O domínio do ângulo.
	}
}