package funkin;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import funkin.data.character.CharacterRegistry;
import funkin.data.song.SongRegistry;
import funkin.graphics.FunkinSprite;
import funkin.input.Controls;
import funkin.play.PlayState;

/**
 * The initial state of the game. This is what sets up the game.
 * On web, this is used as a "Click to Start" screen.
 */
class InitState extends FlxState
{
    var clickToStart:FunkinSprite;

    override public function create()
    {
        // Flixel
        FlxG.fixedTimestep = false;
        FlxG.game.focusLostFramerate = 30;
        FlxG.inputs.resetOnStateSwitch = false;
        FlxG.mouse.useSystemCursor = true;
        FlxG.stage.showDefaultContextMenu = false;

        // Velocity isn't ever used much
        FlxObject.defaultMoves = false;

        Conductor.instance = new Conductor();
        Controls.instance = new Controls();

        CharacterRegistry.instance = new CharacterRegistry();
        SongRegistry.instance = new SongRegistry();

        // TODO: Remove this once songs can be loaded ingame
        PlayState.song = SongRegistry.instance.fetch('fresh');

        // Web requires user input to play audio
        // So that means we need a nice little "click here to play" thing
        #if web
        clickToStart = new FunkinSprite();
        clickToStart.loadSprite('ui/click-to-start', 1.25);
        clickToStart.screenCenter();
        add(clickToStart);
        #else
        startGame();
        #end

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        #if web
        if (FlxG.mouse.justReleased) startGame();
        #end
    }

    function startGame()
    {
        FlxG.mouse.visible = false;

        #if HAS_FPS_COUNTER
        Main.fpsCounter.visible = true;
        #end

        // Switches the state to PlayState
        // TODO: Change this to a title screen once there is one
        FlxG.switchState(() -> new funkin.play.PlayState());
    }
}