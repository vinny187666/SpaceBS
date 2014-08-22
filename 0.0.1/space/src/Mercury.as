package 
{
	
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Scene;
	import flash.display.Stage;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	public class  Mercury extends FlxState
	{
				
		public var _player:Player;
	//	public var flameSprite:FlameSprite;
		
		public var lyrStage:FlxGroup;
		public var lyrSprites:FlxGroup;
				
		public var _map:FlxTilemap;
		//private var _map1x1:FlxTilemap;
		
		private var _foregroundRocksMap:FlxTilemap;
		private var _backgroundRocksMap:FlxTilemap;
		private var _hazeStuffMap:FlxTilemap;
		private var _hazeMap:FlxTilemap;
		private var _skyMap:FlxTilemap;
		
		
		private var _playerBullets:FlxGroup;
		private var _hearts:FlxGroup;
		
		public var emitGroup:FlxGroup;
		public var _enemyArray:FlxGroup;
		
		//public static var _enemyArray:FlxGroup;
		
		public var particlesGroup:FlxGroup;
		
		private var _mapGroup:FlxGroup = new FlxGroup;
		public var _collideGroup:FlxGroup = new FlxGroup;
	//	public var _bulletGroup:FlxGroup = new FlxGroup;
		
		private var _alien:AlienCreature;
		private var _alien2:AlienCreature;
		private var _alien3:AlienCreature;
		
		public var _ship:Ship;
		//private var shipThruster:ShipFlames;
		//private var shipThruster1:ShipFlames;
		//private var previousHealth:Number;
		private var gravity:int;
		public var atmosphereTop:Number = -500;
		public var backInShip:Boolean = true;
		
		public function Mercury():void
		{
			
		}
		
	
		
		override public function create():void
		{
			//this line was needed for some unknown reason grr
			FlxG.mute = false;
			FlxG.mouse.show();
			gravity = 200;
			lyrStage = new FlxGroup;
			lyrSprites = new FlxGroup;
			_enemyArray = new FlxGroup;
			//_mapGroup = new FlxGroup;
			_playerBullets = new FlxGroup;
			
		//	flameSprite = new FlameSprite(this);
			
		
			//_map = new FlxTilemap;
		
			//_map.loadMap(new GlobalVars.Dirt4x4Map, GlobalVars.Dirt4x4, 4, 4);
			//_map.scrollFactor.x = 1;
			
		//	_map1x1 = new FlxTilemap;
		
		//	_map1x1.loadMap(new GlobalVars.Dirt1x1Map, GlobalVars.Dirt1x1, 1, 1);
		//	_map1x1.scrollFactor.x = 1;
			
			_map = new FlxTilemap;
			_map.loadMap(GlobalVars.mercuryGroundString, GlobalVars.Dirt1x1, 1, 1);
			_map.scrollFactor.x = 1;
			
			_foregroundRocksMap = new FlxTilemap;
			_foregroundRocksMap.y = 40;
			_foregroundRocksMap.loadMap(new GlobalVars.ForegroundRocksMap, GlobalVars.ForegroundRocks, 72, 72);
			_foregroundRocksMap.scrollFactor.x = .8;
			
			_backgroundRocksMap = new FlxTilemap;
			_backgroundRocksMap.y = 32;
			_backgroundRocksMap.loadMap(new GlobalVars.BackgroundRocksMap, GlobalVars.BackgroundRocks, 72, 72);
			_backgroundRocksMap.scrollFactor.x = .5;
			
			_hazeStuffMap = new FlxTilemap;
			_hazeStuffMap.y = -8;
			_hazeStuffMap.loadMap(new GlobalVars.HazeStuffMap, GlobalVars.HazeStuff, 28, 28);
			_hazeStuffMap.scrollFactor.x = .2;
			
			
			_hazeMap = new FlxTilemap;
			_hazeMap.y = 4;
			_hazeMap.loadMap(new GlobalVars.HazeMap, GlobalVars.Haze, 18, 18);
			_hazeMap.scrollFactor.x = .1;
			
			_skyMap = new FlxTilemap;
			_skyMap.loadMap(new GlobalVars.SkyMap, GlobalVars.Sky, 74, 74);
			_skyMap.scrollFactor.x = .1;
			
		
			
		//	//make some bullets for the player
		//	for (var i:int = 0; i < 25; i += 1)
		//	{
		//		_playerBullets.add(new Bullet(0, 0, 0, 0, lyrSprites, this));
		//	}
			
			//make the player
		
			_ship = new Ship(_map.width / 2, -600, lyrSprites, this);
			
		//	shipThruster = new ShipFlames(2, 21, this);
		//	shipThruster1 = new ShipFlames(22, 21 , this);
			
		
			
			//add in order to be displayed
			lyrStage.add(_skyMap);
		
			lyrStage.add(_hazeMap);
			lyrStage.add(_hazeStuffMap);
			lyrStage.add(_backgroundRocksMap);
			lyrStage.add(_foregroundRocksMap);
			lyrStage.add(_map);
		//	lyrStage.add(_map1x1);
			
		
			lyrSprites.add(_ship);
			
			_player = new Player(10, 0, _playerBullets, lyrSprites, this);
			
			
			_alien = new AlienCreature(20, 0, lyrSprites, _player, this);
			_alien2 = new AlienCreature(120, 0, lyrSprites, _player, this);
			_alien3 = new AlienCreature(60, 0, lyrSprites, _player, this);
			
			_enemyArray.add(_alien);
			_enemyArray.add(_alien2);
			_enemyArray.add(_alien3);
			
			lyrSprites.add(_playerBullets);
		
			
			lyrSprites.add(_enemyArray);
						
			//add the layers to the stage
			this.add(lyrStage);
			this.add(lyrSprites);
			
			
			_mapGroup.add(_map);
		//	_mapGroup.add(_map1x1);
			
			_collideGroup.add(_player);
			
			_collideGroup.add(_enemyArray);
			_collideGroup.add(_ship);
			
			
		
			FlxG.camera.follow(_ship, 0);
			
			
			FlxG.camera.bounds = new FlxRect(0, atmosphereTop, _map.width, _map.height - atmosphereTop);
			FlxG.worldBounds = new FlxRect(0, atmosphereTop, _map.width, _map.height- atmosphereTop);
			
								
			
		}
		
		override public function update():void
		{
	
			if(_ship.canExit && _ship.y < atmosphereTop - _ship.height){
				//need a way to save the state of this planet before we exit
				//and reload it next time we come back here
				FlxG.switchState(new LevelMenuState());
			}
			
		
		
			
			if (FlxG.keys.justPressed("I"))
			{
				FlxG.visualDebug = ! FlxG.visualDebug;
				
			}
			//logic before this
			super.update();
			//collision after
			
			
			//if player collides with enemy, call pHit
			FlxG.overlap(_player, _enemyArray, pHit);
			FlxG.overlap(_enemyArray, _playerBullets, laserHitEnemy);
			
			FlxG.collide(_mapGroup, _collideGroup);
			FlxG.collide(_enemyArray, _player);
			
			//FlxG.collide(_playerBullets, _map, destroyTileOnCollision);
			
			//maybe have a certain weapon only destroy the ground
			//check if we are using it first, otherwise use a different callback or none at all
			FlxG.collide(_playerBullets, _mapGroup, destroyTileOnCollision);
			
		}
		
		private function destroyTileOnCollision(bullet:FlxObject, tile:FlxTilemap):void
		{
			var tileIndexX:uint = 0;
			var tileIndexY:uint = 0;
			
			var tileWidth:Number = tile.width / tile.widthInTiles;
			var tileHeight:Number = tile.height / tile.heightInTiles;
			tileIndexX = bullet.x / tileWidth ;
			tileIndexY = bullet.y / tileHeight ;
			
			
				tile.setTile(tileIndexX, tileIndexY, 0, true);
				tile.setTile(tileIndexX , tileIndexY + 1, 0, true);
				tile.setTile(tileIndexX , tileIndexY - 1, 0, true);
				tile.setTile(tileIndexX + 1, tileIndexY, 0, true);
				tile.setTile(tileIndexX + 1, tileIndexY + 1 , 0, true);
				tile.setTile(tileIndexX + 1, tileIndexY - 1, 0, true);
				tile.setTile(tileIndexX - 1, tileIndexY, 0, true);
				tile.setTile(tileIndexX - 1, tileIndexY + 1, 0, true);
				tile.setTile(tileIndexX - 1, tileIndexY - 1, 0, true);
				
				//tile.update();
				bullet.kill();
				
		
			
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
		
		public function addPlayerToScreen():void
		{
			_player.x = (_ship.x + _ship.width / 2) - _player.width / 2; 
			_player.y = _ship.y + _ship.height - _player.height;
			
			lyrSprites.add(_player);
			FlxG.camera.follow(_player, 0);
			backInShip = false;
		}
		
		public function enterShip():void
		{
			//remove the player and give control back over to the ship
			lyrSprites. remove(_player);			
			FlxG.camera.follow(_ship, 0);
			backInShip = true;
		}
		
		//maybe we have a planet parent class to put this in?
		//ALL STATES MUST HAVE THIS OR PLAYER WILL CRASH
		public function getGravity():int
		{
			return this.gravity;
		}
		
		override public function destroy():void
		{
			//SAVE THE STATE OF THE MAP BACK INTO GLOBALVARS
			GlobalVars.mercuryGroundString = FlxTilemap.arrayToCSV(_map.getData(), _map.widthInTiles); 
		
		}
	}
	
}