package funkin.util;

/**
 * A class used as a store for constant variables that are used globally.
 */
class Constants
{
    public static final IMAGE_EXT:String = 'png';
    public static final SOUND_EXT:String = #if web 'mp3' #else 'ogg' #end;
    
    public static final NOTE_COUNT:Int = 4;

    public static final ZOOM:Int = 4;
}