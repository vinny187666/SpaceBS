package 
{
	
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Scene;
	import flash.display.Stage;
	import org.flixel.*;
	public class  Venus extends FlxState
	{
				
		public var _player:Player;
	//	public var flameSprite:FlameSprite;
		
		public var lyrStage:FlxGroup;
		public var lyrSprites:FlxGroup;
				
		public var _map:FlxTilemap;
		private var _map2x2:FlxTilemap;
		
		private var _foregroundRocksMap:FlxTilemap;
		private var _backgroundRocksMap:FlxTilemap;
		private var _hazeStuffMap:FlxTilemap;
		private var _hazeMap:FlxTilemap;
		private var _skyMap:FlxTilemap;
		private var _skyMap1:FlxTilemap;
		private var _skyMap2:FlxTilemap;
		
		private var _playerBullets:FlxGroup;
		private var _hearts:FlxGroup;
		
		public var emitGroup:FlxGroup;
		public var _enemyArray:FlxGroup;
		
		//public static var _enemyArray:FlxGroup;
		
		public var particlesGroup:FlxGroup;
		
		private var _mapGroup:FlxGroup = new FlxGroup;
		public var _collideGroup:FlxGroup = new FlxGroup;
		
		private var _alien:AlienCreature;
		
		private var timeDeath:Number = 0;
		
		public function Venus():void
		{
			
		}
		
		override public function create():void
		{
			
			lyrStage = new FlxGroup;
			lyrSprites = new FlxGroup;
			_enemyArray = new FlxGroup;
			//_mapGroup = new FlxGroup;
			_playerBullets = new FlxGroup;
			
		//	flameSprite = new FlameSprite(this);
			
		
			_map = new FlxTilemap;
			
			_map.loadMap(new GlobalVars.Dirt4x4Map2, GlobalVars.Dirt4x4, 4, 4);
			_map.scrollFactor.x = 1;
			
			_map2x2 = new FlxTilemap;
		
			_map2x2.loadMap(new GlobalVars.Dirt2x2Map2, GlobalVars.Dirt2x2, 2, 2);
			_map2x2.scrollFactor.x = 1;
			
		
			_foregroundRocksMap = new FlxTilemap;
			//_foregroundRocksMap.y = 40;
			_foregroundRocksMap.loadMap(new GlobalVars.ForegroundRocksMap2, GlobalVars.ForegroundRocks, 72, 72);
			_foregroundRocksMap.scrollFactor.x = .8;
			
			_backgroundRocksMap = new FlxTilemap;
			//_backgroundRocksMap.y = 32;
			_backgroundRocksMap.loadMap(new GlobalVars.BackgroundRocksMap2, GlobalVars.BackgroundRocks, 72, 72);
			_backgroundRocksMap.scrollFactor.x = .5;
			
			_hazeStuffMap = new FlxTilemap;
			//_hazeStuffMap.y = -8;
			_hazeStuffMap.loadMap(new GlobalVars.HazeStuffMap2, GlobalVars.HazeStuff, 28, 28);
			_hazeStuffMap.scrollFactor.x = .2;
			
			
			_hazeMap = new FlxTilemap;
			//_hazeMap.y = 4;
			_hazeMap.loadMap(new GlobalVars.HazeMap2, GlobalVars.Haze, 18, 18);
			_hazeMap.scrollFactor.x = .1;
			
			_skyMap = new FlxTilemap;
			_skyMap.loadMap(new GlobalVars.SkyMap2, GlobalVars.Sky, 74, 74);
			_skyMap.scrollFactor.x = .1;
			
			_skyMap1 = new FlxTilemap;
			_skyMap1.loadMap(new GlobalVars.SkyMap2, GlobalVars.Sky, 74, 74);
			_skyMap1.scrollFactor.x = .1;
			_skyMap1.y =- 74;
			
			_skyMap2 = new FlxTilemap;
			_skyMap2.loadMap(new GlobalVars.SkyMap2, GlobalVars.Sky, 74, 74);
			_skyMap2.scrollFactor.x = .1;
			_skyMap2.y = - (74 + 74);
			
			//make some bullets for the player
		//	for (var i:int = 0; i < 25; i += 1)
		//	{
		//		_playerBullets.add(new Bullet(0, 0, 0, 0, lyrSprites, this));
		//	}
			
			//make the player
			_player = new Player(0, _map.height - 82, _playerBullets, lyrSprites, this);
			_alien = new AlienCreature(20, 0, lyrSprites, _player, this);
		
	
			_enemyArray.add(_alien);
			
			// add in order to be displayed
			lyrStage.add(_skyMap);
			lyrStage.add(_skyMap1);
			lyrStage.add(_skyMap2);
			lyrStage.add(_hazeMap);
			lyrStage.add(_hazeStuffMap);
			lyrStage.add(_backgroundRocksMap);
			lyrStage.add(_foregroundRocksMap);
			lyrStage.add(_map);
			lyrStage.add(_map2x2);
			
		
			
			lyrSprites.add(_player);
			lyrSprites.add(_playerBullets);
		//	lyrSprites.add(flameSprite);
			
			lyrSprites.add(_enemyArray);
						
			//add the layers to the stage
			this.add(lyrStage);
			this.add(lyrSprites);
					
			_mapGroup.add(_map);
			_mapGroup.add(_map2x2);
			
			_collideGroup.add(_player);
			_collideGroup.add(_playerBullets);
			_collideGroup.add(_enemyArray);
		
			
					
		
			FlxG.camera.follow(_player, 0);
		
			FlxG.camera.bounds = new FlxRect(0, 0, _map.width, _map.height);
			FlxG.worldBounds = new FlxRect(0, 0, _map.width, _map.height);
			
		
			
		}
		
		override public function update():void
		{
			//if (_player.x > _map.width)
			//{
			//	FlxG.switchState(new Stage2();
			//}
			if (FlxG.keys.justPressed("I"))
			{
				FlxG.visualDebug = ! FlxG.visualDebug;
			}
			//if we die just restart this stage after 3 seconds
			//TODO implement something else here
			if (!_player.alive)
			{
				timeDeath += FlxG.elapsed;
				if (timeDeath > 3)
				{
					FlxG.switchState(new Venus());
				}
			}
			//logic before this
			super.update();
			//collision after
			
			
			//if player collides with enemy, call pHit
			FlxG.overlap(_player, _enemyArray, pHit);
			FlxG.overlap(_enemyArray, _playerBullets, laserHitEnemy);
			
			FlxG.collide(_mapGroup, _collideGroup);
			FlxG.collide(_enemyArray, _player);
			
		}
		
		private function pHit(myPlayer:Player, myEnemy:FlxSprite):void
		{
			myPlayer.hurt(1);
		}
		
		private function laserHitEnemy(myEnemy:FlxSprite, myLaser:FlxSprite):void
		{
			myLaser.kill();
			myEnemy.hurt(1);
		}
		
		
		
	}
	
}