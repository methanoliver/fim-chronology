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

You can [play with the result right now.](http://fim-chronology-pa.lindro.me/)

## Data storage

Data about the individual episodes and their ordering is
a [YAML](https://en.wikipedia.org/wiki/YAML) file located at
`src/data/data.yaml`, which is picked up at compile time and converted to JS
data structures:

```yaml
years: 5
episodes:
  6x12:
    title: Spice Up Your Life
    link: http://mlp.wikia.com/wiki/Spice_Up_Your_Life
    autumn: true
    summer: true
    winter: false
    spring: true
    after:
      - 3x13
      - 5x25-26
      - 6x01-02
    opt_after:
      - 1x01-02
    comment: |
      This is a Cutie Map mission, and is explicitly referred to as being the
      first mission since Starlight broke the map in the Cutie Re-Mark.
    before: []
order:
  - 6x12
```

`episodes` is a list of episodes. Each episode is assigned a unique
identifier, which is a string, and by convention, the episode number in a
`<season>x<episode>` format, where `<season>` is a single digit number,
`<episode>` is either a two-digit number or a `-` separated list of two-digit
episode numbers, if they are a two-part episode or otherwise strictly joined
in terms of timeline. For Equestria Girls movies, they are just `EG<number>`
in airing order.

`link` is normally a link to the relevant page
of [Friendship is Magic Wiki][fimwiki].

`title` should be obvious.

`autumn`, `summer`, `winter`, `spring` are seasonal flags, and they are either
true or false, they denote whether this episode *may* occur during the said
season. A missing flag is undefined, and therefore false. Ponyville seasons
are assumed always, since that's the place we see most of the time.

`before` and `after` are optional lists of episode IDs that this episode must
be placed before and must be placed after, respectively -- the so-called hard
constraints. Every such constraint is a constraint on *both* episodes
mentioned at once, so they do not necessarily have to be duplicated.

`opt_before` and `opt_after` are optional list of soft constraints --
restrictions on episode motion which are a matter of argument or
interpretation, which the user can enable or disable by clicking a
checkbox. The same episode ID may be present both in hard and soft constraints
of an episode, in which case it is treated as a soft constraint that is
enabled by default.

`comment` is the commentary text. Markdown is allowed inside. Links to other
episodes can be done in the usual Markdown way, with `#ep-<episode id>` as the
link target.

[fimwiki]: http://mlp.wikia.com/wiki/My_Little_Pony_Friendship_is_Magic_Wiki

`order` is a list of episode IDs and is the order the user will see upon
opening the document.

`years` is a number. This tells the code how many years worth of virtual
season change marker pseudo-episodes to generate. The virtual season-change
markers have the ID in the form of `SM<year>-<season>`, where years start at 1
and season is the first two letters of the season, so that they can be
referenced to in Markdown episode commentary like regular episode IDs and
positioned in the `order` list.

## Compiling

You want a reasonable installation of Node.Js.

    npm install    # Installs all the dependencies
    npm run icons  # Builds the font file with icons.
    npm run build  # Builds the code in 'dist'
    npm run deploy # Inlines all the code into one file for deployment in 'build'.

That should be enough, really. The result will be found in `build/index.html`

Linux or a Mac or anything that can run `bash` will be needed, and all the
build scripts assume the use of [direnv](https://direnv.net/), which saves a
lot of pain if you're juggling a lot of Node.Js projects. If you're crafty
enough to develop on Windows, you might as well send me a pull request fixing
this problem.

To debug, you might want to use `npm start`

## License

Copyright (c) 2016-2017 Adam Trzypolski.

[Licensed under the terms of MIT license.](LICENSE)

