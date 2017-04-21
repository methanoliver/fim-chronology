import riot from "riot";

import MarkdownIt from 'markdown-it';

import {DispatcherMixin} from "./dispatcher.js";

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
    })
};

DataMixin.chronology.newOrder = DataMixin.chronology.order.slice();

riot.mixin(DataMixin);
riot.mixin(DispatcherMixin);

riot.mount('navigation-menu');
riot.mount('build-number');
riot.mount(
    document.getElementById('intro-text'),
    'raw-markdown', {text: introText});
riot.mount('episode-list');
