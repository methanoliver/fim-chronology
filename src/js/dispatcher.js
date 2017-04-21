'use strict';

import riot from "riot";

// This is a simple 'global observable' event dispatcher.
// Tags come and go, so they require a mixin to interact with it.

// Note: It's probable that this isn't really the correct way to do this, syntactically.
// See https://gist.github.com/continuata/c605846751c09a5e94d12ae8c91cbf05
// It works, so I'm not going to mess with it for now.

let Dispatcher = riot.observable();

let DispatcherMixin = {
    init: function () {
        // Hook up so that on unmount, bus observers are dismounted.
        this._listeners = [];
        this.on('unmount', () => {
            this._listeners.forEach(el => {
                Dispatcher.off(el.event, el.listener);
            });
        });
    },
    dispatch: function (event, args) {
        // This is just a shim so that a tag doesn't have to import anything at all once the mixin is in.
        Dispatcher.trigger(event, args);
    },
    listen: function (event, listener) {
        // When you want to do something on dispatcher response, use this to create the event,
        // so that on unmount it automatically goes away.
        Dispatcher.on(event, listener);
        this._listeners.push({event: event, listener: listener});
        return listener;
    },
    unlisten: function (event, listener) {
        // If we need to remove a listener prematurely, likewise, also remove the mention of it.
        this._listeners = this._listeners.filter(function (el) {
            if (el.event === event && el.listener === listener) {
                Dispatcher.off(el.event, el.listener);
                return false;
            }
            return true;
        });
    }
};

export {Dispatcher, DispatcherMixin};
