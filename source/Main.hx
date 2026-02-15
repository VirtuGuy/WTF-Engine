package;

import flixel.FlxGame;
import flixel.util.typeLimit.NextState.InitialState;
import lime.app.Application;
import openfl.display.FPS;
import openfl.display.Sprite;

/**
 * The main project class where Flixel is initialized.
 */
class Main extends Sprite
{
	public static var fpsCounter:FPS;

	public function new()
	{
		super();

		// Starts the game
		final gameWidth:Int = 0;
		final gameHeight:Int = 0;
		final initialState:InitialState = funkin.InitState;
		final framerate:Int = Application.current.window.displayMode.refreshRate;
		final skipSplash:Bool = true;
		final startFullscreen:Bool = false;

		addChild(new FlxGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));

		// Adds an FPS counter
		fpsCounter = new FPS(10, 10, 0xFFFFFF);
		addChild(fpsCounter);
	}
}
