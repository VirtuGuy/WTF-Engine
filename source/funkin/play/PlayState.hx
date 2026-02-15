package funkin.play;

import flixel.FlxG;
import flixel.sound.FlxSound;
import flixel.util.FlxTimer;
import funkin.audio.SoundGroup;
import funkin.data.song.SongData;
import funkin.play.note.NoteDirection;
import funkin.play.note.NoteSprite;
import funkin.play.note.Strumline;
import funkin.ui.FunkinState;

/**
 * A state where the gameplay occurs. Kinda like a "play" state. Hah! I said the thing!
 */
class PlayState extends FunkinState
{
	var loadedSong:Bool = false;

	var opponentStrumline:Strumline;
	var playerStrumline:Strumline;

	var songData:SongData;

	var inst:FlxSound;
	var playerVoices:SoundGroup;
	var opponentVoices:SoundGroup;

	override public function create()
	{
		inst = new FlxSound();
		FlxG.sound.list.add(inst);

		opponentVoices = new SoundGroup();
		playerVoices = new SoundGroup();

		opponentStrumline = new Strumline();
		opponentStrumline.offset = 0.25;
		add(opponentStrumline);

		playerStrumline = new Strumline();
		playerStrumline.offset = 0.75;
		add(playerStrumline);

		loadSong();

		FlxG.camera.bgColor = 0xFF252525;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (loadedSong)
		{
			conductor.time = inst.time;
			conductor.update();
		} else {
			conductor.time += elapsed * Constants.MS_PER_SEC;
			conductor.update();

			if (conductor.time >= 0) {
				loadedSong = true;

				startSong();
			}
		}

		opponentStrumline.process(false);
		playerStrumline.process(!Preferences.botplay);

		processInput();

		if (FlxG.keys.justPressed.R) FlxG.resetState();

		super.update(elapsed);

		// DO NOT PAUSE THE INST, IT'LL THROW OFF THE PLAYER!
		if (Math.abs(inst.time - (playerVoices?.time ?? opponentVoices.time)) > 24) {
			resyncVocals();
		}
	}

	override function destroy() {
		super.destroy();

		FlxG.sound.list.remove(inst, true);
	}

	function loadSong()
	{
		songData = new SongData("bopeebo");
		
		inst.loadEmbedded(songData.instrumental);

		for (sound in songData.opponentVoices) {
			var snd = new FlxSound().loadEmbedded(sound);
			opponentVoices.add(snd);
		}

		for (sound in songData.playerVoices) {
			var snd = new FlxSound().loadEmbedded(sound);
			playerVoices.add(snd);
		}

		conductor.bpm = songData.bpm;
		conductor.time = -conductor.crotchet * 4;

		playerStrumline.speed = songData.speed;
		playerStrumline.data = songData.data[1];

		opponentStrumline.data = songData.data[0];
		opponentStrumline.speed = songData.speed;
	}

	function startSong() {
		inst.play();
		opponentVoices.play();
		playerVoices.play();
	}

	function processInput()
	{
		// Player input
		var directionNotes:Array<Array<NoteSprite>> = [[], [], [], []];

		for (note in playerStrumline.getMayHitNotes()) directionNotes[note.direction].push(note);

		for (i in 0...directionNotes.length)
		{
			var note:NoteSprite = directionNotes[i][0];
			var direction:NoteDirection = NoteDirection.fromInt(i);
			var pressed:Bool = direction.justPressed || Preferences.botplay;

			if (!pressed || note == null) continue;

			playerStrumline.hitNote(note);
			playerStrumline.playSplash(direction);
		}

		// Opponent input
		for (note in opponentStrumline.getMayHitNotes())
			opponentStrumline.hitNote(note);
	}
	
	function resyncVocals() {
		playerVoices.pause();
		opponentVoices.pause();

		playerVoices.time = inst.time;
		opponentVoices.time = inst.time;

		playerVoices.resume();
		opponentVoices.resume();

		#if debug
		trace("Resynced vocals at: " + inst.time);
		#end
	}
}
