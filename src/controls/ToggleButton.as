package cepa.controls
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	public class ToggleButton extends MovieClip
	{
		/**
		 * Estado <source>ON</source> (ligado): o botão encontra-se ativo e responde ao clique sobre ele.
		 */
		public static const ON:String = "ON";
		
		/**
		 * Estado <source>OFF</source> (desligado): o botão encontra-se desativo e não responde ao clique sobre ele.
		 */
		public static const OFF:String = "OFF";
		
		/**
		 * @private
		 * Filtro de conversão para tons de cinza.
		 */
		private const GRAYSCALE_FILTER:ColorMatrixFilter = new ColorMatrixFilter([
			0.2225, 0.7169, 0.0606, 0, 0,
			0.2225, 0.7169, 0.0606, 0, 0,
			0.2225, 0.7169, 0.0606, 0, 0,
			0.0000, 0.0000, 0.0000, 1, 0
		]);
		
		/**
		 * @private
		 * O ícone do botão.
		 */
		private var _icon:DisplayObject;
		
		/**
		 * Cria um botão liga/desliga.
		 */
		public function ToggleButton ()
		{
			super();
			buttonMode = true;
			
			addEventListener(MouseEvent.CLICK, toggle);
		}
		
		/**
		 * O estado do botão: <source>ON</source> (ligado) ou <source>OFF</source> (desligado).
		 */
		public function get state () : String
		{
			return currentLabel;
		}
		
		/**
		 * @private
		 */
		public function set state (state:String) : void
		{
			if (state == ON)
			{
				gotoAndStop(ON);
			}
			else if (state == OFF)
			{
				gotoAndStop(OFF);
			}
			else throw new Error ("Unknown state " + state + ". Ignoring.");
		}
		
		/**
		 * O ícone do botão.
		 */
		public function get icon () : DisplayObject
		{
			return _icon;
		}
		
		/**
		 * @private
		 */
		public function set icon (icon:DisplayObject) : void
		{
			if (_icon)
			{
				removeChild(_icon);
			}
			
			_icon = icon;
			
			if (_icon)
			{
				//_icon.width = this.width;
				//_icon.height = this.height;
				_icon.width = 10;
				
				this.width = this.height = Math.sqrt(Math.pow(_icon.width, 2) + Math.pow(_icon.height, 2));
				addChild(_icon);
				
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set enabled (enabled:Boolean) : void
		{
			super.enabled = enabled;
			
			if (enabled)
			{
				this.filters = [];
			}
			else
			{
				this.filters = [GRAYSCALE_FILTER];
			}
		}
		
		/**
		 * @private
		 * Alterna entre os estados ON e OFF.
		 */
		private function toggle (event:Event) : void
		{
			if (enabled)
			{
				if (currentLabel == ON) gotoAndStop(OFF);
				else gotoAndStop(ON);	
			}
		}
	}
}