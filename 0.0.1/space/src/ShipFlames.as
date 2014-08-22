package 
{
	
	import org.flixel.*;
	
	public class ShipFlames extends FlxSprite  
	{
		private var myState1:*;
		public var keyDown:Number = 0;
		
		private var _offsetX:Number;
		private var _offsetY:Number;
		
		public function ShipFlames(offsetX:Number, offsetY:Number,myState:*):void
		{
			myState1 = myState;
			
			_offsetX = offsetX;
			_offsetY = offsetY;
			
			loadGraphic(GlobalVars.Flame, true, false, 2, 8);
			
			//bounding box tweaks
			width = 2;
			height = 8;
			
			addAnimation("off", [0], 10, true);
			addAnimation("on", [1, 2, 3, 4, 3, 2, 1], 15, true);
			play("off");
		}
		
		override public function update():void 
		{
			
			
			if (FlxG.keys.pressed("SPACE") && !myState1._ship.landed) //"X" is down, lets fly
			{
				x = myState1._ship.x + _offsetX;
				y = myState1._ship.y + _offsetY;
				//FlxG.play(GlobalVars.LaserSound, 1.0, false);
				play("on");
				
				
			}
			else
			{
				play("off");
			}
			super.update();
		}
	}
	
}