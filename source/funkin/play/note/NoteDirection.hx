package funkin.play.note;

/**
 * An enum abstract used for note directions.
 */
enum abstract NoteDirection(Int) to Int from Int
{
    var LEFT = 0;
    var DOWN = 1;
    var UP = 2;
    var RIGHT = 3;

    @:from
    public static function fromInt(value:Int):NoteDirection
    {
        return switch (value)
        {
            case 0: LEFT;
            case 1: DOWN;
            case 2: UP;
            case 3: RIGHT;
            default: LEFT;
        }
    }
}