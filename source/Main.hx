package;

import flixel.FlxGame;
import flixel.util.typeLimit.NextState.InitialState;
import openfl.display.Sprite;

/**
 * The main project class where Flixel is initialized.
 */
class Main extends Sprite
{
	public function new()
	{
		super();

		// Starts the game
		final gameWidth:Int = 0;
		final gameHeight:Int = 0;
		final initialState:InitialState = funkin.InitState;
		final framerate:Int = 60;
		final skipSplash:Bool = true;
		final startFullscreen:Bool = false;

		addChild(new FlxGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));
	}
}
