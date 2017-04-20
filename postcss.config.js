function getPlugins() {
    "use strict";
    var plugins = [
        // Autoprefixer: Adjust our CSS automagically to match the same browsers we compile JS for.
        require('autoprefixer')({
            "browsers": [
                "> 5%"
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
