<navigation-menu>
    <a href="#intro-text" class="nav-item">Introduction</a>
    <a href="#nav-list-top" class="nav-item">Episodes</a>
    <a href="#save-load" class="nav-item">Save/Load</a>
    <a onclick="{toggle}" class="nav-item" show="{collapsed}">
        <span class="icon _icon nav_icon">h</span></a>
    <a onclick="{toggle}" class="nav-item" show="{!collapsed}">
        <span class="icon _icon nav_icon">g</span></a>
    <script>
        this.collapsed = false;

        this.toggle = e => {
            this.collapsed = !this.collapsed;
            this.dispatch('collapse-change', this.collapsed);
        };
    </script>
</navigation-menu>
