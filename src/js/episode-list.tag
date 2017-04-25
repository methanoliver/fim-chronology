<episode-list class="container">
    <div data-is="episode-card" each="{episode, index in chronology.newOrder}"
                  class="card" id="ep-{episode}">
    </div>
    <script>
        import scrollIntoView from "scroll-into-view";
        import "./episode-card.tag";

        this.canMove = (index, direction) => {
            let episode = this.chronology.newOrder[index];
            // First test for the ends of the list.
            if (index+direction < 0 || index+direction >= this.chronology.newOrder.length) {
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

        this.moveOnce = (index, direction) => {
            if (this.canMove(index, direction)) {
                [this.chronology.newOrder[index], this.chronology.newOrder[index + direction]] =
                    [this.chronology.newOrder[index + direction], this.chronology.newOrder[index]];
                return true;
            }
            return false;
        }

        this.move = (event, direction) => {
            let index = event.item.index;
            let success = false;
            do {
                success = this.moveOnce(index, direction);
                index += direction;
            } while (success && event.shiftKey);
            this.dispatch('episode-moved',{});
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

        this.listen('order-update', d => {
            this.update();
        });

    </script>
</episode-list>
