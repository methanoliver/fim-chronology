<episode-card class="{card: true, virtual: epData(episode).virtual}"
              id="ep-{episode}">
    <header class="card-header">
        <p class="card-header-title">
            <virtual if="{epData(episode).link}">
                <a href="{epData(episode).link}">
                    {episode}: {epData(episode).title}</a>
            </virtual>
            <virtual if="{!epData(episode).link}">
                {epData(episode).title}
            </virtual>
        </p>
        <p class="card-header-icon"
           if="{!epData(episode).virtual}"
           data-is="seasons"
           episode="{episode}">
        </p>
    </header>
    <div class="{'card-content': true, 'is-clearfix': true, collapse: epData(episode).collapse}">
        <div class="card-move-block is-pulled-right">
            <div class="field is-grouped">
                <p class="control">
                    <button class="button eye-button is-outlined"
                            onclick="{toggle}"
                            title="Show episode commentary"
                            if="{epData(episode).collapse}">
                        <span class="icon"><i class="_icon">h</i></span>
                    </button>
                    <button class="button eye-button is-outlined"
                            onclick="{toggle}"
                            title="Hide episode commentary"
                            if="{!epData(episode).collapse}">
                        <span class="icon"><i class="_icon">g</i></span>
                    </button>
                </p>
                <p class="control">
                    <button class="button button-up is-success is-outlined"
                            disabled="{!parent.canMove(index, -1)}"
                            title="Earlier"
                            onclick="{parent.moveUp}">
                        <span class="icon"><i class="_icon">f</i></span>
                    </button>
                </p>
                <p class="control">
                    <button class="button button-down is-success is-outlined"
                            disabled="{!parent.canMove(index, 1)}"
                            title="Later"
                            onclick="{parent.moveDown}">
                        <span class="icon"><i class="_icon">e</i></span>
                    </button>
                </p>
            </div>
        </div>
        <div class="content episode-comment">
            <p class="big-season-icon is-pulled-left"
               data-is="seasons"
               skip="true"
               episode="{episode}"
               if="{epData(episode).virtual}"></p>
            <raw-html text="{epData(episode).html}" />
        </div>
        <div if="{after(episode)}"
             class="blockers">
            Must follow:
            <ul data-is="episode-blocker-list"
                list="{after(episode)}"></ul>
        </div>
        <div if="{before(episode)}"
             class="blockers">
            Must precede:
            <ul data-is="episode-blocker-list"
                list="{before(episode)}"></ul>
        </div>
        <div if="{optAfter(episode)}"
             class="blockers optional-blockers">
            Could follow:
            <ul data-is="episode-blocker-list"
                list="{optAfter(episode)}" where="{episode}" which="after"></ul>
        </div>
        <div if="{optBefore(episode)}"
             class="blockers optional-blockers">
            Could precede:
            <ul data-is="episode-blocker-list"
                list="{optBefore(episode)}" where="{episode}" which="before"></ul>
        </div>
    </div>
    <script>
        import "./raw-html.tag";
        import "./episode-blocker-list.tag";
        import "./seasons.tag";

        this.toggle = e => {
            this.epData(this.episode).collapse = !this.epData(this.episode).collapse;
        };

        this.listen('collapse-change', data => {
            this.epData(this.episode).collapse = data;
            this.update();
        });

        this.toggleOptBlocker = (blocker, list) => {
            let blocklist = this.blockers(this.episode, list);
            if (blocklist.includes(blocker)) {
                const index = blocklist.indexOf(blocker);
                blocklist.splice(index, 1);
            } else {
                blocklist.push(blocker);
                blocklist.sort();
            }
            this.epData(this.episode)[list] = blocklist;
            this.dispatch('order-update', this.episode);
        };

    </script>
</episode-card>
