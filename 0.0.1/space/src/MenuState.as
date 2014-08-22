package 
{
	
	import org.flixel.*;
	
	public class  MenuState extends FlxState
	{
		
		override public function MenuState():void 
		{
			
		}
		
	
		override public function create():void
		{
			var pressStart:FlxSprite = new FlxSprite;
			pressStart.loadGraphic(GlobalVars.StartScreen, false, false);
			this.add(pressStart);
			pressStart.x = 0;
			pressStart.y = 0;
		}
		
		override public function update():void
		{
			if (FlxG.keys.pressed("ENTER"))
			{
				//FlxG.play(GlobalVars.RocketSound, 1.0, false);
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}
			super.update();
		}
		
		private function onFade():void
		{
			//FlxG.switchState(new Mercury());
			FlxG.switchState(new LevelMenuState());
		}
	}
	
}