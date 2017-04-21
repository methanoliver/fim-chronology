<save-load>
    <div class="field">
        <p>
            You can "save" and "load" the episode order you ended up with by copy-pasting the contents of this textbox.<br>
            Notice that this will permit you to bypass ordering restrictions given in the data and will confuse the program if you do.
        </p>
    </div>
    <div class="field">
        <p class="control">
            <textarea class="textarea" ref="list" rows="8"></textarea>
        </p>
    </div>
    <div class="field is-grouped">
        <p class="control">
            <button class="button is-warning" onclick="{reset}">Reset</button>
        </p>
        <p class="control">
            <button class="button is-primary" onclick="{reorder}">Reorder to this</button>
        </p>
        <p class="control">
            <button class="button" onclick="{download}">Download the data as CSV instead</button>
            <a class="display:none;" ref="download" target="_blank"></a>
        </p>
    </div>
    <div class="field">
        <p class="control">
            You can also get the resulting episode ordering in FimFiction bbcode for ease of discussion, just click the text below and press Ctrl+C:
        </p>
        <p class="control bbcode-container">
            <code ref="code">
                <virtual each="{episode, index in chronology.newOrder}">
                    [b]{index+1}[/b]. {episode}, "{chronology.episodes[episode].title}"<br>
                </virtual>
            </code>
        </p>
    </div>
    <script>

        import gotem from "gotem";
        import Papa from "papaparse";

        this.refill = () => {
            this.refs.list.value = this.chronology.newOrder.join(' ');
        };

        this.on('mount', () => {
            this.refill();
            gotem(this.refs.code, this.refs.code);
        });

        this.on('update', () => {
            this.refill();
        })

        this.reset = e => {
            e.preventUpdate = true;
            this.chronology.newOrder = this.chronology.order.slice();
            this.parent.update();
        };

        this.reorder = e => {
            e.preventUpdate = true;
            this.chronology.newOrder = this.refs.list.value.split(/\s+/g);
            // TODO: This is where we can verify if the order is valid.
            this.refill();
            this.parent.update();
        };

        this.download = e => {

            let blob = [];
            this.chronology.newOrder.forEach( (el, index, list) => {
                let episode = this.chronology.episodes[el];
                blob.push({
                    "index": index + 1,
                    "number": el,
                    "title": episode.title,
                    "link": episode.link,
                    "spring": episode.spring || false,
                    "summer": episode.summer || false,
                    "autumn": episode.autumn || false,
                    "winter": episode.winter || false,
                    "must_be_before": this.before(el) ? episode.before.join(" ") : "",
                    "must_be_after": this.after(el) ? episode.after.join(" ") : "",
                    "comment": episode.comment
                })
            });

            this.refs.download.href = 'data:application/csv;charset=utf-8,'
                                    + encodeURIComponent(Papa.unparse(blob));
            this.refs.download.download =
                `my-little-chronology-${__BUILD_DATE__}-${__BUILD_NUMBER__.trim()}.csv`;
            this.refs.download.click();
        };
    </script>
</save-load>
