package 
{
	import org.flixel.*;
	
	
	public class AlienCreature extends FlxSprite
	{
		private var _moveSpeed:int = 400;
		private var _jumpPower:int = 30;
	
		
		private var _inGroup:FlxGroup;
		
		private var _bloodGibs:FlxEmitter;
		
		private var myState1:*; 
		
		private var _myPlayer :Player;
		
		private var _canJump:Boolean = false;
		private var jumpTimer:Number = 0;
		
	
		public function AlienCreature(X:Number, Y:Number, PlayerGibs:FlxGroup, MyPlayer:Player,  myState:*):void
		{
			super(X, Y);
			
			myState1 = myState;
			_inGroup = PlayerGibs;
			_myPlayer = MyPlayer;
			
			loadGraphic(GlobalVars.Alien, true, false, 14, 10);
			
			maxVelocity.x = 10;
			maxVelocity.y = 120;
			
			health = GlobalVars.alienHealth;
			//gravity
			acceleration.y = 200;
			//friction
			drag.x = 400;
			
			//bounding box tweaks 
			width = 6;
			height = 10;
			
			offset.x = 4;
			
			addAnimation("normal", [0, 1], 5, true);
			play("normal");
			
			_bloodGibs = new FlxEmitter(x, y);
			_bloodGibs.setXSpeed( -20, 20);
			_bloodGibs.setYSpeed( -30, 0);
			_bloodGibs.setRotation(0, 0);
			_bloodGibs.bounce = 0.1;
			_bloodGibs.gravity = 50;
			
			_bloodGibs.makeParticles(GlobalVars.Blood, 20, 16, false, 0.5);
			
			_inGroup.add(myState1.lyrSprites.add(_bloodGibs));
			myState1._collideGroup.add(_bloodGibs);
			
		}
		
		override public function update():void 
		{
			
			jumpTimer += FlxG.elapsed;
			if (jumpTimer >= 5 && _canJump)
			{
				_canJump = false;
				jumpTimer = 0;
				velocity.y = - _jumpPower;
			}
		
			if (y > myState1._map.height)
			{
				kill();
			}
			
			acceleration.x = 0;
			
			if (_myPlayer.x > x)
			{
				acceleration.x = drag.x;
			}
			if (_myPlayer.x < x)
			{
				acceleration.x = -drag.x;
			}
			
			if (isTouching(FLOOR))
			{
				_canJump = true;
			}
		
			
			if (_myPlayer.y < y && _canJump)
			{
				_canJump = false;
				velocity.y =- _jumpPower;
			}
			
			if (isTouching(WALL))
			{
				_canJump = false;
				jumpTimer = 0;
				velocity.y = - _jumpPower;
			}
		
			super.update();
			
		}
		
	
		override public function kill():void 
		{
			FlxG.play(GlobalVars.ExplosionSound);
			
			_bloodGibs.start(true, 1, 0.1, 20);
			_bloodGibs.at(this);
			super.kill();
		}
				
	}
	
}