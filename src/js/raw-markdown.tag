<raw-markdown class="content">
    <-/>
    <script>
        this.root.innerHTML = this.markdown.render(opts.text);
        this.saved_text = opts.text;

        this.on('update', () => {
            if (this.saved_text !== opts.text) {
                this.root.innerHTML = this.markdown.render(opts.text);
            }
        });
    </script>
</raw-markdown>
