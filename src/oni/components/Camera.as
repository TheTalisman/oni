package oni.components 
{
	import oni.Oni;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	/**
	 * ...
	 * @author Sam Hellawell
	 */
	public class Camera extends EventDispatcher
	{
		public var smoothing:Number = 0.25;
		
		public var limit:Boolean = true;
		
		private var _x:int, _holdX:int;
		
		private var _y:int, _holdY:int;
		
		private var _z:Number;
		
		public function Camera() 
		{
			//Initialise variables
			_x = _y = 0;
			_z = 1;
			_holdX = _holdY = -1;
			
			//Listen for update
			addEventListener(Oni.UPDATE, _onUpdate);
		}
		
		private function _onUpdate(e:Event):void
		{
			//Check if we should move
			if (_holdX != -1 || _holdY != -1)
			{
				//Linear interpolate X
				if (_holdX != -1)
				{
					//Set X
					_x = Math.ceil(((1 - smoothing) * x) + (smoothing * _holdX));
					
					//Check if we should reset
					if (_x == _holdX) _holdX = -1;
					
					//Limit
					if (limit && _x < 0) _x = 0;
				}
				
				//Linear interpolate Y
				if (_holdY != -1)
				{
					//Set Y
					_y = Math.ceil(((1 - smoothing) * y) + (smoothing * _holdY));
					
					//Check if we should reset
					if (_y == _holdY) _holdY = -1;
					
					//Limit
					if (limit && _y < 0) _y = 0;
				}
				
				//Dispatch event
				dispatchEventWith(Oni.UPDATE_POSITION, false, { x:_x, y:_y, z:_z } );
			}
		}
		
		public function get x():int
		{
			return _x;
		}
		
		public function set x(value:int):void
		{
			if(value != _holdX) _holdX = value;
		}
		
		public function get y():int
		{
			return _y;
		}
		
		public function set y(value:int):void
		{
			if(value != _holdY) _holdY = value;
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		public function set z(value:Number):void
		{
			//Limit
			if (value < 0.25) value = 0.25;
			if (value > 4) value = 4;
			
			//Set
			_z = value;
			
			//Dispatch event
			dispatchEventWith(Oni.UPDATE_POSITION, false, { x:_x, y:_y, z:_z } );
		}
		
	}

}