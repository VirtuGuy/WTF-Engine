package funkin.play.note;

import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * An `FlxGroup` containing strums and notes.
 */
class Strumline extends FlxGroup
{
    public var strums:FlxTypedGroup<StrumSprite>;

    public var offset(default, set):Float = 0.5;
    public var spacing(default, set):Float = 0;

    public function new()
    {
        super();

        strums = new FlxTypedGroup<StrumSprite>();
        add(strums);

        buildStrums();
    }

    public function process(isPlayer:Bool)
    {
        // TODO: Add proper strumline processing
    }

    function buildStrums()
    {
        for (direction in 0...Constants.NOTE_COUNT)
        {
            var strum:StrumSprite = new StrumSprite(direction);
            strum.y = 60;

            strums.add(strum);
        }

        positionStrums();
    }

    function positionStrums()
    {
        strums.forEach(strum -> {
            var off:Float = (strum.direction - Constants.NOTE_COUNT / 2);

            strum.x = FlxG.width * offset + off * (strum.width + spacing);
            strum.x += spacing / 2;
        });
    }

    function set_offset(offset:Float):Float
    {
        if (this.offset == offset) return this.offset;
        this.offset = offset;

        positionStrums();

        return this.offset;
    }

    function set_spacing(spacing:Float):Float
    {
        if (this.spacing == spacing) return this.spacing;
        this.spacing = spacing;

        positionStrums();

        return this.spacing;
    }
}