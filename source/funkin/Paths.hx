package funkin;

/**
 * A class for retrieving the game's asset paths.
 */
class Paths
{
    static inline function path(id:String):String
        return 'assets/$id';

    public static inline function image(id:String):String
        return path('$id.${Constants.IMAGE_EXT}');

    public static inline function sound(id:String):String
        return path('$id.${Constants.SOUND_EXT}');
}