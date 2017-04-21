<episode-list class="container">
    <div data-is="episode-card" each="{episode, index in chronology.newOrder}"
                  class="card" id="ep-{episode}">
        <header class="card-header">
            <p class="card-header-title">
                <a href="{chronology.episodes[episode].link}">
                    {episode}: {chronology.episodes[episode].title}
                </a>
            </p>
            <p class="card-header-icon"
               data-is="seasons"
               episode="{episode}">
            </p>
        </header>
        <div class="card-content">
            <div class="content" show="{!collapsed}">
                <raw-markdown text="{chronology.episodes[episode].comment}"
                              dynamic="true"/>
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
        </div>
        <footer class="card-footer">
            <div class="card-footer-item card-move-footer">
                <button class="button button-up"
                        disabled="{!canMove(index, episode, -1)}"
                        onclick="{parent.moveUp}">
                    Earlier <span class="_icon">f</span>
                </button>
                <button class="button button-down"
                        disabled="{!canMove(index, episode, 1)}"
                        onclick="{parent.moveDown}">
                    Later <span class="_icon">e</span>
                </button>
            </div>
        </footer>
    </div>
    <save-load id="save-load"></save-load>
    <script>
        import scrollIntoView from "scroll-into-view";
        import "./raw-markdown.tag";
        import "./episode-blocker-list.tag";
        import "./seasons.tag";
        import "./save-load.tag";

        this.collapsed = false;

        this.canMove = (index, episode, direction) => {
            // First test for the ends of the list.
            if (direction < 0 && index-1 <= 0) {
                return false;
            }
            if (direction > 0 && index+1 >= this.chronology.newOrder.length) {
                return false;
            }
            // Then check the blockers:
            let blockerList = this.blockers(episode, direction > 0 ? 'before' : 'after');
            if (blockerList && blockerList.includes(this.chronology.newOrder[index+direction])) {
                return false;
            }
            // Now check the blocker list on the episode we would swap with.
            let target = this.chronology.newOrder[index+direction];
            // Notice the reverse blocker.
            let reverseBlockerList = this.blockers(target, direction < 0 ? 'before' : 'after');
            if (reverseBlockerList && reverseBlockerList.includes(episode)) {
                return false;
            }
            return true;
        };

        this.move = (event, direction) => {
            let index = event.item.index;
            if (this.canMove(index, event.item.episode, direction)) {
                [this.chronology.newOrder[index], this.chronology.newOrder[index + direction]] =
                    [this.chronology.newOrder[index + direction], this.chronology.newOrder[index]];
            }
            this.update();
            // Since the cards actually *transformed into each other* rather than swapped,
            // the wrong button is now selected.
            // But we can select the correct one, and that's what we will do.
            let card = document.getElementById(`ep-${event.item.episode}`);
            let button = riot.util.dom.$(`button.button-${direction < 0 ? 'up' : 'down'}`, card);
            if (!riot.util.dom.getAttr(button,'disabled')) {
                button.focus();
            } else {
                document.activeElement.blur();
            }
            scrollIntoView(card, { time: 200 });
        }

        this.moveUp = (event) => {
            event.preventUpdate = true;
            this.move(event, -1);
        };

        this.moveDown = (event) => {
            event.preventUpdate = true;
            this.move(event, 1);
        };

        this.listen('collapse-change', data => {
            this.collapsed = data;
            this.update();
        });
    </script>
</episode-list>
