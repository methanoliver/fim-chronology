<episode-blocker-list>
    <li each="{episode, index in opts.list}">
        <span class="option" if="{parent.opts.where}" onclick="{toggle}">
            <i class="_icon" if="{isChecked(episode)}">j</i>
            <i class="_icon" if="{!isChecked(episode)}">i</i>
        </span>
        <a href="#ep-{episode}">
            {episode}:
            {chronology.episodes[episode] ? chronology.episodes[episode].title : chronology.episodes[episode] + " Data error! Check your staging."}</a></li>
    <script>
        this.isChecked = ep => {
            return this.isBefore(opts.where, ep) || this.isAfter(opts.where, ep);
        };

        this.toggle = e => {
            this.parent.toggleOptBlocker(e.item.episode, opts.which);
        };
    </script>
</episode-blocker-list>
