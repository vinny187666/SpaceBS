package 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Player extends FlxSprite 
	{
		//TODO make the player able to get in the ship and fly back to level menu state
		private var _moveSpeed:int = 400;
		private var _jumpPower:int = 100;
		public var _maxHealth:int = 10;
		private var _bullets:FlxGroup;
		
		private var _inGroup:FlxGroup;
		
		//controls invincibility after being hit
		public var _hurtCounter:Number = 0;
		
		public var canFly:Boolean = false;
		
		private var _bloodGibs:FlxEmitter;
		private var _jetpackFlames:FlxEmitter;
		
		private var myState1:*; 
		
		private var _canJump:Boolean = true;
		private var keyDownTime:Number = 0;
		
		
		private var weapon:FlxWeapon; //player.weapon
	//	private var control:FlxControl;
		private var damageSize:int = 1; //player.dmgSize
		private var keyDownCounter:Number = 0;
		private const JETPACK_FLAME_OFFSET:uint = 4;
		
		public function Player(X:Number, Y:Number, Bullets:FlxGroup, PlayerGibs:FlxGroup, myState:*):void
		{
			super(X, Y);
			
			myState1 = myState;
			
			_inGroup = PlayerGibs;
			_bullets = Bullets;
			
			loadGraphic(GlobalVars.Astronaut, true, false, 2, 4);
			
			maxVelocity.x = 40;
			maxVelocity.y = 120;
			
			health = GlobalVars.myPlayerHealth;
			
			//gravity
			acceleration.y = myState1.getGravity();
			//friction
			drag.x = 400;
			
			//bounding box tweaks
			width = 2;
			height = 4;
			
			//setup players animations
			addAnimation("fullHealth", [0], 10, false);
			addAnimation("health3", [1], 10, false);
			addAnimation("health2", [2], 10, false);
			addAnimation("health1", [3], 10, false);
			
			play("fullHealth");
			
			//setup players particle emitters
			_jetpackFlames = new FlxEmitter(x, y + JETPACK_FLAME_OFFSET);
			_jetpackFlames.setXSpeed( -20, 20);
			_jetpackFlames.setYSpeed( 30, 0);
			_jetpackFlames.setRotation(0, 0);
			_jetpackFlames.bounce = 0.1;
			_jetpackFlames.gravity = myState1.getGravity();
			
			//look for good settings for fire 
			_jetpackFlames.makeParticles(GlobalVars.Blood, 100, 16, false, 0.5);
			
			//_inGroup.add(myState1.lyrSprites.add(_jetpackFlames));
			_inGroup.add(_jetpackFlames);
			myState1._collideGroup.add(_jetpackFlames);
			
			_bloodGibs = new FlxEmitter(x, y);
			_bloodGibs.setXSpeed( -20, 20);
			_bloodGibs.setYSpeed( -30, 0);
			_bloodGibs.setRotation(0, 0);
			_bloodGibs.bounce = 0.1;
			_bloodGibs.gravity = myState1.getGravity();
			
			_bloodGibs.makeParticles(GlobalVars.Blood, 20, 16, false, 0.5);
			
			_inGroup.add(_bloodGibs);
			myState1._collideGroup.add(_bloodGibs);
			
			
			
			//	Creates our weapon. We'll call it "canon" and link it to the x/y coordinates of the tank sprite
			weapon = new FlxWeapon("weapon", this, "x", "y");
			
		
			//	Tell the weapon to create 100 bullets using a 2x2 white pixel bullet
			weapon.makePixelBullet(100, 1, 1, 0xffffffff, 0, 0);
			
			//	Bullets will move at 120px/sec
			weapon.setBulletSpeed(120);
			
			//	But bullets will have gravity pulling them down to earth at a rate of 60px/sec
			weapon.setBulletGravity(0, myState1.getGravity());
			
			//	As we use the mouse to fire we need to limit how many bullets are shot at once (1 every 50ms)
			weapon.setFireRate(200);
			
			//FlxG.camera.bounds = new FlxRect(0, -100, _map.width, _map.height + 100);
			weapon.setBulletBounds(new FlxRect(0, 0, myState1._map.width, myState1._map.height));
			//TODO ADD THE BULLETS HERE IF THEY DONT SHOW UP
			//myState1._collideGroup.add(weapon.group);
			_bullets.add(weapon.group);
			
			
			
			
		}
		
		override public function update():void 
		{
			
			
			if (_hurtCounter > 0)
			{
				_hurtCounter -= FlxG.elapsed * 3;
			}
			//kill the player if we go off the bottom of the map
			if (y > myState1._map.height)
			{
				kill();
			}
			//stop moving as default
			if (!FlxG.keys.LEFT && !FlxG.keys.RIGHT)
			{
				acceleration.x = 0;
			}
			
	
			if (isTouching(FLOOR))
			{
				_canJump = true;
				canFly = true;
				keyDownCounter = 0;
			}
		
			
			if (FlxG.keys.A)
			{
				facing = LEFT;
				acceleration.x = -drag.x;
			}
			else if (FlxG.keys.D)
			{
				facing = RIGHT;
				acceleration.x = drag.x;
			}
			
	
			
			if (FlxG.keys.pressed("SPACE")) //"X" is down, lets fly
			{
				if ((FlxG.keys.justPressed("SPACE")) && _canJump == true)
				{
					FlxG.play(GlobalVars.JumpSound);
					_canJump = false;
					velocity.y =- _jumpPower;
				}
				else
				{
					
					
					keyDownCounter += FlxG.elapsed;
					if (keyDownCounter > .2 && canFly == true) //key being held down?
					{
						velocity.y = -10; //lets fly upwards
						acceleration.y = -20;
						
						//_jetpackFlames.y = y;
						
						//if (facing) 
						//	{
						//emitters x on left, this.x on right
						//		_jetpackFlames.x = x - 2; //chuck the flame on the left
						//	}
						//	else
						//	{
						//		_jetpackFlames. x = x + 2; //chuck the flame on the right
						//	}
						
						// turn on emitter
						_jetpackFlames.x = this.x + this.width / 2;
						_jetpackFlames.y  = this.y + JETPACK_FLAME_OFFSET;
						_jetpackFlames.start(false, 2, 0.001);
						
						FlxG.play(GlobalVars.RocketSound, 1.0, false);
					}
				}
			}
			else //"X" is not down
			{		//fall towards the ground
				acceleration.y = 200;
				
				//_jetpackFlames.on = false;
				_jetpackFlames.kill();
			}
			
			if (keyDownCounter > 3) //can only fly for 3 seconds at a time
			{
				canFly = false;
				acceleration.y = 200; //fall towards the ground
			
				//_jetpackFlames.on = false;
				_jetpackFlames.kill();
			}
			
			
			//if we are midway through jumping and release the key, cut the jump short and start to drop
			if (FlxG.keys.justReleased("SPACE") && _canJump == false && velocity.y < 0)
			{
				velocity.y = -.01;
			}
			
			
			if (FlxG.keys.pressed("C"))
			{
			
			}
			if(FlxG.mouse.justPressed())
			{
				//fireBullet(facing);
				
					
					weapon.fireAtMouse();
			//TODO USE FLXCONTROL
					
				
			}
			
			super.update();
			_canJump = false;
		}
		
		override public function hurt(Damage:Number):void
		{
			
			if (_hurtCounter <= 0)
			{
				FlxG.play(GlobalVars.HitSound);
				_hurtCounter = 3;
				return super.hurt(Damage);
			}
			if (health == 3)
			{
				play("health3");
			}
			if (health == 2)
			{
				play("health2");
			}
			if (health == 1)
			{
				play("health1");
			}
		}
		
		private function fireBullet(dir:uint):void
		{
			var XVelocity:Number;
			if (dir == RIGHT)
			XVelocity = 400;
			else
			XVelocity = -400;
			
			for (var i:uint = 0; i < _bullets.members.length; i++)
			{
				if (!_bullets.members[i].exists)
				{
					FlxG.play(GlobalVars.LaserSound);
					if (dir == RIGHT)
					{
						_bullets.members[i].resetBullet(this.x + 2, this.y, XVelocity, 0);
						return;
					}
					else
					{
						_bullets.members[i].resetBullet(this.x - 2, this.y, XVelocity, 0);
						return;
					}
				}
			}
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