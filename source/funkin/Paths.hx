package funkin;

import haxe.io.Bytes;
import openfl.utils.ByteArray;

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

    public static inline function getContent(id:String):String {
        #if sys
        return sys.io.File.getContent(id);
        #end

        return openfl.Assets.getText(id);
    }

    public static function getBytes(id:String):Bytes {
        #if sys
        return sys.io.File.getBytes(id);
        #end

        #if flash
        return Bytes.ofData(openfl.Assets.getBytes(id));
        #end

        return cast(openfl.Assets.getBytes(id), ByteArrayData);
    }
}