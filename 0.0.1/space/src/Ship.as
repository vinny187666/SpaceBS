package 
{
	import org.flixel.*;
	
	
	public class Ship extends FlxSprite 
	{
		private var _moveSpeed:int = 400;
		private var _jumpPower:int = 100;
		public var _maxHealth:int = 10;
		private var _bullets:FlxGroup;
		
		private var _inGroup:FlxGroup;
		
		//controls invincibility after being hit
		public var _hurtCounter:Number = 0;
		
		public var canFly:Boolean = false;
		
		private var _shipGibs:FlxEmitter;
		
		private var myState1:*; 
		
		private var _canJump:Boolean = true;
		private var keyDown:Number = 0;
		public var landed:Boolean = false;
		private var disembarked:Boolean = false;
		private var velocityYLastFrame:uint;
		
		private var shipFlames:FlxEmitter;
		private var shipSmoke:FlxEmitter;
		private var shipSmoke2:FlxEmitter;
		public var canExit:Boolean = false;
		private var touchingFloorLastUpdate:Boolean = false;
		
		
		public function Ship(X:Number, Y:Number, PlayerGibs:FlxGroup, myState:*):void
		{
			super(X, Y);
			
			myState1 = myState;
			
			_inGroup = PlayerGibs;
			
			
			loadGraphic(GlobalVars.Ufo, true, false, 14, 12);
			maxVelocity.x = 40;
			maxVelocity.y = 100;
			
			
			//gravity
			acceleration.y = myState1.getGravity();
			//friction
			drag.x = 400;
			
			//bounding box tweaks 
			width = 14;
			height = 12;
			addAnimation("flying", [0, 1, 2, 3, 4], 10, true);
			addAnimation("landedDoorClosed", [5, 6], 10, true);
			addAnimation("landedDoorOpen", [7, 8], 10, true);
		
		
			play("flying");
			
			shipFlames = new FlxEmitter(x, y );
			shipFlames.setXSpeed( -40, 50);
			shipFlames.setYSpeed( 30, 0);
			shipFlames.setRotation(0, 0);
			shipFlames.bounce = 0.1;
			shipFlames.gravity = myState1.getGravity();
			
			//look for good settings for fire 
			shipFlames.makeParticles(GlobalVars.Blood, 100, 16, false, 0.5);
			
			
			
			shipSmoke = new FlxEmitter(x, y );
			shipSmoke.setXSpeed( -4, 4);
			shipSmoke.setYSpeed( -1, 0);
			shipSmoke.setRotation(0, 0);
			shipSmoke.bounce = 0.1;
			//shipSmoke.gravity = myState1.getGravity();
			
			//look for good settings for fire 
			shipSmoke.makeParticles(GlobalVars.SmokeParticle, 100, 16, false, 0.5);
			
			
			shipSmoke2 = new FlxEmitter(x, y );
			shipSmoke2.setXSpeed( -4, 4);
			shipSmoke2.setYSpeed( -1, 0);
			shipSmoke2.setRotation(0, 0);
			shipSmoke2.bounce = 0.1;
			//shipSmoke.gravity = myState1.getGravity();
			
			//look for good settings for fire 
			shipSmoke2.makeParticles(GlobalVars.SmokeParticle, 100, 16, false, 0.5);
			
			
		
		
			
		
			
			_shipGibs = new FlxEmitter(x, y);
			_shipGibs.setXSpeed( -60, 60);
			_shipGibs.setYSpeed( -60, 0);
			_shipGibs.setRotation(0, 0);
			_shipGibs.bounce = 0.1;
			_shipGibs.gravity = 50;
			
			_shipGibs.makeParticles(GlobalVars.ShipGibs, 40, 16, true, 0.5);
		
			_inGroup.add(_shipGibs);
			myState1._collideGroup.add(_shipGibs);
			_inGroup.add(shipSmoke);
			myState1._collideGroup.add(shipSmoke);
			_inGroup.add(shipFlames);
			myState1._collideGroup.add(shipFlames);
			
		
		}
		
		override public function update():void 
		{
			//TODO THIS CONTROLS NEED FIXING OR REFACTORING
			
			if(y > myState1.atmosphereTop){
				canExit = true;
			}
			
			if (isTouching(FLOOR))
			{
				
				    //if we werent touching floor last update
					//then we are landing this update
					if (!touchingFloorLastUpdate)
					{
						if (velocityYLastFrame > 85)
						{
							kill();
						}
						else
						{
							landed = true;
							play("landedDoorClosed");
							
							velocity = new FlxPoint(0, 0);
							acceleration = new FlxPoint(0, myState1.getGravity());
							
							
							//landed and stopped here, we can either get out or fly off again
							//need code to fly off
						}
					}
					else //we were touching the floor last update so were landed
					{	
						
						
						if (FlxG.keys.justPressed("ENTER") && !disembarked)
						{
							
							myState1.addPlayerToScreen();
							disembarked = true;
							play("landedDoorOpen");
							
						}
						
						
						
						FlxG.overlap(myState1._player, this, enterShip);
						
						if(myState1.backInShip)
						{
							play("landedDoorClosed");
							handleInput();
							if (FlxG.keys.justPressed("ENTER"))
							{
								
								myState1.addPlayerToScreen();
								disembarked = true;
								play("landedDoorOpen");
								
							}
						}
					}
					
				
			}
			else
			{	
				handleInput();
				
			
			}
			
			
			velocityYLastFrame = velocity.y;
			touchingFloorLastUpdate = isTouching(FLOOR);
			super.update();
		
		}
		
		private function enterShip(player:Player, ship:Ship):void
		{
			if(FlxG.keys.pressed("J")){
				myState1.enterShip();
			}
		}
		
		override public function kill():void 
		{
			FlxG.play(GlobalVars.ExplosionSound);
			
			_shipGibs.start(true, 3);
			_shipGibs.x = x + width / 2;
			_shipGibs.y = y + height - 5;
			
			
			super.kill();
		}
	
		private function handleInput():void{
			
			
			if (isTouching(FLOOR)){
				
				velocity = new FlxPoint(0, 0);
				acceleration = new FlxPoint(0, myState1.getGravity());
				
				
				
				if (FlxG.keys.pressed("SPACE"))
				{
					//trace("play sound now in ship");
					shipFlames.x = this.x + this.width / 2 ;
					shipFlames.y  = this.y + this.height - 2;
					shipFlames.start(false, 2, 0.001);
					shipSmoke.x = this.x + this.width / 2 ;
					shipSmoke.y  = this.y + this.height -1;
					shipSmoke.setXSpeed( -30, 40);
					shipSmoke.setYSpeed( 30, 0);
					shipSmoke.gravity = myState1.getGravity();
					shipSmoke.start(false, 50, 0.001);
					
					
					
					
					
					
					shipSmoke2.x = this.x + this.width / 2 ;
					shipSmoke2.y  = this.y + this.height + 8;
					shipSmoke2.setXSpeed( -4, 4);
					shipSmoke2.setYSpeed( -1, 0);
					shipSmoke2.gravity = 0;
					shipSmoke2.start(true, 5);
					
					//shipFlames2.x = this.x + 24;
					//shipFlames2.y  = this.y + 22;
					//shipFlames2.start(false, 2, 0.001);
					FlxG.play(GlobalVars.RocketSound, 1.0, false);
					
					velocity.y =- 30;
				}
				
			}else{
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
				//can only fly up if we arent touching the floor
				if (FlxG.keys.pressed("SPACE"))
				{
					//trace("play sound now in ship");
					shipFlames.x = this.x + this.width / 2 ;
					shipFlames.y  = this.y + this.height - 2;
					shipFlames.start(false, 2, 0.001);
					shipSmoke.x = this.x + this.width / 2 ;
					shipSmoke.y  = this.y + this.height -1;
					shipSmoke.setXSpeed( -30, 40);
					shipSmoke.setYSpeed( 30, 0);
					shipSmoke.gravity = myState1.getGravity();
					shipSmoke.start(false, 50, 0.001);
					
					
					
					
					
					
					shipSmoke2.x = this.x + this.width / 2 ;
					shipSmoke2.y  = this.y + this.height + 8;
					shipSmoke2.setXSpeed( -4, 4);
					shipSmoke2.setYSpeed( -1, 0);
					shipSmoke2.gravity = 0;
					shipSmoke2.start(true, 5);
					
					//shipFlames2.x = this.x + 24;
					//shipFlames2.y  = this.y + 22;
					//shipFlames2.start(false, 2, 0.001);
					FlxG.play(GlobalVars.RocketSound, 1.0, false);
					
					velocity.y =- 30;
				}else {
					
					if(FlxG.keys.justReleased("SPACE"))
					{
						//	shipSmoke.x = this.x + this.width / 2 ;
						//	shipSmoke.y  = this.y + this.height + 8;
						//	shipSmoke.setXSpeed( -4, 4);
						//	shipSmoke.setYSpeed( -1, 0);
						//	shipSmoke.gravity = 0;
						//	shipSmoke.start(true, 5);
						shipFlames.kill();
						
					}
					shipSmoke.kill();
				}
			}
		}
	}
	
}