import riot from "riot";

import MarkdownIt from 'markdown-it';

import "./build-number.tag";
import "./episode-list.tag";
import "./raw-markdown.tag";

import styles from "../css/main.scss";
import data from "../data/data.yaml";
import introText from "../data/intro.md";

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

riot.mount('build-number');
riot.mount(
    document.getElementById('intro-text'),
    'raw-markdown', {text: introText});
riot.mount('episode-list');
