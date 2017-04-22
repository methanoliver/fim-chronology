<seasons>
    <span class="icon"><i if="{season('summer')}" class="_icon" title="Summer">c</i></span>
    <span class="icon"><i if="{season('autumn')}" class="_icon" title="Autumn">a</i></span>
    <span class="icon"><i if="{season('winter')}" class="_icon" title="Winter">d</i></span>
    <span class="icon"><i if="{season('spring')}" class="_icon" title="Spring">b</i></span>
    <script>
        this.season = s => {
            return this.chronology.episodes[opts.episode][s];
        }
    </script>
</seasons>
