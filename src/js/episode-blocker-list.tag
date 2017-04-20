<episode-blocker-list>
    <li each="{episode, index in opts.list}">
        <a href="#ep-{episode}">
            {episode}:
            {chronology.episodes[episode] ? chronology.episodes[episode].title : chronology.episodes[episode] + " Data error! Check your staging."}</a></li>
</episode-blocker-list>
