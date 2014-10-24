(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';

    if (has(cache, path)) return cache[path].exports;
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex].exports;
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  var list = function() {
    var result = [];
    for (var item in modules) {
      if (has(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  globals.require = require;
  globals.require.define = define;
  globals.require.register = define;
  globals.require.list = list;
  globals.require.brunch = true;
})();
require.register("scripts/App", function(exports, require, module) {
var App, Location, Locations, Page;

Locations = ReactRouter.Locations;

Location = ReactRouter.Location;

Page = require("./components/Page");

App = React.createClass({
  displayName: "App",
  render: function() {
    return Locations({
      "hash": true
    }, Location({
      "path": "/",
      "handler": Page
    }));
  }
});

module.exports = React.renderComponent(App(null), document.getElementById("app"));
});

;require.register("scripts/components/Page", function(exports, require, module) {
var Page, PageStore;

PageStore = require("../stores/PageStore");

Page = React.createClass({
  getInitialState: function() {
    var interval, page, seconds;
    this.initTimer();
    interval = 0;
    seconds = 0;
    page = PageStore.getPageFromKey(this.props.page || "/");
    return {
      page: page,
      seconds: seconds
    };
  },
  initTimer: function() {
    return setInterval(this.updateTick, 1000);
  },
  updateTick: function() {
    return this.setState({
      seconds: this.state.seconds + 1
    });
  },
  foo: function() {
    return React.DOM.div(null, "ff", React.DOM.p(null, "nice"));
  },
  render: function() {
    var page, seconds;
    page = this.state.page;
    seconds = this.state.seconds;
    return React.DOM.div(null, React.DOM.a({
      "href": page.link
    }, React.DOM.h1(null, page.name), React.DOM.img({
      "src": page.logo
    }), React.DOM.div(null, "Timer"), React.DOM.p(null, seconds), this.foo()));
  }
});

module.exports = Page;
});

;require.register("scripts/stores/PageStore", function(exports, require, module) {
var PageStore, _pages;

_pages = {
  "/": {
    key: "/",
    name: "Hello World",
    link: "http://facebook.github.io/react",
    logo: "images/react.png"
  }
};

PageStore = {
  getPageFromKey: function(key) {
    if (!_pages.hasOwnProperty(key)) {
      return null;
    }
    return _pages[key];
  },
  getAll: function() {
    return _pages;
  }
};

module.exports = PageStore;
});

;
//# sourceMappingURL=app.js.map