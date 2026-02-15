package funkin.data.song;

import flixel.FlxG;
import moonchart.formats.fnf.FNFVSlice;
import openfl.Assets;
import openfl.media.Sound;

/**
 * A structure object used for song note data.
 */
typedef SongNoteData = {
    var t:Float;
    var d:Int;
    var l:Float;
    var k:String;
}

class SongData {
    public var speed:Float = 1;
    public var bpm:Float = 120;
    public var data:Array<Array<SongNoteData>> = [
        [], // Opponent
        [] // Player
    ];

    public var instrumental:Sound;
    public var playerVoices:Array<Sound> = [];
    public var opponentVoices:Array<Sound> = [];

    private static function suffix(str:String):String {
        return str != "" ? '-$str' : str;
    }

    public function new(id:String, difficulty:String = "hard", variation:String = "") {
        // Please grid snap all notes to this variable!
        // It makes using directions a hell of a lot easier.

        var vslice = new FNFVSlice().fromFile('assets/songs/$id/$id-chart${suffix(variation)}.json', 'assets/songs/$id/$id-metadata${suffix(variation)}.json');

        instrumental = Assets.getSound('assets/songs/$id/Inst${suffix(vslice.meta.playData.characters.instrumental)}.${Constants.SOUND_EXT}');

        for (variant in vslice.meta.playData.characters.playerVocals ?? [vslice.meta.playData.characters.player])
            playerVoices.push(Assets.getSound('assets/songs/$id/Voices${suffix(variant)}${suffix(variation)}.${Constants.SOUND_EXT}'));

        for (variant in vslice.meta.playData.characters.opponentVocals ?? [vslice.meta.playData.characters.opponent])
            opponentVoices.push(Assets.getSound('assets/songs/$id/Voices${suffix(variant)}${suffix(variation)}.${Constants.SOUND_EXT}'));

		for (note in vslice.data.notes.get(difficulty))
		{
			if (note.d > 3) {
                // Opponent
                data[0].push({t: note.t, d: note.d % Constants.NOTE_COUNT, l: note.l, k: note.k});
            } else {
                // Player
                data[1].push({t: note.t, d: note.d % Constants.NOTE_COUNT, l: note.l, k: note.k});
            }
		}

        speed = vslice.data.scrollSpeed.get(difficulty);
        bpm = vslice.meta.timeChanges[0].bpm; // TO-DO: Change this later!
    }
}