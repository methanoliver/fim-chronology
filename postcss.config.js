function getPlugins() {
    "use strict";
    var plugins = [
        // Autoprefixer: Adjust our CSS automagically to match the same browsers we compile JS for.
        require('autoprefixer')({
            "browsers": [
                "> 5%",
                "last 2 edge versions",
                "last 2 firefox versions",
                "last 2 chrome versions"
            ]
        }),
        // Squeeze the remaining water out before usage.
        require('cssnano')({})
    ];

    return plugins;
}

module.exports = {
    plugins: getPlugins()
};
