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
    var capacity, days, hours, interval, lesson, lessondict, page, treshold, xp;
    lessondict = {
      3: 200,
      6: 400,
      9: 6000,
      12: 8000,
      15: 10000,
      18: 12000
    };
    this.initTimer();
    interval = 0;
    lesson = 1;
    treshold = 0;
    capacity = 40;
    days = 0;
    hours = 0;
    xp = 0;
    xp = xp;
    page = PageStore.getPageFromKey(this.props.page || "/");
    return {
      page: page,
      lesson: lesson,
      lessondict: lessondict,
      capacity: capacity,
      xp: xp,
      days: days,
      hours: hours,
      treshold: treshold
    };
  },
  initTimer: function() {
    return setInterval(this.updateTick, 500);
  },
  lowerCapacity: function(val) {
    if (this.state.capacity >= val && this.canMakeLesson()) {
      this.setState({
        capacity: this.state.capacity - val
      });
      this.addPoints(Math.floor(Math.random() * 100));
      return this.addLesson();
    } else {
      if (this.canMakeLesson()) {
        return console.log('take a rest dude!');
      }
    }
  },
  canMakeLesson: function() {
    return this.checktreshold();
  },
  addPoints: function(num) {
    return this.setState({
      xp: this.state.xp + num
    });
  },
  checktreshold: function() {
    console.log('@state.xp ' + this.state.xp + ' >? ' + this.state.treshold);
    if (this.state.lessondict[this.state.lesson]) {
      this.state.treshold = this.state.lessondict[this.state.lesson];
    }
    if (this.state.xp >= this.state.treshold) {
      return true;
    }
    console.log('lesson locked: train dude!');
    return false;
  },
  addLesson: function() {
    return this.setState({
      lesson: this.state.lesson + 1
    });
  },
  acomplishLesson: function() {
    return this.lowerCapacity(Math.floor(Math.random() * 20) + 10);
  },
  acomplishTraining: function() {
    return this.addPoints(Math.floor(Math.random() * this.state.lesson * 2.3));
  },
  addHour: function() {
    if (this.state.hours < 24) {
      return this.setState({
        hours: this.state.hours + 1
      });
    } else {
      this.setState({
        days: this.state.days + 1
      });
      return this.setState({
        hours: 0
      });
    }
  },
  updateTick: function() {
    this.addHour();
    if (this.state.capacity < 40) {
      return this.setState({
        capacity: this.state.capacity + 1
      });
    }
  },
  lessonControl: function() {
    return React.DOM.button({
      "onClick": this.acomplishLesson
    }, "make Lesson ", this.state.lesson);
  },
  trainerControl: function() {
    React.DOM.p(null, "test");
    return React.DOM.button({
      "onClick": this.acomplishTraining
    }, "use trainer");
  },
  render: function() {
    var capacity, days, hours, page, xp;
    page = this.state.page;
    capacity = this.state.capacity;
    xp = this.state.xp;
    days = this.state.days;
    hours = this.state.hours;
    return React.DOM.div({
      "id": "pagebody"
    }, React.DOM.h1(null, page.name), React.DOM.img({
      "src": page.logo
    }), React.DOM.p(null, days, " days ", hours, " hours"), React.DOM.div(null, "capacity: ", capacity), this.lessonControl(), React.DOM.p(null, "Points : ", xp), this.trainerControl());
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