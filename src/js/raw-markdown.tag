<raw-markdown class="content">
    <-/>
    <script>
        this.root.innerHTML = this.markdown.render(opts.text||'');

        this.on('update', () => {
            if (opts.dynamic) {
                this.root.innerHTML = this.markdown.render(opts.text||'');
            }
        });
    </script>
</raw-markdown>
