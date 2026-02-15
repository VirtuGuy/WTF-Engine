package funkin.audio;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;

class SoundGroup extends FlxTypedGroup<FlxSound> {
    @:isVar public var time(get, set):Float;
    function get_time():Float {
        return members[0]?.time ?? 0;
    }
    function set_time(val:Float):Float {
        for (snd in members) {
            snd.pause();
            snd.time = val;
            snd.resume();
        }

        return time = val;
    }

    public var volume(default, set):Float = 1;
    function set_volume(val:Float):Float {
        for (snd in members)
            snd.volume = val;

        return volume = val;
    }

    public function new(autoAdd:Bool = true) {
        super();
        FlxG.state.add(this);
    }

    override function add(basic:FlxSound):FlxSound {
        FlxG.sound.list.add(basic);
        return super.add(basic);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    override function destroy() {
        if (FlxG.state.members.contains(this)) FlxG.state.remove(this, true);

        if (members != null) for (snd in members) FlxG.sound.list.remove(snd, true);

        super.destroy();
    }

    public function pause() {
        for (snd in members) snd.pause();
    }

    public function resume() {
        for (snd in members) snd.resume();
    }

    public function play() {
        for (snd in members) snd.play();
    }

    public function stop() {
        for (snd in members) snd.stop();
    }
}