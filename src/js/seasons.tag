<seasons>
    <span class="{icon: !opts.skip}" if="{season('summer') || !opts.skip }"><i if="{season('summer')}" class="_icon" title="Summer">c</i></span>
    <span class="{icon: !opts.skip}" if="{season('autumn') || !opts.skip }"><i if="{season('autumn')}" class="_icon" title="Autumn">a</i></span>
    <span class="{icon: !opts.skip}" if="{season('winter') || !opts.skip }"><i if="{season('winter')}" class="_icon" title="Winter">d</i></span>
    <span class="{icon: !opts.skip}" if="{season('spring') || !opts.skip }"><i if="{season('spring')}" class="_icon" title="Spring">b</i></span>
    <script>
        this.season = s => {
            return this.epData(opts.episode)[s];
        }
    </script>
</seasons>
