var path = require("path");
var webpack = require('webpack');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var childProcess = require('child_process');
var dateFormat = require('dateformat');
var es6_files = /\.(js|jsx|es6)($|\?)/i;

var ExtractTextPlugin = require("extract-text-webpack-plugin");

var extractSass = new ExtractTextPlugin({
    filename: "[name].min.css"
});


// The babel configuration we use, determined by which browsers we want to support.
var babel_options = {
    // We only support browsers with 5% share of the browser market or higher, because otherwise the
    // amount of polyfills involved becomes simply unholy.

    presets: [
        ['env', {
            "targets": {
                "browsers": [
                    // "last 2 versions",
                    "> 5%"
                ]
            },
            "modules": false,
            // this enables the polyfill selector:
            "useBuiltIns": true
            // Uncomment this to see what actually gets selected:
            //"debug": true
        }]
    ]
};

module.exports = {
    context: __dirname,

    entry: {
        main: [
            "babel-polyfill",
            path.resolve(__dirname, 'src/js/index.js')
        ]
    },

    output: {
        path: path.resolve(__dirname, 'dist/static/'),
        filename: "[name].min.js"
    },

    plugins: [
        // These libraries will be auto-imported whenever any of them is mentioned in the code.
        new webpack.ProvidePlugin({
            riot: 'riot'
        }),

        // Copy our other files over to the build directory.
        new CopyWebpackPlugin([
            {
                from: path.resolve(__dirname, 'src/html/index.html'),
                to: path.resolve(__dirname, 'dist/index.html')
            }
        ]),

        new webpack.DefinePlugin({
            __BUILD_NUMBER__: JSON.stringify(
                childProcess.execSync('git rev-list HEAD --count').toString()
            ),
            __BUILD_DATE__: JSON.stringify(
                dateFormat(new Date(), "yyyy-mm-dd")
            )
        }),

        new webpack.SourceMapDevToolPlugin({
            test: /\.(js|jsx|es6|tag)($|\?)/i,
            filename: "[name].js.map",
            append: ""
        }),

        new webpack.optimize.UglifyJsPlugin({
            sourceMap: true
        }),

        extractSass

    ],

    // These libraries are assumed to be provided externally, through the site root templates.
    externals: {
        // library name : variable name.
        // "jquery": "$"
    },

    module: {
        rules: [
            {
                // Riot tag loader.
                test: /\.tag$/i,
                exclude: /node_modules/,
                use: [{
                    // Step 1: pre-compile the tag.
                    // Extracts the tag code and html and sort them into pieces.
                    // We tell the tag that it has script type 'none' so that it
                    // doesn't process the script.
                    // TODO: Figure out how to pass options to SCSS so we can give it include paths.
                    loader: 'riot-tag-loader',
                    options: {
                        type: 'none',
                        style: 'scss',
                        hot: false
                    }
                },
                    {
                        // Step 2: feed what results into babel,
                        // processing the resulting code assuming it is proper es6 code,
                        // using the presets we configured above.
                        // Theoretically, riot compiler could do this for us,
                        // but we don't want them to do it because that would lose us the source maps.
                        loader: 'babel-loader',
                        options: babel_options
                    }
                    // Webpack is a bit silly and applies loaders BACKWARDS when chained in 'use'.
                    // So we just reverse the list for clarity
                ].reverse()
            },
            {
                // Generic JS loader: All our code that webpack processes should be treated as es6
                // and use the same babel configuration.
                test: es6_files,
                loader: 'babel-loader',
                exclude: /node_modules/,
                query: babel_options
            },
            {
                test:  /\.(txt|md)$/i,
                use: 'raw-loader'
            },
            {
                // SCSS loader.
                test: /\.s[ac]ss$/,
                use: extractSass.extract({
                    use: [
                        { loader: "sass-loader" },
                        { loader: "postcss-loader" },
                        { loader: "css-loader" }
                    ].reverse(),
                    fallback: "style-loader"
                })
            },
            {
                // Image loader.
                test: /\.(jpe?g|png|gif|svg)$/i,
                use: [
                    { loader: 'file-loader' }
                ].reverse()
            },
            {
                test: /\.json$/i,
                use: 'json-loader'
            },
            {
                test: /\.yaml$/i,
                use: [
                    { loader: 'yaml-loader'},
                    { loader: 'json-loader'}
                ].reverse()
            },
            {
                test: /\.svg$/i,
                use: [
                    { loader: 'svg-loader' }
                ].reverse()
            },
            {
                test: /\.(eot|svg|ttf|woff|woff2)$/i,
                use: [
                    { loader: 'file-loader' }
                ].reverse()
            }
        ]
    },

    resolve: {
        modules: [
            'node_modules'
        ],
        extensions: ['.js', '.json', '.es6', '.tag']
    }

};
