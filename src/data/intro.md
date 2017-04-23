This is a piece of "software," for lack of a better word, made with the intent to discuss the issues of episode ordering for *My Little Pony: Friendship is Magic* in a way that is more conductive to getting something reasoned out than an Excel table or a simple textual list.

It should be obvious that the problem of episode ordering exists, if only from the placement of **Hearthbreakers** immediately before **Scare Master** in the airing order, but you can't just swap those two and move on, it goes much deeper than that.

## Assumptions

This list/program was made with the following assumptions, many of which were at one point or another challenged by the pony fandom:

* Equestria has a year with a set length.
* This year contains summer, autumn, winter, and spring, in that order, of approximately equal lengths.
* Autumn and spring sometimes look like summer to the point of being indistinguishable, which makes it difficult to determine the season, but winter never does, due to necessitating complicated wrap-up procedures.
* Seasonal changes occur simultaneously or in quick succession across all of Equestria, though other, exotic lands may have their seasons look substantially different from what we expect.
* Pony calendar has months, 12 of them, and a "moon" is *roughly* equal to one.
* While it is not *that* relevant for the purposes of this chronology, ponies have a week that is 7 days long, and the days themselves are very much like ours.

We're starting from the assumption that pony calendar is reasonably sane, pony climate and seasons are reasonably sane, that episodes are aired in anachronic order, and work from there. We don't know where the calendar year boundary is, but since we can use the first summer of the series as our zero point, it will serve.

You can read some of the reasoning on why the calendar is this way, and not some other way, [in one of my blog posts on the subject.](https://www.fimfiction.net/blog/729198/rtac-13-strange-loops) Only the TV show and the movies are listed here, because all the printed derivatives introduce even worse timing problems. They can be dealt with afterwards anyway.

It goes without saying that these assumptions are rather broad and were challenged for a reason. But without assuming these things, it is impossible to put episodes in a coherent temporal relation to each other at all, and we might as well give up and imagine a universe where children spend decades in nappies sucking on pacifiers, economics doesn't exist, the word "year" is without a meaning, and "a thousand years" just means "last tuesday." The show staff introduced the term "moon" and went on to say it has no relation whatsoever to any human measure of time precisely to cover their collective posterior, there is no canonical timeline, at least not to the level of detail you need when you want to consider a what-if scenario. We're on our own, they don't care.

Well, I say it's their problem.

## Explanations

The entire point of coding this little piece of horror is to programmatically account for certain known "markers" which permit us to split at least some of the rest of the episodes into "before" and "after" states, like "Twilight's Ascension" or "CMC getting cutie marks" or "Zecora being befriended," as well as introduce other restrictions based on observed phenomena.

Many, if not most, will be redundant, but that's not a problem when we have software taking care of them. The idea is to write in as many such restrictions as possible, write up everything which looks like a restriction but isn't definite, and then shove the episodes around until they start making sense. Ideally, we want every episode to have at least one "must precede" episode and at least one "must follow" episode, and it's still far from having all the existing hard constraints listed. Something coherently continuous should emerge, if enough people play with it and send me their input.

The initial reordering of seasons 1-3 presented here as starting data and many of the original arguments that I started with belong to someone else. A few of them are probably wrong. Unfortunately, I can't seem to find the original source anymore, and I basically had to OCR it out of images someone rendered them as. This was the longest reordered timeline I managed to locate, and I find that it works very well, particularly if you make a playlist of episodes in chronological order -- with certain exceptions which I marked up.

The marker rules are described where reasonable: if we see the Friendship Castle, the episode occurs after it is created, if we see a character, this has to happen after they were introduced, etc.

## Seasons

Since few episodes can be conclusively limited to happening during a specific time of year, episodes are marked with times of year they *can* occur in. These are soft constraints -- for your information only. The possible seasons are marked with obvious icons.

In addition to that, a number of virtual season-change episodes hard-locked against each other are provided, and certain episodes are hard-locked against some of them, rather than just other real episodes, because they are are explicitly set at specific points in a year, or at least in specific seasons. We do not know when the pony calendar year starts or ends. For this reason, this cycle starts at Summer, year 1, and continues on through the Summer-Autumn-Winter-Spring cycle.

## Usage

Move the episode cards up and down with the provided buttons. Should you wish to move one episode a long way into the same direction, clicking the button once will keep it selected once the episode has moved, so pressing `Enter` or `Space` afterwards will keep moving the episode in the same direction, until you click another button, or bump into a hard rule preventing the move.

If there's a hard rule preventing the move, the button will be disabled. If there is a soft observation that gives some clues as to their actual position, it will be mentioned in the text on the card. Juggle them around and see if you can come up with something that makes sense.

Discuss!
