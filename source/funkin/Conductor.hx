package funkin;

import flixel.util.FlxSignal.FlxTypedSignal;

/**
 * The conductor class for the game. This is what handles steps and beats and all that crap.
 */
class Conductor
{
    public static var instance:Conductor;

    public var time:Float;
    public var bpm(default, set):Float;

    public var step:Int;
    public var beat:Int;
    public var section:Int;

    public var crotchet(get, never):Float;
    public var stepCrotchet(get, never):Float;

    public var stepHit(default, null) = new FlxTypedSignal<Int->Void>();
    public var beatHit(default, null) = new FlxTypedSignal<Int->Void>();
    public var sectionHit(default, null) = new FlxTypedSignal<Int->Void>();

    var lastSteps:Int = 0;
    var lastTimestamp:Float = 0;

    public function new() {}

    public function update()
    {
        var lastStep:Int = step;

        // Calculates the current step
        step = lastSteps + Math.floor((time - lastTimestamp) / stepCrotchet);
        beat = Math.floor(step / Constants.STEPS_PER_BEAT);
        section = Math.floor(step / Constants.STEPS_PER_SECTION);

        // Dispatches step signals
        if (lastStep != step)
        {
            stepHit.dispatch(step);

            if (step % Constants.STEPS_PER_BEAT == 0)
                beatHit.dispatch(beat);
            if (step % Constants.STEPS_PER_SECTION == 0)
                sectionHit.dispatch(section);
        }
    }

    function set_bpm(bpm:Float):Float
    {
        if (this.bpm == bpm) return this.bpm;
        this.bpm = bpm;

        lastSteps = step;
        lastTimestamp = time;

        return this.bpm;
    }

    inline function get_crotchet():Float
        return Constants.BEATS_PER_MIN / bpm * Constants.MS_PER_SEC;

    inline function get_stepCrotchet():Float
        return crotchet / Constants.STEPS_PER_BEAT;
}