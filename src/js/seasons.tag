<seasons>
    <li><i if="{episode.summer}" class="_icon" title="Summer">c</i></li>
    <li><i if="{episode.autumn}" class="_icon" title="Autumn">a</i></li>
    <li><i if="{episode.winter}" class="_icon" title="Winter">d</i></li>
    <li><i if="{episode.spring}" class="_icon" title="Spring">b</i></li>
    <-/>
    <script>
        this.episode = this.chronology.episodes[opts.episode];
    </script>
</seasons>
