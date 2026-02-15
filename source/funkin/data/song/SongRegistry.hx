package funkin.data.song;

import funkin.data.song.SongData;
import funkin.play.Song;
import funkin.util.FileUtil;
import json2object.JsonParser;

/**
 * A registry class for loading songs.
 */
class SongRegistry extends BaseRegistry<Song>
{
    public static var instance:SongRegistry;

    public function new()
    {
        super('songs');
    }

    override public function load()
    {
        super.load();

        // Some pretty useful json parsers
        // Might come in handy maybe
        var metaParser:JsonParser<SongMetadata> = new JsonParser<SongMetadata>();
        var chartParser:JsonParser<SongChartData> = new JsonParser<SongChartData>();

        // Loads the entries
        for (songId in FileUtil.listFolders(path))
        {
            var metaPath:String = Paths.json('$path/$songId/meta');
            var chartPath:String = Paths.json('$path/$songId/chart');

            // Skip the song if it doesn't have metadata
            if (!Paths.exists(metaPath)) continue;

            var meta:SongMetadata = metaParser.fromJson(FileUtil.getText(metaPath));
            var chart:SongChartData = chartParser.fromJson(FileUtil.getText(chartPath));
            var song:Song = new Song(songId, meta, chart);

            register(songId, song);
        }
    }
}