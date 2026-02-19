# Assets

This is a nice little guide on good asset creation.

## Images

One thing you probably don't want the engine to have is images that could be smaller in size. The art folder includes a bat file that can optimize every png in the assets folder. You need [oxipng](https://github.com/oxipng/oxipng) in order to run the file.

## Sounds and Music

Something that absolutely sucks is sound files that are just WAY too big. For example, Fresh's instrumental in the base game of Funkin' is a little over 4 megabytes. As of now, there isn't a file to optimize these sound files. However, using [Audacity](https://www.audacityteam.org), you can re-export these sound files to be a lot smaller in size.

You can do this by:
- Exporting the sound files at 24000 kHz.
- Using Mono instead of Stereo.

As a nice little bonus step, [OptiVorbis](https://github.com/OptiVorbis/OptiVorbis) can be used to further lower the file sizes of sound files. You can try this all you want, but it doesn't do as much as re-exporting the sounds using Audacity.

## Format

For consistency, the assets folder should have its files in a lower kebab case format (ex. `my-super-cool-song`). This format is applied to EVERYTHING in the assets folder (file names, JSON data, etc.).