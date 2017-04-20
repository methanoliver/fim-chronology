<seasons>
    <span class="icon"><i if="{episode.summer}" class="_icon" title="Summer">c</i></span>
    <span class="icon"><i if="{episode.autumn}" class="_icon" title="Autumn">a</i></span>
    <span class="icon"><i if="{episode.winter}" class="_icon" title="Winter">d</i></span>
    <span class="icon"><i if="{episode.spring}" class="_icon" title="Spring">b</i></span>
    <-/>
    <script>
        this.episode = this.chronology.episodes[opts.episode];
        this.on('update', () => {
            this.episode = this.chronology.episodes[opts.episode];
        });
    </script>
</seasons>
