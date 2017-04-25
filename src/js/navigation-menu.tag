<navigation-menu>
    <div class="nav-left">
        <p class="nav-item">
            My Little Chronology
        </p>
    </div>
    <span class="nav-toggle" onclick="{openMenu}">
        <span></span>
        <span></span>
        <span></span>
    </span>
    <div class="{ menuClasses }">
        <a href="#intro-text"
           onclick="{passthrough}"
           class="nav-item">Introduction</a>
        <a href="#nav-list-top"
           onclick="{passthrough}"
           class="nav-item">Top</a>
        <a href="#nav-list-bottom"
           onclick="{passthrough}"
           class="nav-item">Bottom</a>
        <a onclick="{toggle}" class="nav-item" title="Show episode commentary" if="{collapsed}">
            <span class="extra-menu-desc is-hidden-tablet">Show commentary </span><span class="icon _icon nav_icon">h</span></a>
        <a onclick="{toggle}" class="nav-item" title="Hide episode commentary" if="{!collapsed}">
            <span class="extra-menu-desc is-hidden-tablet">Hide commentary </span><span class="icon _icon nav_icon">g</span></a>
        <div class="nav-item">
            <div class="field is-grouped">
                <p class="control">
                    <a href="{ saveorder() }"
                       onclick="{passthrough}"
                       ref="save"
                       title="Bookmark or copy this link to save your ordering"
                       class="button is-success">Save</a>
                </p>
                <p class="control">
                    <a onclick="{download}"
                       ref="download"
                       class="button is-primary"
                       title="Download the order as a CSV file"
                       target="_blank">Export CSV</a>
                </p>
            </div>
        </div>
        <div class="nav-item">
            <div class="field is-grouped">
                <p class="control">
                    <button class="button is-warning"
                            title="Reset to default"
                            onclick="{reset}">Reset</button>
                </p>
                <p class="control">
                    <button class="button is-danger"
                            onclick="{airing}"
                            title="Reset to airing order">Airing order</a>
                </p>
            </div>
        </div>
    </div>
    <script>

        import Papa from "papaparse";

        this.collapsed = false;
        this.menuClasses = {
            "nav-right": true,
            'nav-menu': true,
            'is-active': false
        };

        this.openMenu = e => {
            this.menuClasses['is-active'] = !this.menuClasses['is-active'];
        };

        this.passthrough = e => {
            this.menuClasses['is-active'] = false;
        }

        this.toggle = e => {
            this.collapsed = !this.collapsed;
            this.passthrough(e);
            this.dispatch('collapse-change', this.collapsed);
        };

        this.download = e => {
            this.passthrough();
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
        };

        this.reset = e => {
            this.passthrough();
            this.chronology.newOrder = this.chronology.order.slice();
            this.removeHash();
            this.dispatch('order-update',{});
        };

        this.airing = e => {
            this.passthrough();
            this.chronology.newOrder.sort();
            this.removeHash();
            this.dispatch('order-update',{});
        };

        this.listen('episode-moved', data => {
            this.update();
        });

        this.saveorder = () => {
            return document.URL.replace(/#.*$/, "") + '#!' + this.chronology.newOrder.join(',');
        };

    </script>
</navigation-menu>
