package funkin;

import flixel.FlxG;
import flixel.FlxState;
import funkin.data.song.SongRegistry;
import funkin.input.Controls;
import funkin.play.PlayState;
import macohi.debugging.CrashHandler;

/**
 * The initial state of the game. This is what sets up the game.
 */
class InitState extends FlxState
{
    override public function create()
    {
	// Backend
	CrashHandler.initalize(Constants.CRASHHANDLER_FILE_LOCATION, Constants.CRASHHANDLER_FILE_PREFIX, Constants.CRASHHANDLER_GIT_USER, Constants.CRASHHANDLER_GIT_REPO);

        // Flixel
        FlxG.fixedTimestep = false;
        FlxG.game.focusLostFramerate = 30;
        FlxG.inputs.resetOnStateSwitch = false;
        FlxG.mouse.visible = false;
        FlxG.stage.showDefaultContextMenu = false;

	// Instances
        Conductor.instance = new Conductor();
        Controls.instance = new Controls();

	// Registries
        SongRegistry.instance = new SongRegistry();

        // Starts the game
        // Also loads up a test chart
        PlayState.song = SongRegistry.instance.fetch('test');

        FlxG.switchState(() -> new funkin.play.PlayState());

        super.create();
    }
}