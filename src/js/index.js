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

let DataMixin = {
    init: function() {},
    chronology: data,
    markdown: MarkdownIt({
        quotes: '“”‘’',
        linkify: true,
        html: true,
        typographer: true
    }),
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
    }
};

function capitalize(str) {
    return str[0].toUpperCase() + str.slice(1);
};

// Programmatically generate season change markers:

for (let i = 1; i <= DataMixin.chronology.years; i++) {
    let previousMarker = null;
    ['summer', 'autumn', 'winter', 'spring'].forEach(season => {
        let markerID = `SM${i}-${season.substring(0,2).toUpperCase()}`;
        DataMixin.chronology.episodes[markerID] = {
            title: `${capitalize(season)}, Year ${i}`,
            [season]: true,
            after: previousMarker ? new Array(previousMarker) : null,
            virtual: true,
            comment: "This is not a real episode, but a virtual season " +
                "change marker.\n\nIt denotes the start of " +
                `${season} of year ${i} of the series.`
        };
        previousMarker = markerID;
    });
}

console.log(DataMixin.chronology);

DataMixin.chronology.newOrder = DataMixin.chronology.order.slice();

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
