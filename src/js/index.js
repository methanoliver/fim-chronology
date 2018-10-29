import riot from "riot";

import MarkdownIt from 'markdown-it';

import { DispatcherMixin } from "./dispatcher.js";

import "./navigation-menu.tag";
import "./build-number.tag";
import "./episode-list.tag";
import "./raw-markdown.tag";

import styles from "../css/main.scss";
import data from "../data/data.yaml";
import introText from "../data/intro.md";

// This is a bit of a hack: We use hash-navigation a lot in this project,
// and there's a floating navbar menu now which obscures the targeted object.
// So we just scroll down on hash change.

window.addEventListener(
    "hashchange", () => {
        scrollBy(0, -60);
    });


// Programmatically generate season change markers:

function capitalize(str) {
    return str[0].toUpperCase() + str.slice(1);
};

let seasons = [];

for (let i = 1; i <= data.years; i++) {
    for(let season of ['summer', 'autumn', 'winter', 'spring']) {
        seasons.push({
            s: season,
            y: i
        });
    }
}

let previousMarker = null;
let markerID = null;

seasons.forEach(sm => {
    markerID = `SM${sm.y}-${sm.s.substring(0,2).toUpperCase()}`;
    data.episodes[markerID] = {
        title: `${capitalize(sm.s)}, Year ${sm.y}`,
        [sm.s]: true,
        after: previousMarker ? new Array(previousMarker) : null,
        virtual: true,
        comment: `${capitalize(sm.s)} of year ${sm.y} of the series starts.`
    };
    previousMarker = markerID;
});


// If the user came in with an order hash, use this to make the order.
// Otherwise make a copy of our default order.
// In both cases ensure all defined episodes are listed.

let definedEps = Object.keys(data.episodes);
let missingEps = definedEps.filter(x => !data.order.includes(x));
data.order = data.order.concat(missingEps);

if (window.location.hash.startsWith('#!')) {
    let userOrder = window.location.hash.replace('#!', '').split(',');
    let missingEps = definedEps.filter(x => !userOrder.includes(x));
    data.newOrder = userOrder.concat(missingEps);
} else {
    data.newOrder = data.order.slice();
}

// To speed things up a bit, pre-render Markdown episode commentary and store it with them:
let md = MarkdownIt({
        quotes: '“”‘’',
        linkify: true,
        html: true,
        typographer: true
});

definedEps.forEach(ep => {
    data.episodes[ep].html = md.render(data.episodes[ep].comment || '');
});

// Finally build the mixin for the tags.

let DataMixin = {
    init: function() {},
    chronology: data,
    markdown: md,
    epData: function(episode) {
        return this.chronology.episodes[episode];
    },
    blockers: function(episode, blocker) {
        let episodeData = this.chronology.episodes[episode];
        if (!episodeData[blocker] || !episodeData[blocker].length) {
            return false;
        }
        let blockers = episodeData[blocker].slice();
        blockers.sort();
        return blockers;
    },
    before: function(episode) {
        return this.blockers(episode, 'before');
    },
    after: function(episode) {
        return this.blockers(episode, 'after');
    },
    isBefore: function(episode, target) {
        return (this.before(episode) || []).includes(target);
    },
    isAfter: function(episode, target) {
        return (this.after(episode) || []).includes(target);
    },
    optBefore: function(episode) {
        return this.blockers(episode, 'opt_before');
    },
    optAfter: function(episode) {
        return this.blockers(episode, 'opt_after');
    },
    removeHash: function() {
        history.pushState("", document.title, window.location.pathname
                          + window.location.search);
    }
};

// And boot the whole mess.

riot.mixin(DataMixin);
riot.mixin(DispatcherMixin);

riot.mount('navigation-menu');
riot.mount('build-number');
riot.mount(
    document.getElementById('intro-text'),
    'raw-markdown', {
        text: introText
    });
riot.mount('episode-list');
