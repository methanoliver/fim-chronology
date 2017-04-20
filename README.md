# My Little Chronology

Some people like to overanalyze things. Some people like to overanalyze *My
Little Pony: Friendship is Magic.*

If you're one of those, this might be for you.

This is a Javascript program that helps you manipulate the list of episodes in
a visual manner, and more importantly, observe hard rules when moving episodes
around -- "this episode must precede X", "this episode must follow Y". You can
save and load your results, *(within reason)* copy and paste them for
discussion, and rehost this project with minimal effort, because it's all a
self-contained single HTML file.

## Compiling

You want a reasonable installation of Node.Js.

    npm install    # Installs all the dependencies
    npm run icons  # Builds the font file with icons.
    npm run build  # Builds the code in 'dist'
    npm run deploy # Inlines all the code into one file for deployment in 'build'.

That should be enough, really. The result will be found in `build/index.html`

Linux or a Mac or anything that can run `bash` will be needed. If you're
crafty enough to develop on Windows, you might as well send me a pull request
fixing this problem.

To debug, you might want to use `npm start`

## License

Copyright (c) 2016-2017 Adam Trzypolski.

Licensed under the terms of MIT license.

