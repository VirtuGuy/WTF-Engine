package funkin.data.character;

/**
 * A structure object used for... you guessed it... character data!
 */
typedef CharacterData = {
    var name:String;
    @:default(1)
    var scale:Float;
    var frameWidth:Int;
    var frameHeight:Int;
    var flipX:Bool;
    @:default(2)
    var danceEvery:Int;
    @:default(8)
    var singDuration:Float;
    @:default([])
    var animations:Array<CharacterAnimData>;
}

/**
 * A structure object used for the animation data of characters.
 */
typedef CharacterAnimData = {
    var name:String;
    @:default([])
    var frames:Array<Int>;
    @:default(10)
    var framerate:Int;
    var looped:Bool;
}