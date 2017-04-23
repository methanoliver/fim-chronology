<episode-card class="card" id="ep-{episode}">
    <header class="card-header">
        <p class="card-header-title">
            <virtual if="{chronology.episodes[episode].link}">
                <a href="{chronology.episodes[episode].link}">
                    {episode}: {chronology.episodes[episode].title}</a>
            </virtual>
            <virtual if="{!chronology.episodes[episode].link}">
                {chronology.episodes[episode].title}
            </virtual>
        </p>
        <p class="card-header-icon"
           data-is="seasons"
           episode="{episode}">
        </p>
        <p class="card-header-icon card-eye-icon">
            <a onclick="{toggle}" title="Show episode commentary" if="{collapsed}">
                <span class="icon _icon">h</span></a>
            <a onclick="{toggle}" title="Hide episode commentary" if="{!collapsed}">
                <span class="icon _icon">g</span></a>
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
                    disabled="{!parent.canMove(index, episode, -1)}"
                    onclick="{parent.moveUp}">
                Earlier <span class="_icon">f</span>
            </button>
            <button class="button button-down"
                    disabled="{!parent.canMove(index, episode, 1)}"
                    onclick="{parent.moveDown}">
                Later <span class="_icon">e</span>
            </button>
        </div>
    </footer>
    <script>
        import "./raw-markdown.tag";
        import "./episode-blocker-list.tag";
        import "./seasons.tag";

        this.collapsed = false;

        this.toggle = e => {
            this.collapsed = !this.collapsed;
        }

        this.listen('collapse-change', data => {
            this.collapsed = data;
            this.update();
        });

    </script>
</episode-card>
