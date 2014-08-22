package 
{
	
	import org.flixel.*;
	
	
	public class  LevelMenuState extends FlxState
	{
		private var selected:int = 0;
		private var pointArray:Array;
		private var stringsArray:Array;
		private var cursor:FlxSprite;
		private var textbox:FlxText;
		private var text:FlxText;
		
		//TODO ADD THIS TEXTBOX TO THE STATE< HAVE IT DISPLAY A DESCRIPTION OF THE SELECTED STATE
		override public function LevelMenuState():void 
		{
			
		}
		
	
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite;
			background.loadGraphic(GlobalVars.LevelMenuBackground, false, false);
			this.add(background);
			background.x = 0;
			background.y = 0;
			
			
			
			
			pointArray = new Array(new FlxPoint(32, 38),
											 new FlxPoint(44, 36),
											 new FlxPoint(58, 37),
											 new FlxPoint(70, 38),
											 new FlxPoint(94, 31),
											 new FlxPoint(129, 32),
											 new FlxPoint(155, 35),
											 new FlxPoint(173, 35),
											 new FlxPoint(188, 39));
			//TODO make this read it in from an xml or something maybe
			stringsArray = new Array("Mercury is the only one that works for now",
									 "Venus",
									 "Earth",
									 "Mars",
									 "Jupiter",
									 "Saturn",
									 "Uranus",
									 "Neptune",
									 "Pluto");
			
			textbox = new FlxText(32, 60, 100, stringsArray[0], true);
			text =  new FlxText(20, 5, 180, "A/D and enter to choose", true);								
			
			
			cursor = new FlxSprite;
			cursor.loadGraphic(GlobalVars.Cursor,false, false);
			
			cursor.x = pointArray[selected].x;
			cursor.y = pointArray[selected].y;
			
			this.add(cursor);
			this.add(textbox);
			this.add(text);
			
			//make a cursor and add it to the stage here
		}
		
		override public function update():void
		{
			
			//have the cursor move on key preses here
			//then call fade to change to level we want
			if (FlxG.keys.justPressed("A"))
			{
				if(selected == 0)
				{
					selected = 8;
				}
				else
				{
					selected--;
				}
			}
			if (FlxG.keys.justPressed("D"))
			{
				selected++;
				selected %= 9;
			}
			
			cursor.x = pointArray[selected].x;
			cursor.y = pointArray[selected].y;
			textbox.text = stringsArray[selected];
			
			if(FlxG.keys.justPressed("ENTER"))
			{
				switch(selected)
				{
					case 0:
						FlxG.switchState(new Mercury());
					break;
					case 1:
					
					break;
					case 2:
					
					break;
					case 3:
						
					break;
					case 4:
						
					break;
					case 5:
						
					break;
					case 6:
						
					break;
					case 7:
						
					break;
					case 8:
						
					break;
					default:
					
				}
						
			}
			
			super.update();
		}
		
	
	}
	
}