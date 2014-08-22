package 
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.flixel.*;
	
	
	//Global helper class contains helper methods for audio, input, config, and camera system
	public class GlobalVars 
	{
		static public var lives:int;
		
		static public var myPlayerHealth:int = 4;
		static public var alienHealth:int = 5;
		lives = 5;
		
		/**
			static public var save:FlxSave;
			save = new FlxSave();
			save.bind("mySave");
			save.erase(); 
					
			static public function saveProgress():void
			{
				if (save.bind("mySave"))
				{
					if (save.data.stage1Complete == null)
					{
						trace("save.data.stage1Complete == null, does not exist");
					}
					else
					{
						trace(save.data.stage1Complete + "stage1Complete");
					}
				}
			}
		 **/
		//TODO FIRE WITH FlxEmitter http://forums.flixel.org/index.php?topic=3040.0
	
		[Embed(source = 'sprites/smokeParticle.png')] static public var SmokeParticle:Class;
		[Embed(source = 'sprites/blood.png')] static public var Blood:Class;
		[Embed(source = 'sprites/alien14x10.png')] static public var Alien:Class;
		[Embed(source = 'sprites/startScreen.png')] static public var StartScreen:Class;
		[Embed(source = 'sprites/flame2x8.png')] static public var Flame:Class;
		[Embed(source = 'sprites/laser2x2.png')] static public var Laser:Class;
		[Embed(source = 'sprites/astronaut2x4.png')] static public var Astronaut:Class;
		[Embed(source = 'sprites/ship26x26.png')] static public var SpaceShip:Class;
		[Embed(source = 'sprites/shipGibs.png')] static public var ShipGibs:Class;
		[Embed(source = 'sprites/solarsystem.png')] static public var LevelMenuBackground:Class;
		[Embed(source = 'sprites/cursor.png')] static public var Cursor:Class;
		[Embed(source = 'sprites/ufo.png')] static public var Ufo:Class;
		
		[Embed(source = 'sprites/groundBlocks4x4.png')] static public var Dirt4x4:Class;
		[Embed(source = 'sprites/groundBlocks2x2.png')] static public var Dirt2x2:Class;
		[Embed(source = 'sprites/groundBlocks1x1.png')] static public var Dirt1x1:Class;
		[Embed(source = 'sprites/foregroundRocks72x72.png')] static public var ForegroundRocks:Class;
		[Embed(source = 'sprites/backgroundRocks72x72.png')] static public var BackgroundRocks:Class;
		[Embed(source = 'sprites/hazeStuff28x28.png')] static public var HazeStuff:Class;
		[Embed(source = 'sprites/haze18x18.png')] static public var Haze:Class;
		[Embed(source = 'sprites/skyBG74x74.png')] static public var Sky:Class;
		
		
		//////MAPS 
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_4x4blocks.txt', mimeType = "application/octet-stream")] static public var Dirt4x4Map:Class;
	//	[Embed(source = 'MapFiles/1x1/MapCSV_Map1_2x2blocks.txt', mimeType = "application/octet-stream")] static public var Dirt2x2Map:Class;
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_1x1blocks.txt', mimeType = "application/octet-stream")] static public var Dirt1x1Map:Class;
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_Sky.txt', mimeType = "application/octet-stream")] static public var SkyMap:Class;
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_Haze.txt', mimeType = "application/octet-stream")] static public var HazeMap:Class;
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_HazeStuff.txt', mimeType = "application/octet-stream")] static public var HazeStuffMap:Class;
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_BackgroundRocks.txt', mimeType = "application/octet-stream")] static public var BackgroundRocksMap:Class;
		[Embed(source = 'MapFiles/1x1/MapCSV_Map1_ForegroundRocks.txt', mimeType = "application/octet-stream")] static public var ForegroundRocksMap:Class;
		
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_4x4blocks.txt', mimeType = "application/octet-stream")] static public var Dirt4x4Map2:Class;
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_2x2blocks.txt', mimeType = "application/octet-stream")] static public var Dirt2x2Map2:Class;
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_Sky.txt', mimeType = "application/octet-stream")] static public var SkyMap2:Class;
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_Haze.txt', mimeType = "application/octet-stream")] static public var HazeMap2:Class;
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_HazeStuff.txt', mimeType = "application/octet-stream")] static public var HazeStuffMap2:Class;
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_BackgroundRocks.txt', mimeType = "application/octet-stream")] static public var BackgroundRocksMap2:Class;
		[Embed(source = 'MapFiles/Stage2/MapCSV_Map1_ForegroundRocks.txt', mimeType = "application/octet-stream")] static public var ForegroundRocksMap2:Class;
		
	
		//SOUNDS
		[Embed(source = 'sounds/explosion.mp3')] static public var  ExplosionSound:Class;
		[Embed(source = 'sounds/hit.mp3')] static public var  HitSound:Class;
		[Embed(source = 'sounds/jump.mp3')]static public var  JumpSound:Class;
		[Embed(source = 'sounds/laser.mp3')] static public var  LaserSound:Class;
		//TODO change the rocket it sounds awful
		[Embed(source = 'sounds/rocket.mp3')] static public var  RocketSound:Class;
		
		//public static var mercuryGround1x1:FlxTilemap;
		public static var mercuryGroundString:String;
		mercuryGroundString = new Dirt1x1Map;
		
		public static var mercuryUndergroundString:String;
	
		
		mercuryUndergroundString = FlxCaveGenerator.convertMatrixToStr(new FlxCaveGenerator(296, 600).generateCaveLevel());
		mercuryGroundString = mercuryGroundString.concat(mercuryUndergroundString);
		
		
		
		/*
		 * 
		// Create cave of size 200x100 tiles
		var cave:FlxCaveGenerator = new FlxCaveGenerator(200, 100);
		
		// Generate the level and returns a matrix
		// 0 = empty, 1 = wall tile
		var caveMatrix:Array = cave.generateCaveLevel();
		
		// Converts the matrix into a string that is readable by FlxTileMap
		var dataStr:String = FlxCaveGenerator.convertMatrixToStr( caveMatrix );
		
		// Loads tilemap of tilesize 16x16
		var tileMap:FlxTilemap = new FlxTilemap();
		tileMap.loadMap( dataStr, ImgTileSheet, 16, 16 );
		
		*/
		
		
	}
	
}