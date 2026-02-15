package funkin.play;

import flixel.FlxSprite;
import funkin.data.character.CharacterData;

/**
 * An `FlxSprite` that sings and bops and all that.
 */
class Character extends FlxSprite
{
    public var id:String;
    public var meta:CharacterData;

    public function new(id:String, meta:CharacterData)
    {
        super();

        this.id = id;
        this.meta = meta;

        // Loads the image
        loadGraphic(Paths.image('play/characters/$id/image'));
        setGraphicSize(Std.int(width * Constants.ZOOM * meta.scale));
        updateHitbox();
    }
}