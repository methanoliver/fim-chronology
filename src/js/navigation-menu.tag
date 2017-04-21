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
        <a href="#intro-text" onclick="{passthrough}" class="nav-item">Introduction</a>
        <a href="#nav-list-top" onclick="{passthrough}" class="nav-item">Episodes</a>
        <a href="#save-load" onclick="{passthrough}" class="nav-item">Save/Load</a>
        <a onclick="{toggle}" class="nav-item" title="Show episode commentary" if="{collapsed}">
            <span class="extra-menu-desc is-hidden-tablet">Show commentary </span><span class="icon _icon nav_icon">h</span></a>
        <a onclick="{toggle}" class="nav-item" title="Hide episode commentary" if="{!collapsed}">
            <span class="extra-menu-desc is-hidden-tablet">Hide commentary </span><span class="icon _icon nav_icon">g</span></a>
    </div>
    <script>
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
    </script>
</navigation-menu>
