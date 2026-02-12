package funkin.play;

import flixel.FlxState;
import funkin.play.note.Strumline;

/**
 * A state where the gameplay occurs. Kinda like a "play" state. Hah! I said the thing!
 */
class PlayState extends FlxState
{
	var opponentStrumline:Strumline;
	var playerStrumline:Strumline;

	override public function create()
	{
		opponentStrumline = new Strumline();
		opponentStrumline.offset = 0.25;
		add(opponentStrumline);

		playerStrumline = new Strumline();
		playerStrumline.offset = 0.75;
		add(playerStrumline);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		opponentStrumline.process(false);
		playerStrumline.process(true);

		super.update(elapsed);
	}
}
