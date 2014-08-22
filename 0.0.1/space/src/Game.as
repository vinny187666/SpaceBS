package 
{
	import org.flixel.*;
	
	[SWF(width = "800", height="400", backgroundColor="#000000")]
	//[Frame(factoryClass = "Preloader")]
	public class Game extends FlxGame 
	{
		public function Game():void 
		{
			//FlxG.debug = true;
		//	GlobalVars.mercuryGround1x1 = new FlxTilemap;
			
			
			
			
			super(200, 100, MenuState, 4);
		}
	}
	
}